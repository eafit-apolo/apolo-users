.. _sensu-cpu-load-index:

.. role:: bash(code)
   :language: bash

	      
Sensu Plugin - CPU Load
=========================

Checks the average CPU load in the last 1, 5 and 15 minutes, establishing a warning and a caution threshold
for each one of these time intervals.

.. contents::

Basic information
-----------------

- **Official Page:** https://github.com/sensu-plugins/sensu-plugins-cpu-checks
- **License:** MIT License

Installation
------------

.. note:: This installation process has to be performed in each Sensu
		  Client that will execute this monitoring task.

Install the plugin executing:
		  
.. code-block:: bash

	$ sensu-install -p loads-checks

This command will install the coresponding Gem. It's scripts are located
in :bash:`/opt/sensu/embedded/bin/`, that directory is included in the Sensu
user's PATH, so in the check definition it's not necessary to write the full path.

The scripts are:

* bin/check-cpu.rb
* bin/check-cpu.sh
* bin/metrics-cpu-mpstat.rb
* bin/metrics-cpu-pcnt-usage.rb
* bin/metrics-numastat.rb
* bin/metrics-user-pct-usage.rb
						
Usage
-------

Add the Check-CPU-load configuration, specifying which will be its subscribers and its warning and critical thresholds.

   .. literalinclude:: ../src/checks/check-cpu-load.json
	  :language: bash

In this example, the check will be in WARNING state if the CPU load is greater than 15,15,14 in the last 1,5 and 15 minutes
respectively, and CRITICAL state if the CPU load is greater than 20,18,18 in the last 1,5 and 15 minutes respectively.
				 
Authors
--------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
