.. _ansible-deployment_strategy:

.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: raw-html(raw)
   :format: html

.. _sssec-ansible_deployment_overview:

Overview
------------------------

The proposed architecture aims to provision a system by following the steps below:

#. Create ansible's directory hierarchy, playbooks, roles, taskfiles, etc.
   (basically,the logic that will be used to provision the system), and
   maintain it under version control.
#. ssh into the master node and download the repo from version control.
   Consider using read-only deploy keys to download the repo without having
   to type an username and password; especially in unattended deployments.
#. Run a one-shot script
   to perform an initial setup of the environment required for ansible
   to run properly during and after deployment, followed by the actual
   software execution (see :numref:`sssec-ansible_bootstrap`).
#. Check the bootstrap log and verify there were no errors and/or
   unexpected behaviors.
#. If errors arose, fix them and re-run the bootstrap script.

.. _sssec-ansible_logic:

Provisioning logic
------------------

Directory hierarchy
~~~~~~~~~~~~~~~~~~~

The logic should consider constant creation of new playbooks, roles, taskfiles, etc.,
allowing to easy scale in the future. Take the example below:

   .. code-block:: bash

      # tree /etc/ansible
      .
      ├── ansible.cfg
      ├── environments
      │   ├── dev
      │   │   ├── group_vars
      │   │   └── inventory
      │   └── prod
      │       ├── group_vars
      │       └── inventory
      ├── playbooks
      │   ├── playbook_1.yml
      │   ├── playbook_2.yml
      │   └── playbook_n.yml
      ├── roles
      │   ├── role_1
      │   │   ├── handlers
      │   │   │   └── main.yml
      │   │   ├── tasks
      │   │   │   └── main.yml
      │   │   ├── templates
      │   │   └── vars
      │   │       └── main.yml
      │   ├── role_2
      │   │   ├── handlers
      │   │   │   └── main.yml
      │   │   ├── tasks
      │   │   │   └── main.yml
      │   │   ├── templates
      │   │   └── vars
      │   │       └── main.yml
      │   └── role_n
      │       ├── handlers
      │       │   └── main.yml
      │       ├── tasks
      │       │   └── main.yml
      │       ├── templates
      │       └── vars
      │           └── main.yml
      ├── scripts
      │   ├── bootstrap.sh
      │   └── vault-client.sh
      └── site.yml

It is designed so that upon calling :bash:`site.yml` tasks from a particular set of playbooks,
from the :bash:`playbooks` folder, are applied. This behavior can be accomplished by
manually importing the playbooks or using variables:

+------------------------------------------------+-------------------------------------------------------+
| Importing playbooks                            | Using variables                                       |
+------------------------------------------------+-------------------------------------------------------+
| .. code-block:: yaml                           | .. code-block:: yaml                                  |
|                                                |                                                       |
|    # /etc/ansible/site.yml                     |    # /etc/ansible/environments/prod/group_vars/group1 |
|    ---                                         |    ---                                                |
|    - import_playbook: playbooks/playbook_1.yml |    playbook: playbook_1                               |
|    - import_playbook: playbooks/playbook_2.yml |                                                       |
|    - import_playbook: playbooks/playbook_n.yml |    # /etc/ansible/environments/prod/group_vars/group2 |
|                                                |    ---                                                |
|                                                |    playbook: playbook_2                               |
|                                                |                                                       |
|                                                |    # /etc/ansible/environments/prod/group_vars/groupN |
|                                                |    ---                                                |
|                                                |    playbook: playbook_n                               |
|                                                |                                                       |
|                                                | .. code-block:: yaml                                  |
|                                                |                                                       |
|                                                |     # /etc/ansible/site.yml                           |
|                                                |    ---                                                |
|                                                |    - import_playbook: "playbooks/{{ playbook }}.yml"  |
|                                                |                                                       |
+------------------------------------------------+-------------------------------------------------------+

One could couple all playbooks inside :bash:`site.yml`, but that would make future scalability difficult
and potentially cause problems if a large number of people is working on the same project
(take *git* merge conflicts for example).

If one-shot playbooks (playbooks that run only once, such as whose involving firmware updates) are to be managed,
it is recommended to modify the directory hierarchy so that the :bash:`playbooks` folder holds
them. For example:

.. code-block:: bash

   .
   └── playbooks
       ├── auto
       │   ├── playbook_1
       │   ├── playbook_2
       │   └── playbook_n
       └── manual
           ├── playbook_1
           ├── playbook_2
           └── playbook_n

which would be run like:

