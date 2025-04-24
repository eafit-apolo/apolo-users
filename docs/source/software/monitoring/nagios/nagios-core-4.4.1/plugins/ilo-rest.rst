.. _ilo-rest-plugin-index:

.. role:: bash(code)
   :language: bash


iLO AgentLess Management - Nagios Plugin
========================================

.. contents::

Basic information
-----------------

- **Official Website:** https://exchange.nagios.org/directory/Plugins/Network-and-Systems-Management/Others/A-Nagios-Plug-2Din-for-iLO-Agentless-Management-(HPE-ProLiant-Server)/details
- **License:** GPL
- **Version:** 1.5 - Nagios HPE iLO RESTful Plugin

**Tested on (Requirements)**
----------------------------

* HPE ProLiant Server
* **Nagios Core:** Version :math:`\boldsymbol{\ge}` 3.5.0

Dependencies
------------

- curl
- libcurl
- libcurl-devel
- nmap
- libtdb-devel
- python
- net-snmp-utils *(Also required by Nagios Core)*
- glibc-devel *(Also required by Nagios Core)*

Installation
------------

This taskfile is executed only if there aren't any plugins in the directory :bash:`/usr/local/nagios/libexec` that
matches the regular expression :bash:`*hpeilo*`. This state is registered in the taskfile
:bash:`nagios-plugins-installed.yml`, with the module **find**.

For more information about these registers read the section :ref:`nagios-plugins-installed.yml`.

The installation process [1]_ consists of downloading the plugin from the original repository, then it is necessary to
regenerate the configure files if the aclocal version is not 1.14. More information in the
section :ref:`aclocal-missing`. Finally, the configure, make and make install are executed.

.. literalinclude:: ../src/tasks/ilo-plugin.yml
   :language: yaml

Configuration
-------------

Synchronizes the iLO credential files and the iLO plugin configuration with the version present in the repo and
configures the permissions over Nagios credential file.

.. literalinclude:: ../src/tasks/ilo-plugin-config.yml
   :language: yaml

.. warning:: It's important to configure nagios as the owner of the nagios credential file as is described in
			 this configuration taskfile.

Usage
-----

Defining Hosts, commands and services
'''''''''''''''''''''''''''''''''''''

.. warning:: It's necessary to read the section :ref:`nagios_centos_7` before proceeding to configure.

For starting the configuration of the iLO plugin, run the following command:

.. code-block:: bash

   /usr/local/nagios/libexec/hpeilo_nagios_config

Example of simple configuration using the script:

.. code-block:: text

   Do you wish to enable passive HPE iLO host discovery (y/n) (Blank is y):
   Do you wish to enable active discovery (y/n) (Blank is y):
   Do you wish to configure host groups (y/n) (Blank is y):
   Enter host group name: ilo-4_example_group
   Enter host group "ilo-4_example_group" IP range: 192.168.1.10
   Enter host group "ilo-4_example_group" SNMP read-only community string (Blank default value  public):
   Enter host group "ilo-4_example_group" SNMP Trap community string (Blank default value  public):
   Do you wish to add one more host group (y/n) (Blank is n):
   Enter host group check interval time in minutes (Blank default value - 5 minutes ): 1
    default is exists. Do you wish to update or not? (y/n): n
   Do you wish to configure iLO credential for single server if there're different with
   the default iLO credential (y/n) (Blank is n):

   **************Configured Data****************
   PASSIVE_DISCOVERY 1
   ACTIVE_DISCOVERY  1
    HOSTGROUP: ilo-4_example_group,192.168.1.10,public,public
   CHECK_INTERVAL 1
   *********************************************

   Do you wish to write above configured data to host-group configuration file. (y/n) (Blank is y):
   HPE iLO host-group configuration file saved at /usr/local/nagios/libexec/hpeilo_nagios_config.cfg.
   HPE iLO Hosts/Services discovered configuration file is existing:/usr/local/nagios/etc/ilo/ilo.cfg
   Do you wish to replace it?(y/n) (Blank is y):

With regard to the current question: If you answer NO, then the script will
save a backup in the folder :bash:`/usr/local/nagios/etc/ilo/.backup/`, and
will override the configuration file.

.. code-block:: text

   Do you wish to run configuration file to complete the process (y/n) (Blank is y):
   Running configuration  file ....
   Reading host-group configuration file : /usr/local/nagios/libexec/hpeilo_nagios_config.cfg
   Discovery using configuration file
   passive configuration enabled
   [Failed]
   Restart snmptrapd
   Redirecting to /bin/systemctl restart snmptrapd.service
   [Done]
   active configuration enabled
   Scan the network range: 192.168.1.10-192.168.1.10   with the total hosts '1'
   env: /etc/init.d/nagios: Permiso denegado
   Progress: 100% (scanned 1 of 1 hosts)
   Total hosts '1' added of '1' hosts

