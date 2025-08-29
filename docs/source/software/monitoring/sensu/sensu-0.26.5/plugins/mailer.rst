.. _mailer-index:

.. role:: bash(code)
   :language: bash


Sensu Plugin - Mailer
=======================

This handler formats alerts as e-mails and sends them off to a pre-defined recipient. [1]_

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

Add the Mailer configuration file and set correctly which will be the SMTP server,
the sender, the mail recipients, etc:

**Example:** :file:`/etc/sensu/conf.d/handlers/mailer.json`

   .. literalinclude:: ../src/mailer.json
      :language: bash

In this example, the handler definition has the filter state-change-only associated. This
filter executes the mailer handler to send mail only when there is a change in the state,
that means, in the first occurrence of the state. When a check is in state OK, it doesn't
count occurrences, that's why it's necessary to have both conditions in the conditional.

That filter is defined as follows:

**Example:** :file:`/etc/sensu/conf.d/filters.json`

   .. literalinclude:: ../src/filter-state-change.json
      :language: bash

Usage
-----

Follow these steps to add mailer as a handler that will send a mail
when there is a state change in a specific monitoring check:

#. Add Mailer as a handler in the check definition:

   .. literalinclude:: ../src/check-mailer.json

#. Restart sensu-server and sensu-api services.

References
----------

.. [1] Sensu-Plugins. (n.d.). Sensu-plugins/sensu-plugins-mailer. Retrieved June 13, 2019,
       from https://github.com/sensu-plugins/sensu-plugins-mailer/blob/master/bin/handler-mailer.rb