.. note::

   More options can be used, but they will mostly depend on the playbook's functionality.

.. code-block:: bash

   ansible-playbook -i /path/to/inventory \
                    /path/to/ansible/playbooks/manual/<playbook>

Ansible launcher
~~~~~~~~~~~~~~~~~~

Using multiple environments, launching ansible from a non-standard location, among others may result
in a large inconvinient command. Furthermore, if a run is to be triggered by an external entity,
such as a script that requires ansible to run certain tasks within particular servers (see :numref:`sssec-ansible_tags_example`),
additional concerns arise (e.g. What if I run ansible while it is already running? how to control the number of runs
at a given time?).

To solve the abovementioned issues one can create a template ansible will render as a script:

.. literalinclude:: src/templates/run_ansible.j2
   :language: bash
   :linenos:

In order to allow for easy migration of the script to, for example, another folder while still pointing
to the project sources the template obtains one variable, *ansible_log_dir*, from :bash:`group_vars`
and the remaining two from the bootstrap script. This is corroborated
in line 47 from :numref:`sssec-ansible_bootstrap`, where there are two *extra vars* (env, repo_dir)
passed to :bash:`ansible-playbook`; all of which are dynamically discovered just before the first run.

On subsequent runs, :bash:`run_ansible` will keep passing down these values recursively. One could argue it is better
to just place the task inside a one-shot playbook; this implies, however, that modifications made to the template
should be applied manually and if the rendered script is changed it would not be restored automatically.

Scheduled run
~~~~~~~~~~~~~

It would be tedious to manually run ansible every time a change is done to the project. A nice approach to
schedule when one wants provisioning to occur is creating a task to install a cron managing
the time at which to call ansible:

.. hint::

   Given the limited environment in which crons are run, one may need to add
   a task such as:

   .. code-block:: yaml

      - name: Adding PATH variable to cronfile
	cron:
	  name: PATH
	  user: root
	  env: yes
	  value: /bin:/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
	  cron_file: ansible_scheduled_run

   or, if your launcher is written in bash, make it act as if it had been invoked as a login shell
   by using the :bash:`-l` option (:bash:`#!/bin/bash -l`).

.. code-block:: yaml

   - name: Schedule ansible to run every 30 minutes
     cron:
       name: "run ansible every 30 minutes"
       user: root
       minute: "*/30"
       job: "/path/to/run_ansible"
       cron_file: ansible_scheduled_run

.. _sssec-ansible_bootstrap:

bootstrap
---------

By means of a few initial instructions the script should install ansible
in the target system, prepare the environment it requires and
trigger its first run. To further review whether the bootstrap failed
or succeeded, and take apropriate actions, it is strongly recommended to log
the output. Take the following program for example:

.. literalinclude:: src/scripts/bootstrap.sh
   :language: bash
   :linenos:

After running the script, there should be a cronfile in /etc/cron.d and a rendered
version of the run_ansible script.

Example
-------

#. Create directory tree

   .. code-block:: bash

      cd /some/dir/
      mkdir -p ansible
      cd ansible && git init
      git remote add origin <uri>
      mkdir -p {playbooks,environments,roles,scripts}
      mkdir -p roles/master/{tasks,templates}
      mkdir -p environments/production/group_vars/
      # Create the appropriate files according to your needs.
      # A good start would be:
      #touch site.yml \ # Calls the master.yml playbook
      #      playbooks/master.yml \ # Calls the master role
      #      roles/master/tasks/main.yml \ # Renders template
      #      roles/master/templates/run_ansible.j2
      #      environment/production/inventory
      #      environment/production/group_vars/all

#. Download repo

   .. note::

      Consider using read-only deploy keys to download the repo without having
      to type an username and password; especially in unattended deployments.

   .. code-block:: bash

      ssh <user>@<server>
      cd /usr/local/
      git clone <uri>

#. Bootstrap. Suppose you run the bootstrap script from
   :bash:`/usr/local/ansible/scripts/`, which discovers and passes two variables to ansible: *env* and *repo_dir*:

   .. literalinclude:: src/scripts/bootstrap.sh
      :language: bash
      :linenos:
      :lines: 18-23,45-50
      :emphasize-lines: 9

   Executing the script in a production environment, like :bash:`bootstrap.sh prod`, will cause
   variables to be passed to ansible as :bash:`env=production` and :bash:`repo_dir=/usr/local/ansible/`;
   therefore producing a :bash:`run_ansible` script pointing to :bash:`/usr/local/ansible/`.

#. Check for errors

   .. code-block:: bash

      less bootstrap_run.log