.. warning:: In version 1.5 of this plugin, there is an unimplemented service, so it's necessary to
	     do the procedure explained in the section :ref:`ilo_network_not_implemented`

.. note:: If you created the temporal file /etc/init.d/nagios, it's important to delete it after generating
		  the configuration of iLO plugin.

iLO Credentials
'''''''''''''''

The iLO credentials used by the plugin are cyphered and stored in the file
:bash:`/etc/nagios/.nagios_restful_credential.tdb` and can be modified with the following command:

.. code-block:: bash

   /usr/local/nagios/libexec/credit_save -H <hostname> [-V] [-h]

============================= ========================================================================
Params                        Value
============================= ========================================================================
 -H HOST                      Hostname, Host IP or default if you want to stablish default credentials
 -V                           Version number
 -h                           Prints this help information
============================= ========================================================================


Troubleshooting
---------------

.. _aclocal-missing:

aclocal-1.14 is missing
'''''''''''''''''''''''

If your version of aclocal is different than 1.14 it is necessary to regenerate the **configure** files in order to
compile correctly the plugin.

This is possible executing the command :bash:`autoreconf -vfi` in the source directory. If this is not executed,
when :bash:`./configure` is executed the following error message will appear.

.. code-block:: bash

   WARNING: 'aclocal-1.14' is missing on your system.
   You should only need it if you modified 'acinclude.m4' or
   'configure.ac' or m4 files included by 'configure.ac'.
   The 'aclocal' program is part of the GNU Automake package:
   <http://www.gnu.org/software/automake>
   It also requires GNU Autoconf, GNU m4 and Perl in order to run:
   <http://www.gnu.org/software/autoconf>
   <http://www.gnu.org/software/m4/>
   <http://www.perl.org/>

.. _nagios_centos_7:

Installation in CentOS 7
''''''''''''''''''''''''

.. warning::
   Although the official page provides a compatible version with CentOS 7, the scripts for generating
   the configuration files are written for a CentOS version that still uses init, searching information
   in the files that match the following regular expression: :bash:`/etc/init.d/nagios*`

The error will show an error output during the execution of the configuration scripts as the showed below:

.. code-block:: bash

   Do you wish to write above configured data to host-group configuration file. (y/n) (Blank is y):
   HPE iLO host-group configuration file saved at /usr/local/nagios/libexec/hpeilo_nagios_config.cfg
   grep: /etc/init.d/nagios*: No existe el fichero o el directorio
   dirname: falta un operando
   Pruebe 'dirname --help' para más información.

In this installation, CentOS 7 configured Nagios Daemon with systemd specifications, so the file
/etc/init.d/nagios* was not created.

In order not to modify the code of the iLO plugin scripts, the alternative proposed here is to generate
a temporal file :bash:`/etc/init.d/nagios` during the generation of the configuration files with
the following content:

.. code-block:: bash

   NagiosIloCfgFile=/usr/local/nagios/etc/nagios.cfg

.. _ilo_network_not_implemented:

Network Service not Implemented
'''''''''''''''''''''''''''''''

The services provided by this plugin are:

#. System Health
#. Fan
#. Memory
#. Network
#. Power Supply
#. Processor
#. Storage
#. Temperature

Although Network function is not implemented, the scripts written by the developers of the plugin generate configuration
lines for this unimplemented function. So, after generating the configuration files with the iLO plugin script, it is
necessary to remove manually this service from the service definitions generated.

It's necessary to remove the definitions of the service and the servicegroup.

Example:

.. code-block:: bash

   define servicegroup {
     servicegroup_name    Network
     members              server1, Network, server2, Network
   }

   define service {
     use                 generic-iLO-service
     hostgroup_name      group-name
     service_description Network
     check_command       nagios_hpeilo_restful_engine!4
   }

iLO Memory service in UNKNOWN state
'''''''''''''''''''''''''''''''''''

The error message displayed in the **Status information** field in the Nagios **Service Status Details** is
normal when the machine is powered off.

Message:

.. code-block:: bash

	Check iLO credit is correct saved.(/usr/local/nagios/libexec/credit_save -H 10.150.4.188)


References
----------

.. [1] "User’s Manual Nagios Plug-in for HPE iLO RESTful Extension", Hewlett Packard Enterprise (HPE). Retrieved December 3, 2018, from https://goo.gl/knRFPr.
