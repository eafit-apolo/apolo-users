Overview
------------------------

The proposed architecture aims to provision a system by following the steps below:

#. Create ansible's directory hierarchy, playbooks, roles, taskfiles, etc. Basically,
   the logic that will be used to provision the system. For example:

   .. note::

      It is recommended to have the directory tree under version control.
   
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

#. Run a one-shot script (called bootstrap in this guide)
   to perform an initial setup of the environment required for ansible
   to run properly during and after deployment, followed by the actual
   software execution. In the example above:

   .. code-block:: bash

      bash /etc/ansible/scripts/bootstrap.sh prod
   
#. Check the bootstrap log and verify there were no errors and/or
   unexpected behaviors.
#. If errors arose, fix them and re-run the bootstrap script.

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
