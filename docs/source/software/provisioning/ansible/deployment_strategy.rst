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

#. Create ansible's directory hierarchy, playbooks, roles, taskfiles, etc. Basically,
   the logic that will be used to provision the system. For example:

   .. note::

      It is recommended to have the directory tree under version control.
   

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

It is designed so that upon calling :bash:`site.yml`, tasks from a particular set of playbooks,
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


Wrappers
--------

Ansible launcher
~~~~~~~~~~~~~~~~~~


One-shot playbooks
------------------
