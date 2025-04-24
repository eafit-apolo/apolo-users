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

.. note:: It is important to check if the PyCrypto system version is greater than 2.6.1, because this is a pre-requisite that Ansible-vault needs to work correctly.

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
We implemented a Role in Ansible that contains the whole process of installation and configuration of Nagios and it's integration with some plugins.

.. literalinclude:: src/tasks/main.yml
   :language: bash

Initial Configuration
---------------------

dell-repos.yml
______________

This procedure is necessary in order to install the package **srvadmin-idrac7** from the official Dell repo.
This makes it easier to check the presence/absence of the packages using the ansible-module "yum" instead
of writing manually the process of compilation and verification.

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
   This solution uses a list of packages in the yum ansible module instead of an ansible iterator (item) because this
   specification improves the install operation, creating a complete dependency tree instead of calling "n times" the
   yum module.

.. note::
   The @ syntax in yum module specifies the item is a package group.

.. note::
   The Dell OpenManage Plugin has two lists of dependencies: The first one is installed with the "yum" module and
   the second one with the "pip" module.


.. literalinclude:: src/tasks/packages.yml
   :language: yaml

nagios-users.yml
________________

It is necessary before installing Nagios-Core to create a **Nagios** user, and a **nagcmd** group, whose
members will be **apache** and **nagios** users. It's also necessary to let nagios execute /usr/sbin/ipmi-sensors and /usr/sbin/ipmi-sel with root permissions. This is assured making it explicit in the sudoers file.

.. literalinclude:: src/tasks/nagios-users.yml
   :language: yaml

apache-config.yml
_________________

The objective is to configure Nagios to provide a Web interface, so it's necessary to write in the
**httpd.conf** file the line **Listen <IP>:80**. In this generic installation, we will insert **Listen 80**,
allowing every network interface to provide this service.

Finally, we will associate in **/etc/hosts** our **nagios_ip** with the **ServerName** set previously.

.. literalinclude:: src/tasks/apache-config.yml
   :language: yaml

firewall-config.yml
___________________

.. note::
   It's important to remember that Firewalld is the firewall of the system in CentOS 7.

We will need to allow HTTP port in the firewall configuration. The SNMP ports (161-162) should be allowed for the correct operation of iLO REST Plugin. We decided to allow these firewall requirements in the **public** zone.

.. literalinclude:: src/tasks/firewall-config.yml
   :language: yaml

ipmi-config.yml
________________

Assures the existence of ipmi-config directory and synchronizes the ipmi.cfg file with **root** as owner, **nagcmd** as Group owner and permissions 640: read and write for Owner and read-only for group members. If the final state of the task is **changed**, Nagios daemon is restarted.

.. literalinclude:: src/tasks/ipmi-config.yml
   :language: yaml

mail-config.yml
________________

Synchronizes the mail configuration file with the version located in the repository.

.. warning:: Read the section :ref:`mail-configuration` for more details.

.. literalinclude:: src/tasks/mail-config.yml
   :language: yaml

snmp-config.yml
_______________

The Dell plugin requires this previous SNMP configuration, read the section
:ref:`snmp-dell` for more details.

Synchronizes **/etc/snmp/snmptt.ini** and **/etc/snmp/snmptrapd.conf** snmp configuration files,
with the version located in the repository. If there is a modification, snmptt and snmptrapd services
are restarted. After that, those services are enabled in boot time if they were not enabled.

.. literalinclude:: src/tasks/snmp-config.yml
   :language: yaml

Installing Nagios Core
----------------------

nagios-install.yml and nagios-installed.yml
___________________________________________

This taskfile is included only when the path /usr/local/nagios doesn't exist. This state is registered in nagios-installed.yml, with the module **stat**.

.. literalinclude:: src/tasks/nagios-installed.yml
   :language: yaml

Nagios Core is downloaded from :yaml:`{{ nagios_core_url }}` and stored in :bash:`{{ temp_dir }}`, then it is configured with **nagcmd** as the command group, and openssl enabled. Then, the MakeFile is executed as follows [1]_:

========================== =====================================================================
Make options used          Descriptions
========================== =====================================================================
make all                   .
make install               Install main program, CGI's and HTML files
make install-init          Install the init script
make install-commandmode   Install and configures permissions for holding external command file
make install-config        Generates templates for initial configuration
========================== =====================================================================

.. note:: The directive :bash:`make install-webconf` is executed in :ref:`nagios-post-install`

.. literalinclude:: src/tasks/nagios-install.yml
   :language: yaml

.. _nagios-config.yml:

nagios-config.yml
_________________

This taskfile synchronize the Nagios config files with the ones stored in the repository, if there is a change in this synchronization, Nagios daemon is restarted with the handler :yaml:`nagios_restart`.

Then, the module **htpasswd** assigns the password stored with Ansible Vault in the variable :yaml:`{{ nagios_admin_passwd }}` using ldap_sha1 as crypt scheme and restarts Nagios daemon if the final state of the task is **changed**.

.. literalinclude:: src/tasks/nagios-config.yml
   :language: yaml

.. _nagios-post-install:

nagios-post-install.yml
_______________________

After **nagios-config.yml** is completed, :bash:`make install-webconf` is executed, generating
the Apache config file for Nagios Web Interface. This step is executed only if Nagios Core was
not installed before the current execution.

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

It's necessary to execute :bash:`restorecon -r <directory>` in order to restart the SELinux
configuration over these directories. This is executed by a handler in the Ansible role.

.. literalinclude:: src/tasks/selinux-config.yml
   :language: yaml


.. _nagios-plugins-installed.yml:

Installing Nagios Plugins
-------------------------

The taskfile :bash:`nagios-plugins-installed.yml` registers in ansible variables if the plugins are
installed or not.

.. literalinclude:: src/tasks/nagios-plugins-installed.yml
   :language: yaml

Read the following sections for more information about the installation and configuration process of the plugins.

- :ref:`Nagios Plugins <nagios-plugins-index>`
- :ref:`IPMI Sensors <ipmi-sensors-plugin-index>`
- :ref:`Dell OpenManage <dell-nagios-plugin-index>`
- :ref:`iLO AgentLess Management Plugin <ilo-rest-plugin-index>`
- :ref:`PNP4Nagios <pnp4nagios-plugin-index>`


Final Check
-----------

The final steps include removing :yaml:`{{ temp_dir }}` and checking the Nagios configuration with the
command :bash:`/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg`.

This execution finishes assuring with handlers that nagios and apache services are started and enabled
to start in boot time.

.. literalinclude:: src/tasks/final-check.yml
   :language: yaml


References
----------

.. [1] NagiosEnterprises/nagioscore. Retrieved August 17, 2018, from https://github.com/NagiosEnterprises/nagioscore

Authors
-------

Andrés Felipe Zapata Palacio
