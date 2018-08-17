.. _nagios-core-4.4.1-index:

.. role:: bash(code)
   :language: bash

.. role:: yaml(code)
   :language: yaml

Nagios Core - 4.4.1
====================

Basic information
-----------------

- **Deploy date:** 14th August, 2018
- **Official Website:** https://www.nagios.org/about/
- **License:** Nagios Open Software License, Nagios Software License, GNU GENERAL PUBLIC LICENSE

Installation
------------

This entry covers the entire process performed for the installation and
configuration of Nagios Core in Centos 7. This process of installation and configuration
is automated using Ansible.

.. toctree::
   :maxdepth: 4

   installation

Plugins
-------

.. toctree::
   :maxdepth: 1

   plugins/nagios-plugins
   plugins/ipmi-sensors
   plugins/dell-emc-openmanage
   plugins/ilo-rest
   
Usage
-----

Before executing the role it's important to verify the value of the variables in the file
:bash:`roles/healthckeck/vars/main.yml`. These variables were created in order to uncouple from the code things like IPs, URLs and passwords. In the case of passwords, we used **Ansible Vault** for ciphering them.

.. code-block:: bash

   ansible-vault playbooks/healthcheck.yml --ask-vault-pass

.. caution::
   
   This Ansible role was created thinking in the Ansible Philosophy: **The tool should be used to represent the state of the server, not as a procedural language but as a declarative one.**

   This role was developed to be run multiple times in the same server: If the real state doesn't matches with the role state, the server is modified in order to match both states. If the server has well configured and well installed Nagios and it's plugins, running the playbook will say **Ok** in most of the tasks, so it  won't broke any configuration.

.. note::

   The flag :bash:`--ask-vault-pass` is used because this role uses ansible-vault for encrypting private data as passwords.


Authors
-------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
