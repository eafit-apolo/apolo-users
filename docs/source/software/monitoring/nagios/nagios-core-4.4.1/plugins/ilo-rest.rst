.. _ilo-rest-plugin-index:

.. role:: bash(code)
   :language: bash

iLO AgentLess Management - Nagios Plugin
========================================

Basic information
-----------------

- **Official Website:** https://exchange.nagios.org/directory/Plugins/Network-and-Systems-Management/Others/A-Nagios-Plug-2Din-for-iLO-Agentless-Management-(HPE-ProLiant-Server)/details
- **License:** GPL
- **Version:** 1.5 - Nagios HPE iLO RESTful Plugin

Installation
------------

This taskfile is executed only if there aren't any plugins in the directory :bash:`/usr/local/nagios/libexec` that
matches the regular expression :bash:`*hpeilo*`. This state is registered in the taskfile
:bash:`nagios-plugins-installed.yml`, with the module **find**.

For more information about this registers read the section :ref:`nagios-plugins-installed.yml`.

The installation process consist on downloading the plugin from the original repository, then it is necessary to
regenerate the configure files if the aclocal version is not 1.14. More information in the
section :ref:`aclocal-missing`. Finally, the configure, make and make install are executed.

.. literalinclude:: ../src/tasks/ilo-plugin.yml
   :language: yaml

Configuration
-------------

Defining Hosts, commands and services
'''''''''''''''''''''''''''''''''''''

.. warning:: It's necessary to read the section :ref:`nagios_centos_7` before proceding to configure.

.. code-block:: bash

   /usr/local/nagios/libexec/hpeilo_nagios_config


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

The error will show an error output during the executiong of the configuration scripts as the showed bellow:

.. code-block:: bash
   
   Do you wish to write above configured data to host-group configuration file. (y/n) (Blank is y):
   HPE iLO host-group configuration file saved at /usr/local/nagios/libexec/hpeilo_nagios_config.cfg
   grep: /etc/init.d/nagios*: No existe el fichero o el directorio
   dirname: falta un operando
   Pruebe 'dirname --help' para más información.

In this installation, CentOS 7 configured Nagios Daemon with systemd specifications, so the file
/etc/init.d/nagios* was not created.

The alternative we propose in order not to modifying the code of the ilo plugin scripts is to generate
a temporal file :bash:`/etc/init.d/nagios` during the generation of the configuration files with
the following content:

.. code-block:: bash

   NagiosIloCfgFile=/usr/local/nagios/etc/nagios.cfg
