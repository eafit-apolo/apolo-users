.. _ansible-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

Ansible
=====================

.. _ssec-ansible_basicinfo:

Basic information
---------------------

- **Official Website:** https://www.ansible.com/
- **License:** `GNU GPL v3`_

  .. _GNU GPL v3: https://www.gnu.org/licenses/gpl-3.0.html

- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`

.. _ssec-ansible_preliminaries:

Preliminaries
---------------------

Information contained within this section elucidate the basic usage of
ansible's common features (i.e. those which, at the very least, allow
it to perform simple tasks).

.. toctree::
   :maxdepth: 2
   :numbered:

   preliminaries

.. _ssec-ansible_dynamic-control:

Dynamic control
---------------

This section describes mechanisms to control which tasks are to be
executed in a particular run.

.. toctree::
   :maxdepth: 2
   :numbered:

   dynamic_control

.. _ssec-ansible_deployment-strategies:

Deployment strategy
---------------------

Ensuring the system’s state remains as desired after deployment
requires constant monitoring of configuration files, daemons (services), etc.
Bearing this in mind, employing a self-aware architecture—in which tasks
are not run once, but repeatedly and their actions are performed
based on checking the system state—is a reasonable choice.

To further ease deployment one may find useful to provision a server, or set of servers,
by using wrappers triggering ansible’s execution, one-shot playbooks and scripts.

This section proposes an architecture integrating all the abovementioned ideas.

.. toctree::
   :maxdepth: 2
   :numbered:

   deployment_strategy

.. _ssec-ansible_tips_tricks:

Tips and tricks
---------------

.. toctree::
   :maxdepth: 2
   :numbered:

   tips_and_tricks

.. _ssec-ansible_troubleshooting:

Troubleshooting
---------------------

.. toctree::
   :maxdepth: 2
   :numbered:

   troubleshooting


Authors
---------------------

- Tomás Felipe Llano-Rios <tllanos@eafit.edu.co>
