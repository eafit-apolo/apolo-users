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

.. contents::

.. note::
  - It is **very important** to make your cluster nodes visible between them by their DNS. If you don't do it the services might not properly start and you will have to dig into the logs and find out the problem.
  - Correctly configure the date and time of your cluster. If you don't do so, you might get in trouble visualizing your logs in Kibana. This due that the log timestamp will be on a different date of that of the Kibana server.
  - Install Java JDK 8, more recent versions may have compatibility problems.
  - You must use the same version for Logstash, Elasticsearch, Kibana, and Filebeat to avoid compatibility problems.
  - Also, when reading the guides check that the guide version is compatible with the version of your ELK stack.
  - If you have more than 500MB in logs, the RAM used by Logstash and Elasticsearch is something to consider. By default 1GB for heap, plus the jvm (which runs some other things), so more or less 2.0 - 3.0 GB of RAM. Therefore ensure that you have at least 4-6GB of RAM (even more if you have gigabytes of logs) in the machine that you will install Elasticsearch and Logstash.
  - If RAM is not a problem for you, and you want to give more RAM to Elasticsearch or Logstash, you can increase the heap size by modifying the :bash:`jvm.options` file, which is usually located under :bash:`/etc/<service>` or under :bash:`/usr/share/<service>/config`. Look for the options :bash:`-Xms1g` and :bash:`-Xmx1g` and change the *1g* to the value that fits your needs. The value that you choose should be the same in both options, for more information about the heap read `here <https://www.elastic.co/guide/en/elasticsearch/reference/current/heap-size.html>`_.
  - Install, configure, and start the services in the following order, then you will avoid repeating some steps, and also some problems. Note that this order is the same as the one in the Ansible role *elk*.

    + Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/7.1/index.htm
    + Logstash: https://www.elastic.co/guide/en/logstash/7.1/index.html
    + Kibana: https://www.elastic.co/guide/en/kibana/7.1/index.html
    + Filebeat: https://www.elastic.co/guide/en/beats/filebeat/7.1/index.html

  - If any service fails or is working in an unexpected way you should check the logs. They are usually under :bash:`/usr/share/<service>/logs` or under :bash:`/var/log/<service>`.

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
Also, it is important to note that the stack of applications was installed on CentOS 7 using `Ansible <https://www.ansible.com/>`_. Therefore, in the next subsections, there will be an explanation of the Ansible roles used to install and configure each of the ELK Stack components. The directory structure of the Ansible project is described :download:`here <config/ansible_dir_structure.txt>`.

Before proceeding to the installation of each main component, it is needed to add the ELK's repository to the rpm's repositories.

.. literalinclude:: src/tasks/add-elk-repo.yml
   :language: yaml

This playbook basically adds the ELK's gpg signing key to rpm and takes a template, :bash:`roles/elk/templates/etc/yum.repos.d/elk.repo.j2`, to render it in the :bash:`/etc/yum/repos.d/` directory, which is where :bash:`rpm` looks for its repositories. The template file is this:

.. literalinclude:: src/templates/etc/yum.repos.d/elk.repo.j2
   :language: bash

The :yaml:`{{ elk_version }}` jinja variable refers to the version of your desired stack. In this case 7.x. This variable must be passed as an argument when running Ansible or have it defined somewhere in the Ansible project. For more information about variables go to the Ansible's `documentation <https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html>`_.

Also, it is needed to install Java 8 and the main components (Elasticsearch, Logstash, Kibana) packages.

.. literalinclude:: src/tasks/install-elk.yml
   :language: yaml

The variable :yaml:`{{ java_version }}` represents the java version used, in this case (and to ensure `compatibility <https://www.elastic.co/support/matrix#matrix_jvm>`_) 1.8.0.

Elasticsearch
'''''''''''''
After installing the needed package, Elasticsearch is configured like this:

.. literalinclude:: src/tasks/elasticsearch-config.yml
   :language: yaml

The Elasticsearch main configuration file, which is the template :bash:`roles/elk/templates/etc/elasticsearch/elasticsearch.yml.j2`, is rendered in :bash:`/etc/elasticsearch/`. The template can be found :download:`here <src/templates/etc/elasticsearch/elasticsearch.yml.j2>`. In that template, there is a variable called :yaml:`{{ machine }}`, which is rendered as the hostname of the ELK server, in this case :bash:`elk`. It can be changed to whatever you want, but from now on in this guide, :bash:`elk` is what will be used. Note that, when the configuration file is placed, a notify is made so that the Elasticsearch service is started/restarted. The notify handler looks like this:

.. literalinclude:: src/handlers/elasticsearch-handler.yml
   :language: yaml

