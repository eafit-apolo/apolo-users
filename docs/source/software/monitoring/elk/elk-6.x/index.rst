.. _elk-6.x-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

ELK Stack 6.x Installation and Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::

.. note::
  
  - Install Java JDK 8, more recent versions may have compatibility problems. Just run the ansible role in the ansible-vms repo.
  - You must use the same version for Logstash, Elasticsearch, Kibana to avoid compatibility problems.
  - Also, when reading the guides check that guide version is compatible with the version of your ELK stack.
  - The RAM used by Logstash and Elasticsearch is a lot. By default 1GB for heap, plus the jvm which is about 2.5 GB of RAM.
  - Install, configure, and start the services in the following order, then you will avoid repeating some steps, and also some problems. Note that this order is the same as the one in the role *elk*.

    + Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/6.6/index.html
    + Kibana: https://www.elastic.co/guide/en/kibana/6.6/index.html
    + Logstash: https://www.elastic.co/guide/en/logstash/6.6/index.html
    + Filebeat: https://www.elastic.co/guide/en/beats/filebeat/6.6/index.html

Basic information
-----------------

- **Official website:** https://www.elastic.co/elk-stack

Installation
------------
The architecture in which the ELK Stack were installed is the following.

.. code-block:: bash
	
		        ELK Server
		       ----------------
		         Kibana
		         Elasticsearch
		         Logstash
		       ----------------
		              ||
		              ||
		              ||
	              ------------------
                      |                |
	        ------------      ------------
	          Filebeat          Filebeat
	        ------------      ------------
	         Beat Server       Beat Server

Also, it is important to note that the stack of applications were installed on CentOS 7 using `Ansible <https://www.ansible.com/>`_. Therefore, in the next subsections there will be an explanation of the tasks used to install each of the ELK Stack components.

Before proceeding to the installation of each main component, it is needed to add the ELK's repository to the rpm's repositories.

.. literalinclude:: src/tasks/add-elk-repo.yml
   :language: yaml

This playbook basically adds the ELK's gpg signing key and takes a template to render it in the :bash:`/etc/yum/repos.d/` directory, which is where :bash:`rpm` looks for its repositories. The template file is this:

.. literalinclude:: src/templates/etc/yum.repos.d/elk.repo.j2
   :language: yaml

The :yaml:`{{ elk_version }}` jinja variable refers to the version of your desired stack. In this case 6.c. This variable must be passed as argument when running ansible or have it defined somewhere in your ansible project. For more information about variables go to the Ansible's `documentation <https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html>`_.

Also, it is needed to install Java 8 and the main components (elasticsearch, logstash, kibana) packages.

.. literalinclude:: src/tasks/install-elk.yml
   :language: yaml

The variable :yaml:`{{ java_version }}` represents the java version used, in our case (and due to compatibility) 1.8.0.

Elasticsearch
'''''''''''''
After installing the needed package, Elasticsearch is configured like this:

.. literalinclude:: src/tasks/elasticsearch-config.yml
   :language: yaml

The elasticsearch main configuration file, which is a template, is rendered in :bash:`/etc/elasticsearch/`. The template can be found :download:`here <src/templates/etc/elasticsearch/elasticsearch.yml.j2>`. In that template you will find a variable called :yaml:`{{ machine }}`, which is rendered as the hostname of our ELK server, in our case *elk*. So in your case, you can use whatever you want, but from now on in this guide we will use the hostname *elk*. Also, when the configuration file is placed, a notify is made so that the elasticsearch service is started/restarted. The handler looks like this:

.. literalinclude:: src/handlers/elasticsearch-handler.yml
   :language: yaml

Kibana
''''''
After installing the needed package, Kibana is configured like this:

.. literalinclude:: src/tasks/kibana-config.yml
   :language: yaml
	      
The kibana main configuration file, which is a template, is rendered in :bash:`/etc/kibana/`. The template can be found :download:`here <src/templates/etc/kibana/kibana.yml.j2>`. Also, when the configuration file is placed, a notify is made so that the kibana service is started/restarted. The handler looks like this:

.. literalinclude:: src/handlers/kibana-handler.yml
   :language: yaml

After installing and configuring Kibana, it is time to give structure to our logs and create/import the dashboards and visualizations needed:
	      
1. Access the web interface through *http://elk:5601*. To access it using the domain name *elk* remember to add elk to your *hosts* file.
2. Organize the information. This will help you plot all your data easily.

  .. note:: Create the indexes, and the mappings BEFORE sending any data to elasticsearch.
     
  a) Create *indexes* and *mappings*, that is, give types and formats to your data.
	 
     * In the *Dev Tools* section, copy and paste the content of the index and mappings :download:`file <config/index_and_mappings.txt>`, then select it all and click on RUN. Note that these mappings are the ones that we use, you can take as an example and create your owns, for more information go to ELK's documentation about `mappings <https://www.elastic.co/guide/en/kibana/current/tutorial-load-dataset.html#_set_up_mappings>`_.
     * To easily see your mappings go to: Management -> Index management -> Select your index -> Mapping.
	     
  b) Continue with **c** and **d** steps after filebeat is sending information as well as logstash is filtering it and passing it to elasticsearch.
	 
     * You can check that it is already done if you can create *index patterns*, that is, it won't let you create them if you don't have any data.

  c) Create the dashboard and visualizations.
	 
     * Go to: *Management*, then, under the Kibana section go to *Saved Objects*, then, *Import*, and import the dashboards and visualizations :download:`file <config/dashboards_and_visualizations.json>`.
     * If you to export the visualizations to a json format, remember to export every saved object, because some visualizations my depend on other objects and they won't work if you don't export them all.

  d) In the section *Management* -> *Index Patterns* select one (no matter which one) index pattern and press the star button to make it the default one.

Logstash
''''''''
After installing the needed package, Logstash is configured like this:

.. literalinclude:: src/tasks/logstash-config.yml
   :language: yaml
	      
Installation, configuration and service startup is defined in the role *elk*.

.. note:: **Logstash Filters:** It is important to know the version of the plugin that you are using so you will be able to search for the proper documentation.

Filebeat
''''''''
Installation, configuration and service startup is done in the role *elk*.
