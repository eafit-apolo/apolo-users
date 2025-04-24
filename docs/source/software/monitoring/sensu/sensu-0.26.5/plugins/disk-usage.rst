.. _sensu-disk-usage-index:

.. role:: bash(code)
   :language: bash


Sensu Plugin - Disk Usage
============================

Uses the sys-filesystem gem to get filesystem mount points and metrics [1]_.
Check disk capacity and inodes in the specified partitions.

.. contents::

Basic information
-----------------

- **Official Page:** https://github.com/sensu-plugins/sensu-plugins-disk-checks
- **License:** MIT License

Installation
------------

.. note:: This installation process has to be performed in each Sensu
		  Client that will execute this monitoring task.

Install the plugin executing:

.. code-block:: bash

	$ sensu-install -p disk-usage

It will be located in :bash:`/opt/sensu/embedded/bin/check-disk-usage.rb`, that directory
is included in the Sensu user PATH, so in the check definition it's not necessary to
write the full path in the configuration file.

Usage
-------

Add the Check-Disk-Usage configuration:

The most important flags are:

============================= ========================================================================
Params                        Value
============================= ========================================================================
 -w                           Doesn't throw a critical failure even if exceeds the thresholds.
 --warn-space PERCENT         Warn if PERCENT or more of disk space used
 --warn-inodes PERCENT        Warn if PERCENT or more of inodes used
 --crit-space PERCENT         Critical if PERCENT or more of disk space used
 --crit-inodes PERCENT        Critical if PERCENT or more of inodes used
 --mount MOUNTPOINT           Comma separated list of mount point(s) (default: all)
============================= ========================================================================

.. warning:: If MOUNTPOINT contains an invalid partition (i.e /this_doesnt_exist) the plugin will not
			 return Error, it will ignore it and check the others.

Execute :bash:`/opt/sensu/embedded/bin/check-disk-usage.rb  --help` to obtain the full list of flags
supported by the plugin.

**Example:** Checks if the partitions /,/tmp,/var are over 90% or 95% of it's capacity. The inode threshold
is the default because was not specified.

   .. literalinclude:: ../src/checks/disk-usage.json
	  :language: bash


References
----------

.. [1] Sensu-Plugins. (n.d.). Sensu-plugins/sensu-plugins-disk-checks. Retrieved June 14, 2019,
	   from https://github.com/sensu-plugins/sensu-plugins-disk-checks
