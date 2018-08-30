.. _nagios-core-4.4.1-installation:

.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: yaml(code)
   :language: yaml
      
Installation
=============

.. contents:: Table of Contents	      

**Tested on (Requirements)**
----------------------------

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


Ansible Structure
-----------------
We implemented a Role in Ansible that contains the whole proccess of installation and configuration of Nagios and it's integration with some plugins.

.. literalinclude:: src/tasks/main.yml
   :language: bash

Initial Configuration
---------------------

dell-repos.yml
______________

This procedure is neccessary in order to install the package **srvadmin-idrac7** from the official Dell repo.
This makes it easier to check the presence/absence of the packages using the ansible-module "yum" instead
of writing mannually the process of compilation and verification.

.. literalinclude:: src/tasks/dell-repos.yml
   :language: yaml

packages.yml
____________

This taskfile contains the dependencies for using some Ansible modules and for installing Nagios
core and it's plugins.

======================  ====================================================================
System Packages         Description
======================  ====================================================================
Python-passlib          Dependency of Ansible HTPASSWD Module
Python2-pip             PIP Installs OMSDK (Dependency of Dell Plugin)
LibSELinux-Python       Dependency of Ansible SELinux Module
PolicyCoreUtils-Python  Dependency of Ansible SELinux Module
mailx                   Provides "mail" command, used in notify nagios commands
ipmiutil                Necessary for :ref:`ipmi_sel_error`
======================  ====================================================================

The other dependencies are listed in the taskfile showed bellow.

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

.. note::
   It's important to remember that Firewalld is the firewall of the system in CentOS 7.

We will need to allow http port in the firewall configuration. The SNMP ports (161-162) should be allowed for the correct operation of iLO REST Plugin. We decided to allow these firewall requirements in the **public** zone.
   
.. literalinclude:: src/tasks/firewall-config.yml
   :language: yaml

ipmi-config.yml
________________

Assures the existence of ipmi-config directory and syncronizes the ipmi.cfg file with **root** as owner, **nagcmd** as Group owner and permissions 640: read and write for Owner and read-only for group members. If the final state of the task is **changed**, Nagios daemon is restarted.
   
.. literalinclude:: src/tasks/ipmi-config.yml
   :language: yaml

mail-config.yml
________________

Syncronizes the mail configuration file with the version located in the repository.

.. warning:: Read the section :ref:`mail-configuration` for more details.
   
.. literalinclude:: src/tasks/mail-config.yml
   :language: yaml
	      
Installing Nagios Core
----------------------
		 
nagios-install.yml
__________________

This taskfile is included only when the path /usr/local/nagios doesn't exist. This state is registered in nagios-installed.yml, with the module **stat**.

.. literalinclude:: src/tasks/nagios-installed.yml
   :language: yaml

Nagios Core is downloaded from :yaml:`{{ nagios_core_url }}` and stored in :bash:`{{ temp_dir }}`, then it is configured with **nagcmd** as the command group, and openssl enabled. Then, the MakeFile is executed as follows [1]_:

========================== =====================================================================
Make options used          Descriptions
========================== =====================================================================
make all                   .
make install               Installs main program, CGI's and HTML files
make install-init          Installs the init script
make install-commandmode   Installs and configures permissions for holding external command file
make install-config        Generates templates for initial configuration
========================== =====================================================================

.. note:: The directive :bash:`make install-webconf` is executed in :ref:`nagios-post-install`

.. literalinclude:: src/tasks/nagios-install.yml
   :language: yaml

.. _nagios-config.yml:
      
nagios-config.yml
_________________

This taskfile syncronize the Nagios config files with the ones stored in the repository, if there is a change in this syncronization, Nagios daemon is restarted with the handler :yaml:`nagios_restart`.

Then, the module **htpasswd** asigns the password stored with Ansible Vault in the variable :yaml:`{{ nagios_admin_passwd }}` using ldap_sha1 as crypt scheme and restarts Nagios daemon if the final state of the task is **changed**.

.. literalinclude:: src/tasks/nagios-config.yml
   :language: yaml

.. _nagios-post-install:

nagios-post-install.yml
_______________________

After **nagios-config.yml** is completed, :bash:`make install-webconf` is executed, generating the Apache config file for Nagios Web Interface. This step is executed only if Nagios Core was not installed before the current execution.

   .. literalinclude:: src/tasks/nagios-post-install.yml
      :language: yaml

.. _selinux-config.yml:
		 
selinux-config.yml
_______________________

.. note:: By default, the files under the directory **/usr/local/nagios/var/rw** don't
	  belongs to the **httpd_sys_rw_content_t** context. It is necessary to add these contexts
	  (this is what the taskfile does) because the way Web interface interacts with
	  Nagios is with the Command File **/usr/local/nagios/var/rw/nagios.cmd** executing
	  from **/usr/local/nagios/sbin/**

.. warning:: The error :bash:`Could not stat() command file /usr/local/nagios/var/rw/nagios.cmd`
	     is fixed by this taskfile. The explanation is in the :ref:`nagios-cmd-error` section.


.. literalinclude:: src/tasks/selinux-config.yml
   :language: yaml

		 
final-check.yml
_______________________

The final steps include removing :yaml:`{{ temp_dir }}` and checking the Nagios configuration with the command :bash:`/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg`.

This execution finishes assuring with two handlers that nagios and apache services are started.

   .. literalinclude:: src/tasks/final-check.yml
      :language: yaml


Installing Nagios Plugins
-------------------------
- :ref:`Nagios Plugins <nagios-plugins-index>`
- :ref:`IPMI Sensors <ipmi-sensors-plugin-index>`
- :ref:`Dell EMC OpenManage <dell-nagios-plugin-index>`
- :ref:`iLO AgentLess Management Plugin <ilo-rest-plugin-index>`
  
References
----------

.. [1] NagiosEnterprises/nagioscore. Retrieved August 17, 2018, from https://github.com/NagiosEnterprises/nagioscore

Authors
-------

Andrés Felipe Zapata Palacio
