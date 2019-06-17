.. _sensu-network-interface-index:

.. role:: bash(code)
   :language: bash
	      
Sensu Plugin - Network Interface
=================================

A sensu plugin to efficiently monitor network interfaces on Linux allowing to track metrics
like speed, duplex, operational status, link carrier etc. [1]_

.. contents::

Basic information
-----------------

- **Official Page:** https://github.com/m4ce/sensu-plugins-network-interface
- **Author:** Matteo Cerutti
- **License:** MIT License

Installation
------------

.. note:: This installation process has to be performed in each Sensu
		  Client that will execute this monitoring task.

The plugin is a Ruby script that can be downloaded from the official repository [1]_. It can be located in
:bash:`/etc/sensu/plugins/`

Usage
-------

Add the Check-Disk-Usage configuration:

The plugin flags:

=============================== ========================================================================
Params                          Value
=============================== ========================================================================
 --carrier <STATE>              Indicates the current physical link state of the interface (default: up)
 -c, --config <PATH>            Optional configuration file (default: ./network-interface.json)
 --dryrun                       Do not send events to sensu client socket
 -d, --duplex <STATE>           Check interface duplex settings (default: full)
 -x <INTERFACES>,               Comma separated list of interfaces to ignore
 --ignore-interface
 -i, --interface <INTERFACES>   Comma separated list of interfaces to check (default: ALL)
 --handlers <HANDLERS>          Comma separated list of handlers
 -m, --mtu <MTU>                Message Transfer Unit
 --operstate <STATE>            Indicates the interface RFC2863 operational state (default: up)
 -s, --speed <SPEED>            Expected speed in Mb/s
 -t, --txqueuelen <TXQUEUELEN>  Transmit Queue Length
 -w, --warn                     Warn instead of throwing a critical failure
=============================== ========================================================================

.. note:: If not specified, the plugin will check by default everything
		 (duplex, carrier, operstate, mtu, speed).

.. note:: The plugin will execute many independent checks that send it's individual results to Sensu Server.
		  The flag :bash:`--dryrun` avoids that behaviour. It's recommended to use this flag because it's
		  not necessary to be that descriptive.

**Example:** Checks if the Infiniband interface has a speed of 56 Gbps, and a MTU of 65520.
	  
   .. literalinclude:: ../src/checks/network-interface.json
	  :language: bash

Troubleshooting
----------------

MTU never fails
'''''''''''''''

For an unknown reason, the flag for setting the desired MTU doesn't work. The script takes
dinamically the desired MTU. For infiniband interfaces it expects 65520. So, specifing a
MTU value doesn't make the diference.
				 
Authors
--------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>

References
-----------
  
.. [1] Cerutti, M. (2017, April 10). Sensu plugin for monitoring network interfaces.
	   Retrieved June 17, 2019, from https://github.com/m4ce/sensu-plugins-network-interface
	   
