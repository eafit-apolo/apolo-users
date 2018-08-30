.. _dell-nagios-plugin-index:

.. role:: bash(code)
   :language: bash

Dell EMC OpenManage - Nagios Plugin
===================================

Basic information
-----------------

- **Official Website:** https://exchange.nagios.org/directory/Plugins/Hardware/Server-Hardware/Dell/Dell-EMC-OpenManage-Plug-2Din-for-Nagios-Core/details
- **License:**

**Tested on (Requirements)**
----------------------------

* **Nagios Core:** Version :math:`\boldsymbol{\ge}` 3.5.0


Installation
------------

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
 --host HOST                  IP
 --File FILE                  File that contains hosts
 --subnet SUBNET              a
 --all                        a
 --prefProtocol VALUE **(*)** 1(SNMP) 2(WSMan) 3(Redfish)
 --snmp.version VALUE **(*)** 1(SNMP v1) 2(SNMP v2c)
============================= ============================

.. note:: The parameters with (*) are obligatory.

The plugin has a script that discovers and generates the necesary configuration files for Dell servers present in a given IP,IP range or subnet.
