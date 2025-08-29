.. _sensu-memory-index:

.. role:: bash(code)
   :language: bash


Sensu Plugin - Memory Checks
=============================

This plugin provides native memory instrumentation for monitoring and metrics collection.

.. contents::

Basic information
-----------------

- **Official Page:** https://github.com/sensu-plugins/sensu-plugins-memory-checks
- **License:** MIT License

Installation
------------

.. note:: This installation process has to be performed in each Sensu
		  Client that will execute this monitoring task.

Install the plugin executing:

.. code-block:: bash

	$ sensu-install -p memory-checks

This command will install the coresponding Gem. It's scripts are located
in :bash:`/opt/sensu/embedded/bin/`, that directory is included in the Sensu
user's PATH, so in the check definition it's not necessary to write the full path.

The scripts are:

* bin/check-memory.rb
* bin/check-memory.sh
* bin/check-memory-percent.rb
* bin/check-memory-percent.sh
* bin/check-ram.rb
* bin/check-swap-percent.rb
* bin/check-swap.sh
* bin/check-swap.rb
* bin/metrics-memory-percent.rb
* bin/metrics-memory.rb

Usage
-------

Memory Usage Percent
''''''''''''''''''''

Add the Check-Memory-Percent configuration, specifying which will be its subscribers and its warning and critical thresholds.

   .. literalinclude:: ../src/checks/check-memory-percent.json
	  :language: bash

In this example, the check will be in WARNING state if memory usage is over 90% and CRITICAL over 95%.

Swap Usage Percent
''''''''''''''''''

Add the Check-Swap-Percent configuration, specifying which will be its subscribers and its warning and critical thresholds.

   .. literalinclude:: ../src/checks/check-swap-percent.json
	  :language: bash

In this example, the check will be in WARNING state if swap usage is over 10% and CRITICAL over 15%.

Authors
--------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
