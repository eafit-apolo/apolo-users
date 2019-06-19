.. _remediator-index:

.. role:: bash(code)
   :language: bash


Sensu Plugin - Remediator
==========================

This plugin reads configuration from a check definition and triggers
specified remediation actions (defined as other checks) via the
Sensu API when the occurrences and severities reach certain values. [1]_

.. contents::

Basic information
-----------------

- **License:** MIT License

Installation
------------

.. note:: The entire process of installation and configuration has to be executed only in the
          Sensu Server.

The handler is a Ruby script that can be downloaded from the official repository: https://github.com/sensu-plugins/sensu-plugins-sensu/blob/master/bin/handler-sensu.rb. It can be located in
:bash:`/etc/sensu/handlers/remediator.rb`


Configuration
-------------

Add the Remediator configuration file:

**Example:** :file:`/etc/sensu/conf.d/handlers/remediator.json`

   .. literalinclude:: ../src/remediator/remediator.json
      :language: bash

Usage
-----

Remediator is a Sensu handler that triggers actions when a defined check service changes
to critical status. The way Remediator triggers this action is executing it in the hosts
that follow a subscription with the hostname of the client that failed.

**Example:** A compute node called **test-node** fails in a defined monitoring check. Remediator
triggers the defined action in the hosts that follow the subscription **test-node**.

That's why every host that wants to receive the trigger from **Remediator**
has to be subscribed to its hostname.

The procedure for setting a handler for a check with remediator is:

#. Add the hostname as a subscription in each node that will execute the handler.

   .. literalinclude:: ../src/remediator/host.json

#. Create the definition of the check that will be executed to *remediate* a CRITICAL result.

   **Example:** If the service ssh is down, the check that will remediate that is the following:

   .. literalinclude:: ../src/remediator/reaction.json

#. Update the definition of the check that will trigger the remediator handler if changes
   its state to CRITICAL. You have to add an attribute called remediation, specifying which
   check will remediate the failure.

   **Example:** Checks if SSH is running. In this case, the check called *check-sshd* will be
   remediated by the check *remediate-service-ssh* if it changes to severity 2 (CRITICAL) one or
   more times.

   .. literalinclude:: ../src/remediator/check.json

#. If the handler needs superuser permissions to run its action, it's necessary to add that
   rule in the sudoers configuration in the Sensu-Clients.


Troubleshooting
---------------

sudo: sorry, you must have a tty to run sudo
''''''''''''''''''''''''''''''''''''''''''''

This message appears when you need to run the remediator's action as superuser,
you defined the rule in sudoer's configuration but you haven't specified that
the action requires a TTY.

**SOLUTION:** Add the following line in the sudoers file. [2]_

.. code-block:: bash

    Defaults:sensu !requiretty

References
----------

.. [1] Sensu-Plugins. (n.d.). Sensu-plugins/sensu-plugins-sensu. Retrieved June 12, 2019,
       from https://github.com/sensu-plugins/sensu-plugins-sensu/blob/master/bin/handler-sensu.rb

.. [2] Brousse, N. (2014, September 8). Sudo: Sorry, you must have a tty to run sudo.
       Retrieved June 13, 2019, from
       https://www.shell-tips.com/2014/09/08/sudo-sorry-you-must-have-a-tty-to-run-sudo/
