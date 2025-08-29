.. _sensu-check-sensors-index:

.. role:: bash(code)
   :language: bash

Sensu Plugin - IPMI Sensors Plugin
====================================

This plugin collects sensor data from an IPMI endpoint, using the rubyipmi gem [1]_.

.. contents::

Basic information
-----------------

- **Official Page:** https://github.com/sensu-plugins/sensu-plugins-ipmi
- **Author:** Matt Mencel
- **License:** MIT License

Dependencies
-------------

* Gem: rubyipmi
* ipmitool or freeipmi package

You have to install rubyipmi gem using the binary located in the Sensu directories, executing:

.. code-block:: bash

	$ /opt/sensu/embedded/bin/gem install rubyipmi

It will install the gem in the directory :bash:`/opt/sensu/embedded/lib/ruby/gems/2.3.0`, which is
used by Sensu client.

Installation
------------

.. note:: This installation process has to be performed in each Sensu
		  Client that will execute this monitoring task.

The plugin is a Ruby script that can be downloaded from the official repository:
https://github.com/sensu-plugins/sensu-plugins-ipmi/blob/master/bin/check-sensor.rb

It can be located in :bash:`/etc/sensu/plugins/check-sensor.rb`.

Usage
-------

The plugin has the following options:

=============================== ========================================================================
Params                          Value
=============================== ========================================================================
-h, --host IPMI_HOST             IPMI Hostname or IP (required)
-p, --password IPMI_PASSWORD     IPMI Password (required)
-v, --privilege PRIVILEGE        IPMI privilege level: CALLBACK, USER, OPERATOR, ADMINISTRATOR (defaults to USER)
-i, --ipmitool IPMI_PROVIDER     IPMI Tool Provider (ipmitool OR freeipmi).  Default is ipmitool.
--scheme SCHEME                  Metric naming scheme, text to prepend to .$parent.$child
-s, --sensor SENSOR_NAME         IPMI sensor to gather stats for.  Default is ALL
-t, --timeout TIMEOUT            IPMI connection timeout in seconds (defaults to 30)
-u, --username IPMI_USERNAME     IPMI Username (required)
=============================== ========================================================================

.. note:: The sensor name depends on the BMC version. It's different the nomenclature in iLO 4 and in iDRAC.

Configuration
--------------

Add the configuration file in a valid directory. Ej: :bash:`/etc/sensu/conf.d/checks/ipmi-temp.json`

**Example:** Check the Ambient temperature in iLO4

   .. literalinclude:: ../src/checks/ipmi-temp.json
	  :language: bash

You can obtain the full list of sensors, executing the command without specifying sensors:

.. code-block:: bash

   $ /opt/sensu/embedded/bin/ruby /etc/sensu/plugins/check-sensors.rb -h BMC_ADDRESS -u USER -p PASS

Authors
--------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>

References
-----------

.. [1] Mencel, M. (2018, November 01). Sensu-Plugins-ipmi.
	   Retrieved June 17, 2019, from https://github.com/sensu-plugins/sensu-plugins-ipmi
