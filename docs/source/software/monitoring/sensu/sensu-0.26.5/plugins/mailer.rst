.. _mailer-index:

.. role:: bash(code)
   :language: bash

	      
Sensu Plugin - Mailer
=======================

This handler formats alerts as mails and sends them off to a pre-defined recipient. [1]_

.. contents::

Basic information
-----------------

- **License:** MIT License

Installation
------------

.. note:: The entire process of installation and configuration has to be executed only in the
		  Sensu Server.
		  
The handler is a Ruby script that can be downloaded from the official repository: https://github.com/sensu-plugins/sensu-plugins-mailer/blob/master/bin/handler-mailer.rb.

It can be located in :bash:`/etc/sensu/handlers/mailer.rb`


Configuration
-------------

Add the Mailer configuration file, setting correctly which will be the SMTP server,
the sender, the mail recipients, etc:

**Example:** /etc/sensu/conf.d/handlers/mailer.json
	  
   .. literalinclude:: ../src/mailer.json
	  :language: bash

Usage
-----

Follow this steps to add mailer as a handler that will send a mail
when there is a state change in a specific monitoring check:

#. Add Mailer as a handler in the check definition:

   .. literalinclude:: ../src/check-mailer.json

#. Restart sensu-server and sensu-api services.

References
----------

.. [1] Sensu-Plugins. (n.d.). Sensu-plugins/sensu-plugins-mailer. Retrieved June 13, 2019,
	   from https://github.com/sensu-plugins/sensu-plugins-mailer/blob/master/bin/handler-mailer.rb


