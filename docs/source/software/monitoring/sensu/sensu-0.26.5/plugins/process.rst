.. _sensu-process-index:

.. role:: bash(code)
   :language: bash


Sensu Plugin - Check Process
=============================

Finds processes matching various filters (name, state, etc). The number of processes
found will be tested against the Warning/critical thresholds. This handler formats alerts
as emails and sends them off to a pre-defined recipient. [1]_

.. contents::

Basic information
-----------------

- **License:** MIT License

Installation
------------

.. note:: This installation process has to be performed in each Sensu
		  Client that will execute this monitoring task.

Install the plugin executing:

.. code-block:: bash

	$ sensu-install -p process-checks

It will be located in :bash:`/opt/sensu/embedded/bin/check-process.rb`, that directory
is included in the Sensu user PATH, so in the check definition it's not necessary to
write the full path in the configuration file.


Usage
-------

Add the Check-Process configuration, specifying which will be its subscribers.

The -p argument is for a pattern to match against the list of running processes reported by ps. [1]_

**Example:** Checks if there is any process running that contains **/usr/sbin/sshd** in its name, status, etc
from the output of the command :bash:`ps`.

   .. literalinclude:: ../src/checks/check-ssh.json
	  :language: bash

.. note:: It's important to set correctly the argument to filter correctly from the running processes. Read more in :ref:`incorrect-process-check`.


Troubleshooting
---------------

.. _incorrect-process-check:

The check shows an incorrect number of running processes
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''

In the previous example of SSH, the specified filter was **/usr/sbin/sshd**, because the check wanted to know if the service ssh was up.

If the filter is changed to **sshd**, it will find other ssh processes that are not related to sshd, for example, a remote connection
as a client, not as a server. That's why it's important to define the filter correctly, and verify that it finds what you really want.

References
----------

.. [1] Sensu-Plugins. (n.d.). Sensu-plugins/sensu-plugins-process-checks. Retrieved June 14, 2019,
	   from https://github.com/sensu-plugins/sensu-plugins-process-checks/blob/master/bin/check-process.rb
