.. _dell-nagios-plugin-index:

.. role:: bash(code)
   :language: bash

Dell OpenManage - Nagios Plugin
===================================

Basic information
-----------------

- **Official Website:** https://www.dell.com/support/home/co/es/cobsdt1/drivers/driversdetails?driverid=41y2v
  
- **License:**

**Tested on (Requirements)**
----------------------------

* **Nagios Core:** Version :math:`\boldsymbol{\ge}` 3.5.0


Installation
------------

This taskfile is executed only if the directory :bash:`/usr/local/nagios/libexec` doesn't
exist.This state is registered in the taskfile :bash:`nagios-plugins-installed.yml`, with the module **stat**.

For more information about this registers read the section :ref:`nagios-plugins-installed.yml`.

The installation process consist on downloading and uncompressing the plugin, then the script :bash:`Dell_OpenManage_Plugin/Install/install.sh` is
executed.

.. literalinclude:: ../src/tasks/dell-plugin.yml
   :language: yaml

Usage
-----

To configure a specific host: 

.. code:: bash

	  $ python dellemc_nagios_discovery_service_utility.py --host <host_ip> --all    \
	  --output.file /usr/local/nagios/dell/config/objects/ --prefProtocol 1 --snmp.version 1
	  
To configure a list of hosts defined one per line in a file:

       $ python

To detect the Dell hosts present in a specified subnet:

       $ python

============================= ============================
Params                        Value
============================= ============================
 -H HOST                      IP or hostname
 --File FILE                  File that contains hosts
 --subnet SUBNET              a
 --all                        a
 --prefProtocol VALUE **(*)** 1(SNMP) 2(WSMan) 3(Redfish)
 --snmp.version VALUE **(*)** 1(SNMP v1) 2(SNMP v2c)
============================= ============================

.. note:: The parameters with (*) are obligatory.

The plugin has a script that discovers and generates the necesary configuration files for Dell servers present in a given IP,IP range or subnet.