.. note:: Note that the identifier given to the notify action in the configuration task must be same as the identifier given to the handler.


Logstash
''''''''
After installing the needed package, Logstash is configured like this:

.. literalinclude:: src/tasks/logstash-config.yml
   :language: yaml

The first task copies two configuration files, :bash:`pipelines.yml`, and :bash:`logstash.yml` to :bash:`/etc/logstash`. The former indicates to Logstash where to find our pipelines configuration files. It can be found :download:`here <src/files/etc/logstash/pipelines.yml>`. The latter is the main configuration file for Logstash. It can be found :download:`here <src/files/etc/logstash/logstash.yml>`.

The second task takes a template, :bash:`roles/elk/templates/etc/logstash/conf.d/main_pipeline.conf.j2`, and renders it in the pipelines directory, :bash:`/etc/logstash/conf.d`. The template represents the description of our main pipeline, that is, inputs, filters, and outputs. You can find it :download:`here <src/templates/etc/logstash/conf.d/main_pipeline.conf.j2>`.

.. note:: **Logstash Filters:** It is important to know the version of the filter plugins that you are using so that the proper documentation can be found.

.. _kibana-7.x-label:

Kibana
''''''
After installing the needed package, Kibana is configured like this:

.. literalinclude:: src/tasks/kibana-config.yml
   :language: yaml

The Kibana main configuration file, which is the template :bash:`roles/elk/templates/etc/kibana/kibana.yml.j2`, is rendered in :bash:`/etc/kibana/`. The template can be found :download:`here <src/templates/etc/kibana/kibana.yml.j2>`. Also, when the configuration file is placed, a notify is made so that the Kibana service is started/restarted. The notify handler looks like this:

.. literalinclude:: src/handlers/kibana-handler.yml
   :language: yaml

After installing and configuring Kibana, it is time to give structure to our logs and create/import the dashboards and visualizations needed:

1. Access the web interface through *http://elk:5601*. To access it using the domain name :bash:`elk` remember to make your cluster nodes visible by their DNS', in this case, the node where you have installed Kibana.
2. Organize the information. This will help you plot all your data easily. If you want to add a new logging source see the section below :ref:`new-source-7.x`.

  .. note:: Create the indexes and the mappings BEFORE sending any data to Elasticsearch.

  a) Create *indexes* and *mappings*, that is, give types and format to the data.

     * In the **Dev Tools** section, copy and paste the contents of the index and mappings :download:`file <config/indexes_and_mappings.txt>`, then select it all and click on RUN. Note that these mappings are the ones that we use, you can take them as an example and create yours.
     * To easily see your mappings go to: **Management** -> **Index management** -> **Click on your index** -> **Mapping**.

  b) Create the dashboard and visualizations.

     * Go to the **Management** section, then, go to the subsection **Saved Objects**, then, **Import**, and import the dashboards and visualizations :download:`file <config/dashboards_and_visualizations.json>`.

       .. note:: If you want to export the visualizations to a json format, remember to check the *every saved object* option, because some visualizations may depend on other objects and they likely won't work if you don't export them all.

c) In the section **Management** -> **Index Patterns** select one (no matter which one) index pattern and press the star button to make it the default one.

.. _filebeat-7.x-label:

Filebeat
''''''''
Recall that in this case Filebeat is installed in nodes different from the ELK Server, the architecture used here is on :ref:`installation-7.x-label`.

So, the installation playbook looks like this:

.. literalinclude:: src/tasks/filebeat.yml
   :language: yaml

As previously explained, the three first tasks are for adding the ELK's repository and installing the main component package. The last task is for configuring Filebeat. It takes a template file that contains the Filebeat main configuration, basically, where it will take the logs from. You can find the template file :download:`here <src/templates/etc/filebeat/filebeat.yml.j2>`. Then, after Filebeat is configured, a notify is sent to a handler to start/restart the Filebeat service. The handler looks like this:

.. note:: Note that the folder under :bash:`roles/` is not :bash:`elk/` anymore. It is :bash:`master/` because the idea is to install the log collector in the master nodes, which then, will start sending logs to the :bash:`elk` server.

.. literalinclude:: src/handlers/filebeat-handler.yml
   :language: yaml

Make sure that the paths to the logs given in :bash:`filebeat.yml` are correct. You can check that everything is correct if you can see some data in Kibana. Go to the **Discover** section, select some index pattern and select a time window, something like 1 month ago, or something that adjusts to your needs. This time window represents the time range that Kibana uses to query your logs to Elasticsearch. For example, if to analyze the last year logs, choose **1 year ago -> now**.
