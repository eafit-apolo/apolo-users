.. _sensu-graphite-index:

.. role:: bash(code)
   :language: bash


Sensu Plugin - Graphite
=========================

This plugin provides native Graphite instrumentation for monitoring, including: replication status, various Graphite data queries, mutators, and handlers. [1]_

.. contents::

Basic information
-----------------

- **Official Page:** https://github.com/sensu-plugins/sensu-plugins-graphite
- **License:** MIT License

Installation
------------

.. note:: This installation process has to be performed in the Sensu Server.

Install the plugin executing: [2]_

.. code-block:: bash

    $ sensu-install -p graphite

This command will install the corresponding Gem. Its scripts are located
in :bash:`/opt/sensu/embedded/bin/`, that directory is included in the Sensu
user's PATH, so in the check definition, it's not necessary to write the full path.

The scripts are:

* bin/check-graphite-data
* bin/check-graphite-replication
* bin/check-graphite-stats
* bin/check-graphite
* bin/extension-graphite
* bin/handler-graphite-event
* bin/handler-graphite-notify
* bin/handler-graphite-status
* bin/handler-graphite-occurrences
* bin/mutator-graphite

Configuration
--------------

Handler definition:

   .. literalinclude:: ../src/handlers/graphite.json
      :language: bash

Mutator definition:

   .. literalinclude:: ../src/mutators/graphite-mutator.json
      :language: bash


Usage
-------

To store the metrics of a plugin as time series in Graphite,
execute the following steps:

#. Add **graphite** to the list of handlers in the check definition.
#. Set the **type** attribute of the check as **metric**.

  .. note:: Graphite handler will communicate Sensu with carbon-cache.
			In order to activate the handler with an event,
			it's necessary to set the attribute type to metric. Without
			that option, the handler will only be executed with a CRITICAL
			or WARNING state.

  .. literalinclude:: ../src/checks/ipmi-temp.json
      :language: bash

#. Restart the Sensu Server and Sensu API services.

References
----------

.. [1] Sensu Plugins - Graphite. (2018, December 17). Retrieved July 17, 2019,
	   from https://github.com/sensu-plugins/sensu-plugins-graphite

.. [2] Eves, M. (n.d.). Sensu Metrics Collection. Retrieved July 31, 2019,
	   from https://blog.sensu.io/sensu-metrics-collection-beafdebf28bc

Authors
--------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
