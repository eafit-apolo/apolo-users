.. _sensu-0.26.5-index:

.. role:: bash(code)
   :language: bash

.. role:: yaml(code)
   :language: yaml
	      
Sensu - 0.26.5
================

This documentation page describes the process of installation and configuration
of an entire monitoring environment using Sensu as the Core and CentOS 7 as the
base Operating System.

.. contents::


Basic information
=================

- **Deploy date:** 11th June, 2019
- **Official Website:** https://sensu.io/
- **License:** MIT License.

Directory Hierarchy
====================

The two main Sensu directories are:

**/opt/sensu**
---------------

contains...
  
**/etc/sensu**
---------------

contains...
  
Installation
============

This first installation procedure is the same in both: Sensu Server and
Sensu Client. The procedure is explained for a machine whose Operating
System is CentOS 7.


#. Install the EpelRelease repository

   .. code-block:: bash

	  $ yum install epel-release

#. Add the Official Sensu repository, adding the following file
   to /etc/yum.repos.d/sensu.repo

   .. literalinclude:: src/sensu.repo
	  :language: bash


#. Install Sensu

   .. code-block:: bash

	  $ yum install sensu

Sensu Server
------------

.. note:: It's important to know that a Sensu Server can be also a Sensu Client.

After executing the previous steps, if you are not installing the Sensu
Client, but the Sensu Server, procede as follows:

#. Install the additional dependencies for managing the communication between
   clients-server.

   * RabbitMQ is the message bus that manages the comunication.
   * Erlang is a programming language and a runtime dependency for RabbitMQ.
   * Redis works as Database in Memory and stores temporarly the monitoring
	 information.
   * Uchiwa is a web Dashboard for visualizing Sensu status and Configuration.

   .. code-block:: bash

	  $ yum install erlang redis uchiwa

   RabbitMQ can be installed from it's official RPM:

   .. code-block:: bash

	  $ yum install https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.6/rabbitmq-server-3.6.6-1.el6.noarch.rpm

Configuration
=============
	  
Service configuration
---------------------

You should start and enable in boot time the following services:

1. Sensu Client
''''''''''''''''

* sensu-client

2. Sensu Server
''''''''''''''''

* uchiwa
* sensu-server
* sensu-api
* redis
* rabbitmq-server

RabbitMQ Configuration
----------------------

It's necessary to define authentication credentials to let Clients to
comunicate in a secure way with the Sensu Server through the Message
Broker RabbitMQ.

.. code-block:: bash

   $ rabbitmqctl add_vhost /sensu
   $ rabbitmqctl add_user sensu PASSWORD
   $ rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
  
Sensu Configuration
-------------------

1. Sensu Client
''''''''''''''''

#. Add the Client definition in :bash:`/etc/sensu/config.json` or in any file with *json* extension into the directory
:bash:`/etc/sensu/conf.d/`, specifying hostname, subscriptions, etc.

**Example: /etc/sensu/conf.d/client.json**
	  
   .. literalinclude:: src/client.json
	  :language: bash

#. Add the Transport definition in the configuration directory:

**Example: /etc/sensu/conf.d/transport.json**
	  
   .. literalinclude:: src/transport.json
	  :language: bash

#. Add the RabbitMQ definition specifying the credentials previously
   defined:

**Example: /etc/sensu/conf.d/rabbitmq.json**
	  
   .. literalinclude:: src/rabbitmq.json
	  :language: bash
				 
2. Sensu Server
''''''''''''''''

#. Add the Uchiwa configuration file:

**Example: /etc/sensu/conf.d/uchiwa.json**
	  
   .. literalinclude:: src/uchiwa.json
	  :language: bash
   
Mail Configuration
------------------

PENDING
   
Plugins
========

#.. toctree::
#   :maxdepth: 1
#
#   plugins/nagios-plugins
#   plugins/ipmi-sensors
#   plugins/dell-openmanage
#   plugins/ilo-rest
#   plugins/pnp4nagios
   
Usage
-----

Before executing the role it's important to verify the value of the variables in the file
:bash:`roles/healthckeck/vars/main.yml`. These variables were created in order to uncouple from the code things like IPs, URLs and passwords. In the case of passwords, we used **Ansible Vault** for ciphering them.

.. code-block:: bash

   ansible-vault playbooks/healthcheck.yml --ask-vault-pass

.. caution::
   
   This Ansible role was created thinking in the Ansible Philosophy: **The tool should be used to represent the state of the server, not as a procedural language but as a declarative one.**

   This role was developed to be run multiple times in the same server: If the real state doesn't matches with the role state, the server is modified in order to match both states. If the server has well configured and well installed Nagios and it's plugins, running the playbook will say **Ok** in most of the tasks, so it  won't break any configuration.

.. note::

   The flag :bash:`--ask-vault-pass` is used because this role uses ansible-vault for encrypting private data like passwords.


Troubleshooting
================

Connection error. Is the Sensu API running?
--------------------------------------------

.. image:: images/sensu-error.png
     :alt: Connection Error

**PROBLEM:**
Datacenter Site 1 returned: Connection error. Is the Sensu API running?

**REASON 1:** uchiwa.json has the default configuration (Two generic Datacenter configurations)

**SOLUTION:** Edit uchiwa.json with real information.


**REASON 2:** Redis doesn't support ipv6 (localhost resolves to ::1). Using "localhost" instead of 127.0.0.1 for the host configuration on systems that support IPv6 may result in an IPv6 “localhost” resolution (i.e. ::1) rather than an IPv4 “localhost” resolution [1]_

**SOLUTION:** Update the redis configuration (by default located in :bash:`/etc/sensu/config.json`), changing  the atribute "host" as follows:

   .. literalinclude:: src/redis.json
	  :language: bash


Authors
========

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>


References
===========
  
.. [1] Redis Configuration | Sensu Docs.
	   Retrieved June 12, 2019, from https://docs.sensu.io/sensu-core/1.0/reference/redis/#redis-definition-specification
