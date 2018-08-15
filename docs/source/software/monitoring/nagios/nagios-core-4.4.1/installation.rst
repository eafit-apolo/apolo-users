.. _nagios-core-4.4.1-installation:

.. highlight:: rst

.. role:: matlab(code)
   :language: ini

.. sectnum::
   :suffix: )

.. sidebar:: Contents
   
    .. contents::
       :local:

Tested on (Requirements)
************************

* **OS base:** CentOS 7 (x86_64)
* **Provisioner:** Ansible :math:`\boldsymbol{\ge}` 4.4.1
* **Application:** MATLAB Client (Optional)
* **Extra Libraries:**

  * PyCrypto :math:`\boldsymbol{\gt}` 2.6.1
    
 .. note::

  It is important to install Ansible from the EPEL repository... Explain HERE why ansible vault fails...

Directory Structure
-------------------
.. code-block:: bash		

	.
        ├── ansible.cfg	
	├── inventory
	│   └── hosts
	├── playbooks
	│   ├── healthcheck.yml
	└── roles
	    └── healthcheck
                ├── handlers
		├── tasks
	        ├── vars
		├── templates
                └── files
  
Procedure
---------

  .. code-block:: bash

     ansible-vault playbooks/healthcheck.yml --ask-vault-pass

 .. note::

    The flag --ask-vault-pass is used because this role uses ansible-vault for encrypting private data as passwords.

Ansible Structure
-----------------
We implemented a Role in Ansible that contains the whole proccess of installation and configuration of Nagios and it's integration with some plugins.

   .. literalinclude:: src/tasks/main.yml
      :language: bash

Initial Configuration
---------------------

dell-repos.yml
______________

packages.yml
____________

nagios-users.yml

apache-config.yml

firewall-config.yml

Installing Nagios Core
----------------------



Installing Nagios Plugins
-------------------------
- :ref:`Nagios Plugins <nagios-plugins-index>`
- :ref:`IPMI Sensors <ipmi-sensors-plugin-index>`
- :ref:`Dell EMC OpenManage <dell-nagios-plugin-index>`
- :ref:`iLO AgentLess Management Plugin <ilo-rest-plugin-index>`
