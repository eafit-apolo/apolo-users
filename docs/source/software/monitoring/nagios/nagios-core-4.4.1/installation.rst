.. _nagios-core-4.4.1-installation:

.. highlight:: rst

.. role:: matlab(code)
   :language: ini

.. sectnum::
   :suffix: )

.. sidebar:: Contents

   .. contents::
       :local:

Tested on (Requirements)
************************

* **OS base:** CentOS 7 (x86_64)
* **Provisioner:** Ansible :math:`\boldsymbol{\ge}` 4.4.1
* **Extra Libraries:**

  * PyCrypto :math:`\boldsymbol{\gt}` 2.6.1
    
.. note:: It is important to check if the PyCrypto system version is greater than 2.6.1, because this is a pre-requisit that Ansible-vault needs to work correctly.

Directory Structure
-------------------
.. code-block:: bash		

	.
        ├── ansible.cfg	
	├── inventory
	│   └── hosts
	├── playbooks
	│   ├── healthcheck.yml
	└── roles
	    └── healthcheck
                ├── handlers
		├── tasks
	        ├── vars
		├── templates
                └── files
  
Procedure
---------

  .. code-block:: bash

     ansible-vault playbooks/healthcheck.yml --ask-vault-pass

 .. note::

    The flag --ask-vault-pass is used because this role uses ansible-vault for encrypting private data as passwords.

Ansible Structure
-----------------
We implemented a Role in Ansible that contains the whole proccess of installation and configuration of Nagios and it's integration with some plugins.

.. literalinclude:: src/tasks/main.yml
   :language: bash

Initial Configuration
---------------------

dell-repos.yml
______________

This procedure is neccessary in order to install the packages "srvadmin-idrac7" from the official Dell repo.
This makes it easier to check the presence/absence of the packages using the ansible-module "yum" instead
of writing mannually the process of compilation and verification.

.. literalinclude:: src/tasks/dell-repos.yml
   :language: yaml

packages.yml
____________

This taskfile contains the dependencies for using some Ansible modules and for installing Nagios
core and it's plugins.

======================  =================================================================
System Packages         Description
======================  =================================================================
Python-passlib          Dependency of Ansible HTPASSWD Module
Python2-pip             PIP Installs OMSDK (Dependency of Dell Plugin)
LibSELinux-Python       Dependency of Ansible SELinux Module
PolicyCoreUtils-Python  Dependency of Ansible SELinux Module
======================  =================================================================

The other dependencies are listed in the taskfile shown bellow.

.. note::
   The @ syntaxis in yum module specifies that the item is a package group.

.. note::
   The Dell OME Plugin has two lists of dependencies: The first one is installed with the "yum" module and
   the second one with the "pip" module.


.. literalinclude:: src/tasks/packages.yml
   :language: yaml

nagios-users.yml
________________

It is necessary before installing Nagios-Core to create a **nagios** user, and a **nagcmd** group, whose
members will be the users **apache** and **nagios**. It's also necessary to let nagios execute /usr/sbin/ipmi-sensors and /usr/sbin/ipmi-sel with root permissions. This is assured making it explicit in the sudoers file.

.. literalinclude:: src/tasks/nagios-users.yml
   :language: yaml

apache-config.yml
_________________

The objective is to configure Nagios to provide a Web interface, so it's necessary to write in the
**httpd.conf** file the line **Listen <IP>:80**. In this generic installation, we will insert **Listen 80**,
allowing every network interface to provide this service. We will also write in this file the definition
of the ServerName.

Finally, we will associate in **/etc/hosts** owr **nagios_ip** with the **ServerName** set previously.

.. literalinclude:: src/tasks/apache-config.yml
   :language: yaml

firewall-config.yml
___________________

.. literalinclude:: src/tasks/firewall-config.yml
   :language: yaml


Installing Nagios Core
----------------------
		 
nagios-install.yml
__________________

.. literalinclude:: src/tasks/nagios-installed.yml
   :language: yaml

		 

.. literalinclude:: src/tasks/nagios-install.yml
   :language: yaml

nagios-config.yml
_________________

.. literalinclude:: src/tasks/nagios-config.yml
   :language: yaml

nagios-post-install.yml
_______________________

   .. literalinclude:: src/tasks/nagios-post-install.yml
      :language: yaml





Installing Nagios Plugins
-------------------------
- :ref:`Nagios Plugins <nagios-plugins-index>`
- :ref:`IPMI Sensors <ipmi-sensors-plugin-index>`
- :ref:`Dell EMC OpenManage <dell-nagios-plugin-index>`
- :ref:`iLO AgentLess Management Plugin <ilo-rest-plugin-index>`
