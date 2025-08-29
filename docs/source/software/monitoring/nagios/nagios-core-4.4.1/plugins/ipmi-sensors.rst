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

.. code-block:: yaml

    - include_tasks: ipmi-sensors-plugin.yml
      when: ipmi_sensor_plugin.stat.exists == false
    - include_tasks: ipmi-plugin-status.yml


This taskfile is included only when the file :bash:`/usr/local/nagios/libexec/check_ipmi_sensor` doesn't exist.
This state is registered in :bash:`nagios-plugins-installed.yml`, with the module **stat**.

More information in the section :ref:`nagios-plugins-installed.yml`.

The installation process consists on cloning the git repository and copying the file :bash:`check_ipmi_sensor`
to the Nagios plugins directory.

.. literalinclude:: ../src/tasks/ipmi-sensors-plugin.yml
   :language: yaml

After installing or not the plugin, the taskfile :bash:`ipmi-plugin-status.yml` is executed,
checking the owner, the group and the permissions over the plugin.

.. literalinclude:: ../src/tasks/ipmi-plugin-status.yml
   :language: yaml


Configuration
-------------

.. literalinclude:: ../src/tasks/ipmi-config.yml
   :language: yaml

Synchronizes the ipmi-config file with the version present in the
repo. The passwords are cyphered with **Ansible Vault**.

Usage
-----

The following steps are required for setting up this plugin in a specific host:

#. Add the attribute **_ipmi_ip** in the host definition. This attribute is required by the check_ipmi_sensors plugin.
   The attribute :bash:`_ipmi_excluded_sensors` is necessary only when the error :ref:`ipmi_sensor_error` occurs.

   .. code-block:: bash

	  define host{
	    host_name                host_1
		address                  192.168.1.1
		_ipmi_ip                 192.168.1.1
		_ipmi_excluded_sensors   56


   .. note:: The names of these variables start with an underscore and are in lowercase.
             More info about the usage of custom object variables [1]_ .

#. Add the command definition. In this implementation, the command is added in
   :bash:`/usr/local/nagios/etc/objects/commands.cfg`

   .. code-block:: bash

      define command {
        command_name  check_ipmi_sensor
        command_line  $USER1$/check_ipmi_sensor -H $_HOSTIPMI_IP$ -f $ARG1$ -x $_HOSTIPMI_EXCLUDED_SENSORS$ $ARG2$ $ARG3$
      }

#. Add the service definition. In this implementation, the service is added in :bash:`/usr/local/nagios/etc/objects/common-services.cfg`

   .. note:: If you want to ignore the SEL log entries warning, add
			 the flag --nosel in the check_command field *(See example below)*

   The plugin can be configured for checking each sensor type independently:

   .. code-block:: bash

      define service{
        use                  generic-service
        host_name            host1
        service_description  IPMI
        check_command        check_ipmi_sensor!/etc/ipmi-config/ipmi.cfg!--nosel!-T <sensor_type>
      }

   .. note:: The sensor types are listed in the page: IPMI Sensor Types [2]_

   Or configured for checking everything in one Service definition:

   .. code-block:: bash

      define service{
        use                  generic-service
        host_name            host1
        service_description  IPMI
        check_command        check_ipmi_sensor!/etc/ipmi-config/ipmi.cfg
      }

   .. note:: If the IPMI plugin is configured for multiple nodes and there is not a common user/password
			 between them, you can configure one service per each different credential, defining different
			 ipmi-config files.

   .. code-block:: bash

      define service{
        use                  generic-service
        host_name            host1
        service_description  IPMI
        check_command        check_ipmi_sensor!/etc/ipmi-config/file1.cfg
      }

	  define service{
        use                  generic-service
        host_name            host2
        service_description  IPMI
        check_command        check_ipmi_sensor!/etc/ipmi-config/file2.cfg
      }


   .. note:: The user used for this IPMI monitoring doesn't need special permissions.

#. Create the file with the credentials and with the correct permissions.

   .. code-block:: bash

	  username user
	  password passw0rd
	  privilege-level user
	  ipmi-sensors-interpret-oem-data on

   * Owner: nagios
   * Group: nagcmd
   * Mode: 0640

   .. note:: Read [3]_ for more information about freeIPMI configuration file.

Troubleshooting
---------------

.. _ipmi_sel_error:

IPMI Status: Critical [X system event log (SEL) entries present]
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#. Read System Entry Logs before deleting them. It's important to see if there is a
   bad behavior registered in these logs.

   :bash:`ipmiutil sel -N (host_ip|hostname) -F lan2 -U user -P passwd`

#. Clear System Entry Logs with the credentials of a user with enough privileges.
   :bash:`ipmiutil sel -d -N (host_ip|hostname) -F lan2 -U user -P passwd`

.. note:: The password should be written between apostrophes (**'**) if contains special characters.

.. _ipmi_sensor_error:

IPMI Status: Critical [Presence = Critical, Presence = Critical]
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#. Execute the following command to identify which sensors are absent.

   :bash:`check_ipmi_sensor -H <Host-IP> -f <Archivo de configuración> -vvv | grep Critical`

   Example of STOUT:

   .. code-block:: bash

      ID  | Name     | Type            | State    | Reading | Units | Lower NR  | Lower C | Lower NC | Upper NC | Upper C | Upper NR | Event
      56  | Presence | Entity Presence | Critical |   N/A   |  N/A  |    N/A    |   N/A   |    N/A   |    N/A   |   N/A   |    N/A   | 'Entity Absent'
      58  | Presence | Entity Presence | Critical |   N/A   |  N/A  |    N/A    |   N/A   |    N/A   |    N/A   |   N/A   |    N/A   | 'Entity Absent'
      IPMI Status: Critical [Presence = Critical ('Entity Absent'), Presence = Critical ('Entity Absent')] | 'Inlet Temp'=17.00;3.00:42.00;-7.00:47.00 'CPU Usage'=100.00;~:101.00; 'IO Usage'=0.00;~:101.00;
      'MEM Usage'=0.00;~:101.00; 'SYS Usage'=100.00;~:101.00; 'Pwr Consumption'=320.00;~:452.00;~:540.00 'Current'=1.50 'Temp'=80.00 'Temp'=65.00
      Presence = 'Entity Absent' (Status: Critical)
      Presence = 'Entity Absent' (Status: Critical)

#. Add the attribute :bash:`_ipmi_excluded_sensors` which value is a comma-separated list of sensor IDs that contain the absent sensors discovered.

   **Example:**

   .. code-block:: text

      define host{
        host_name               host-example
        address                 0.0.0.0
        _ipmi_ip                0.0.0.0
        _ipmi_excluded_sensors  56,58
      }

References
----------

.. [1] Custom Object Variables. (n.d.). Retrieved August 29, 2018,from
       https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/3/en/customobjectvars.html

.. [2] Krenn, T. (n.d.). IPMI Sensor Types. Retrieved November 20, 2018, from https://www.thomas-krenn.com/en/wiki/IPMI_Sensor_Types


.. [3] "freeipmi.conf(5) - Linux man page", FreeIPMI Core Team. Retrieved
	   December 3, 2018, from https://linux.die.net/man/5/freeipmi.conf
