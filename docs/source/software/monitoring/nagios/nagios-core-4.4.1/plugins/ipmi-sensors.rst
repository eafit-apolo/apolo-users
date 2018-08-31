.. _ipmi-sensors-plugin-index:

.. role:: bash(code)
   :language: bash

.. role:: python(code)
   :language: python	      

IPMI Sensors - Nagios Plugin
============================

Basic information
-----------------

- **Official Website:** https://exchange.nagios.org/directory/Plugins/Hardware/Server-Hardware/IPMI-Sensor-Monitoring-Plugin/details
- **License:** GPL
- **Version:** 3.9

Installation
------------

This taskfile is included only when the file /usr/local/nagios/libexec/check_ipmi_sensor doesn't exist.
This state is registered in :bash:`nagios-plugins-installed.yml`, with the module **stat**.

More information in the section :ref:`nagios-plugins-installed.yml`.

The installation process consists on cloning the git repository and copying the file :bash:`check_ipmi_sensor`
to the Nagios plugins directory.

.. literalinclude:: ../src/tasks/ipmi-sensors-plugin.yml
   :language: yaml


Configuration
-------------

The following steps are required for setting-up this plugin in a specific host:

#. Add the attribute **_ipmi_ip** in the host definition. This attribute is required by the check_ipmi_sensors plugin.

.. note:: The names of these variables start with underscore and are in lowercase.
          More info about the usage of custom object variables [1]_ .

#. Add the command definition. In this implementation the command is added in
   :bash:`/usr/local/nagios/etc/objects/commands.cfg`

   .. code-block:: bash
		   
      define command {
        command_name  check_ipmi_sensor
        command_line  $USER1$/check_ipmi_sensor -H $_HOSTIPMI_IP$ -f $ARG1$ -x $_HOSTIPMI_EXCLUDED_SENSORS$
      }

#. Add the service definition. In this implementation the service is added in
   :bash:`/usr/local/nagios/etc/objects/common-services.cfg`

   .. code-block:: bash
	
      define service{
        use                  generic-service
        host_name            mgmt-master
        service_description  IPMI
        check_command        check_ipmi_sensor!/etc/ipmi-config/ipmi.cfg
      }

.. warning:: TODO: **IMPORTANTE** Definir cómo configurar IPMI

Troubleshooting
---------------

.. _ipmi_sel_error:

IPMI Status: Critical [X system event log (SEL) entries present]
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#. Read System Entry Logs before deleting them. It's important to see if there is a
   bad behaviour registered in these logs.
   
   :bash:`ipmiutil sel -N (host_ip|hostname) -F lan2 -U user -P passwd`

#. Clear System Entry Logs with the credentials of a user with enough privileges.
   :bash:`ipmiutil sel -d -N (host_ip|hostname) -F lan2 -U user -P passwd`

.. note:: The password should be written between aphostrophes (**'**) if contains special characters.
	 
References
----------

.. [1] Custom Object Variables. (n.d.). Retrieved August 29, 2018,from
       https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/3/en/customobjectvars.html
