.. _nagios-plugins-index:

.. role:: bash(code)
   :language: bash

Nagios-plugins
==============

It is a set of useful plugins that are needed by other plugins like Dell OpenManage plugin.

Basic information
-----------------

- **Official Website:** https://nagios-plugins.org/
- **License:** GNU General Public License v3.0
- **Description:** The official Nagios Plugins package contains over 50 plugins to get you started monitoring all the basics. [1]_

**Tested on (Requirements)**
----------------------------

* **Nagios Core:** Version :math:`\boldsymbol{\ge}` 3.5.0

Installation
------------

This taskfile is executed only if the folder :bash:`/usr/local/nagios/libexec` is not empty. This state is registered in the taskfile :bash:`nagios-plugins-installed.yml`, with the module **find**.

For more information about these registers read the section :ref:`nagios-plugins-installed.yml`.

The installation process consists of downloading, uncompressing, configuring and compiling the plugin.

.. literalinclude:: ../src/tasks/nagios-plugins.yml
   :language: yaml

References
----------

.. [1] Nagios Plugins. (n.d.). Retrieved August 15, 2018, from https://www.nagios.org/downloads/nagios-plugins/
