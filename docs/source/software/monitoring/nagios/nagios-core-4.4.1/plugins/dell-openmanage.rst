.. _dell-nagios-plugin-index:

.. role:: bash(code)
   :language: bash

Dell OpenManage - Nagios Plugin
===================================

Basic information
-----------------

- **Official Website:** https://www.dell.com/support/home/co/es/cobsdt1/drivers/driversdetails?driverid=41y2v

- **License:** Dell Software License

- **Version:** 2.0

**Tested on (Requirements)**
----------------------------

* **Nagios Core:** Version :math:`\boldsymbol{\ge}` 3.5.0

Dependencies
------------

**PIP:**

- omsdk

- omdrivers

- argparse

**YUM:**

- perl-Sys-Syslog (SNMPTT Dependency)

- perl-Net-IP

- perl-Net-SNMP

- libwsman1

- openwsman-perl

- perl-Socket6

- snmptt

- net-snmp-perl

- srvadmin-idrac7

- java-1.8.0-openjdk

- java-1.8.0-openjdk-devel

- python-netaddr

.. _snmp-dell:

Preconfiguration
----------------

.. note:: This procedure has been automated in our Ansible healthcheck role.

1. Edit :bash:`/etc/snmp/snmptt.ini` in order to enable the DNS resolution and enhanced logging options.

.. code:: bash

	[General]
	dns_enable = 1
	net_snmp_perl_enable = 1
	translate_log_trap_oid = 1

	[Logging]
	stdout_enable = 1
	log_enable = 1
	log_file = /var/log/snmptt/snmptt.log
	log_system_enable = 1
	log_system_file = /var/log/snmptt/snmpttsystem.log
	unknown_trap_log_enable = 1
	unknown_trap_log_file = /var/log/snmptt/snmpttunknown.log

	[Debugging]
	DEBUGGING = 1
	DEBUGGING_FILE = /var/log/snmptt.debug
	DEBUGGING_FILE_HANDLER = /var/log/snmptt/snmptthandler.debug

.. note:: The following lines are added to :bash:`/etc/snmp/snmptt.ini` by the Dell plugin installation process.

.. code:: bash

		  [TrapFiles]
		  # A list of snmptt.conf files (this is NOT the snmptrapd.conf file).  The COMPLETE path
		  # and filename.  Ex: '/etc/snmp/snmptt.conf'
		  snmptt_conf_files = <<END
		  /usr/local/nagios/dell/config/templates/Dell_PowerVaultMD_Traps.conf
		  /usr/local/nagios/dell/config/templates/Dell_EqualLogic_Traps.conf
		  /usr/local/nagios/dell/config/templates/Dell_Compellent_Traps.conf
		  /usr/local/nagios/dell/config/templates/Dell_Chassis_Traps.conf
		  /usr/local/nagios/dell/config/templates/Dell_Agent_free_Server_Traps.conf
		  /etc/snmp/snmptt.conf
		  END

2. Edit :bash:`/etc/snmp/snmptrapd.conf` and add the following lines

.. code:: bash

	traphandle default /usr/sbin/snmptthandler
	disableAuthorization yes

3. Configure both SNMPTT and SNMPTRAPD services to start on boot time.

.. code:: bash

   chkconfig snmptrapd on
   chkconfig snmptt on

Installation
------------

This taskfile is executed only if the directory :bash:`/usr/local/nagios/libexec` doesn't
exist. This state is registered in the taskfile :bash:`nagios-plugins-installed.yml`, with the module **stat**.

For more information about this registers read the section :ref:`nagios-plugins-installed.yml`.

The installation process [1]_ consists of downloading and uncompressing the plugin, then the script :bash:`Dell_OpenManage_Plugin/Install/install.sh` is executed.

.. literalinclude:: ../src/tasks/dell-plugin.yml
   :language: yaml

Configuration
-------------

This playbook synchronizes the dell configuration files located in :bash:`/usr/local/nagios/dell/config/objects/` and the dell_contacts file.

.. literalinclude:: ../src/tasks/dell-plugin-config.yml

Usage
-----

The plugin has a script that discovers and generates the necessary configuration files for Dell servers present in a given IP, IP range or subnet.

To configure a specific host:

.. code:: bash

	  $ /usr/local/nagios/dell/scripts/dell_device_discovery.pl -H host -P protocol -f

============================= ========================================================
Params                        Value
============================= ========================================================
 -h, --help                   Display help text.
 -H, --host <host>            IP or hostname.
 -S, --subnet <subnet>        Subnet with mask.
 -F, --filewithiplist         Absolute path of a file with of newline separated Hosts.
 -P Protocol                  1(SNMP) 2(WSMAN).
 -f                           Force rewrite of config file.
============================= ========================================================

.. note:: If you need more information about the command, execute it with the flag :bash:`-h`

Troubleshooting
---------------

Incorrect hostname detection
''''''''''''''''''''''''''''

It's possible that the :bash:`dell_device_discovery.pl` script detects an incorrect hostname in
the discovery process (Ej: idrac8). It generates incorrect configurations because the host_name
attribute in Nagios has to be unique for each Host definition.

The solution is to edit the host definition:

.. code:: bash

	define host{
	  use                     Dell Agent-free Server
	  host_name               idrac8
	  alias                   idrac8
	  address                 192.168.1.1
	  display_name            idrac8
	  icon_image              idrac.png
	  ...                     ...
	}

	define service{
	  use                     Dell Traps
	  host_name               idrac8
	  service_description     Dell Server Traps
	}

Update the fields host_name, alias, and display_name.

.. code:: bash

	define host{
	  use                     Dell Agent-free Server
	  host_name               mgmt-master
	  alias                   mgmt-master
	  address                 192.168.1.1
	  display_name            mgmt-master
	  icon_image              idrac.png
	  ...                     ...
	}

	define service{
	  use                     Dell Traps
	  host_name               mgmt-master
	  service_description     Dell Server Traps
	}


References
-------------

.. [1] https://www.dell.com/support/article/es/es/esbsdt1/sln310619/installation-of-dell-openmanage-plugin-for-nagios-xi-on-centos?lang=en
