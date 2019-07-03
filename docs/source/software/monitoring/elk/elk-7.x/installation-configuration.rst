.. _installation-configuration-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

.. role:: ruby(code)
   :language: ruby

.. _installation-7.x-label:

Installation and Configuration
------------------------------

The architecture in which the ELK Stack was installed is the following.

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

Although we are using this architecture, you can change it in any way you want, you just have to pay attention to the configuration files.
Also, it is important to note that the stack of applications was installed on CentOS 7 using `Ansible <https://www.ansible.com/>`_. Therefore, in the next subsections, there will be an explanation of the tasks used to install and configure each of the ELK Stack components. The directory structure of our Ansible project is described in :ref:`testing-7.x-label`. You can use it as a reference to build your own Ansible project.

Before proceeding to the installation of each main component, it is needed to add the ELK's repository to the rpm's repositories.

.. literalinclude:: src/tasks/add-elk-repo.yml
   :language: yaml

This playbook basically adds the ELK's gpg signing key and takes a template to render it in the :bash:`/etc/yum/repos.d/` directory, which is where :bash:`rpm` looks for its repositories. The template file is this:

.. literalinclude:: src/templates/etc/yum.repos.d/elk.repo.j2
   :language: bash

The :yaml:`{{ elk_version }}` jinja variable refers to the version of your desired stack. In this case 7.x. This variable must be passed as an argument when running Ansible or have it defined somewhere in your Ansible project. For more information about variables go to the Ansible's `documentation <https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html>`_.

Also, it is needed to install Java 8 and the main components (Elasticsearch, Logstash, Kibana) packages.

.. literalinclude:: src/tasks/install-elk.yml
   :language: yaml

The variable :yaml:`{{ java_version }}` represents the java version used, in our case (and due to compatibility) 1.8.0.

Elasticsearch
'''''''''''''
After installing the needed package, Elasticsearch is configured like this:

.. literalinclude:: src/tasks/elasticsearch-config.yml
   :language: yaml

The Elasticsearch main configuration file, which is a template, is rendered in :bash:`/etc/elasticsearch/`. The template can be found :download:`here <src/templates/etc/elasticsearch/elasticsearch.yml.j2>`. In that template, you will find a variable called :yaml:`{{ machine }}`, which is rendered as the hostname of our ELK server, in our case *elk*. So in your case, you can use whatever you want, but from now on in this guide, we will use the hostname *elk*. Note that, when the configuration file is placed, a notify is made so that the Elasticsearch service is started/restarted. The notify handler looks like this:

.. literalinclude:: src/handlers/elasticsearch-handler.yml
   :language: yaml


Logstash
''''''''
After installing the needed package, Logstash is configured like this:

.. literalinclude:: src/tasks/logstash-config.yml
   :language: yaml

The first task copies two configuration files, *pipelines.yml*, and *logstash.yml*. The first file indicates to Logstash where to find our pipelines configuration files. You can find it :download:`here <src/files/etc/logstash/pipelines.yml>`. The second one is the main configuration file for Logstash. You can find it :download:`here <src/files/etc/logstash/logstash.yml>`.

The second task takes a template and renders it in the pipelines directory. The template represents the description of our main pipeline, that is, inputs, filters, and outputs. You can find it :download:`here <src/templates/etc/logstash/conf.d/main_pipeline.conf.j2>`.

.. note:: **Logstash Filters:** It is important to know the version of the filter plugins that you are using so you will be able to search for the proper documentation.

.. _kibana-7.x-label:

Kibana
''''''
After installing the needed package, Kibana is configured like this:

.. literalinclude:: src/tasks/kibana-config.yml
   :language: yaml

The Kibana main configuration file, which is a template, is rendered in :bash:`/etc/kibana/`. The template can be found :download:`here <src/templates/etc/kibana/kibana.yml.j2>`. Also, when the configuration file is placed, a notify is made so that the Kibana service is started/restarted. The notify handler looks like this:

.. literalinclude:: src/handlers/kibana-handler.yml
   :language: yaml

After installing and configuring Kibana, it is time to give structure to our logs and create/import the dashboards and visualizations needed:

1. Access the web interface through *http://elk:5601*. To access it using the domain name *elk* remember to make your cluster nodes visible by their DNS', in this case, the node where you have installed Kibana.
2. Organize the information. This will help you plot all your data easily. If you want to add a new logging source see the section below :ref:`new-source-7.x`.

  .. note:: Create the indexes and the mappings BEFORE sending any data to Elasticsearch.

  a) Create *indexes* and *mappings*, that is, give types and formats to your data.

     * In the *Dev Tools* section, copy and paste the content of the index and mappings :download:`file <config/indexes_and_mappings.txt>`, then select it all and click on RUN. Note that these mappings are the ones that we use, you can take them as an example and create yours.
     * To easily see your mappings go to: Management -> Index management -> Click on your index -> Mapping.

  b) Create the dashboard and visualizations.

     * Go to *Management*, then, under the Kibana section go to *Saved Objects*, then, *Import*, and import the dashboards and visualizations :download:`file <config/dashboards_and_visualizations.json>`.
     * If you want to export the visualizations to a json format, remember to export every saved object, because some visualizations may depend on other objects and they likely won't work if you don't export them all.

  c) In the section *Management* -> *Index Patterns* select one (no matter which one) index pattern and press the star button to make it the default one.

.. _filebeat-7.x-label:

Filebeat
''''''''
Remember that in our case Filebeat is installed in nodes different from the ELK Server, see :ref:`installation-7.x-label`.

So, the installation playbook looks like this:

.. literalinclude:: src/tasks/filebeat.yml
   :language: yaml

As previously explained, the three first tasks are for adding the ELK's repository and installing the main component package. The last task is for configuring Filebeat. It takes a template file, which contains the Filebeat main configuration, that is, where it will take the logs from. You can find the template file :download:`here <src/templates/etc/filebeat/filebeat.yml.j2>`. Then, after Filebeat is configured, a notify is sent to a handler to start/restart the Filebeat service. The handler looks like this:

.. literalinclude:: src/handlers/filebeat-handler.yml
   :language: yaml

Make sure that the paths to the logs given in *filebeat.yml* are correct. You can check that everything is correct if you can see some data in Kibana. Go to the *Discover* section, select some index pattern and select a time window, something like 1 month ago or something that adjusts to your needs. This time window represents the time range that Kibana uses to query your logs to Elasticsearch. For example, if you want to analyze your last year logs, you should choose *1 year ago -> now*.
