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

Install the plugin executing:

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

#. Add graphite as Handler
#. Type Metric

  .. note:: Mail Events OK status

  .. literalinclude:: ../src/checks/ipmi-temp.json
      :language: bash


References
----------

.. [1] Sensu Plugins - Graphite. (2018, December 17). Retrieved July 17, 2019, from https://github.com/sensu-plugins/sensu-plugins-graphite

Authors
--------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
