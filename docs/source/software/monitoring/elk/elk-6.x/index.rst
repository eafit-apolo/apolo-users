.. _elk-6.x-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

.. role:: ruby(code)
   :language: ruby

ELK Stack 6.x Installation and Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::

.. note::

  - Install Java JDK 8, more recent versions may have compatibility problems.
  - You must use the same version for Logstash, Elasticsearch, Kibana to avoid compatibility problems.
  - Also, when reading the guides check that the guide version is compatible with the version of your ELK stack.
  - Consider the amount of RAM used by Logstash and Elasticsearch. By default 1GB for heap, plus the JVM which is about 2.5 GB of RAM.
  - Install, configure, and start the services in the following order, then you will avoid repeating some steps, and also some problems. Note that this order is the same as the one in the role *elk*.

    + Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/6.6/index.html
    + Logstash: https://www.elastic.co/guide/en/logstash/6.6/index.html
    + Kibana: https://www.elastic.co/guide/en/kibana/6.6/index.html

    + Filebeat: https://www.elastic.co/guide/en/beats/filebeat/6.6/index.html

Basic information
-----------------

- **Official website:** https://www.elastic.co/elk-stack

.. _installation-label:

Installation
------------
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

Also, it is important to note that the stack of applications was installed on CentOS 7 using `Ansible <https://www.ansible.com/>`_. Therefore, in the next subsections, there will be an explanation of the tasks used to install each of the ELK Stack components.

Before proceeding to the installation of each main component, it is needed to add the ELK's repository to the rpm's repositories.

.. literalinclude:: src/tasks/add-elk-repo.yml
   :language: yaml

This playbook basically adds the ELK's gpg signing key and takes a template to render it in the :bash:`/etc/yum/repos.d/` directory, which is where :bash:`rpm` looks for its repositories. The template file is this:

.. literalinclude:: src/templates/etc/yum.repos.d/elk.repo.j2
   :language: yaml

The :yaml:`{{ elk_version }}` jinja variable refers to the version of your desired stack. In this case 6.c. This variable must be passed as an argument when running ansible or have it defined somewhere in your ansible project. For more information about variables go to the Ansible's `documentation <https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html>`_.

Also, it is needed to install Java 8 and the main components (elasticsearch, logstash, kibana) packages.

.. literalinclude:: src/tasks/install-elk.yml
   :language: yaml

The variable :yaml:`{{ java_version }}` represents the java version used, in our case (and due to compatibility) 1.8.0.

Elasticsearch
'''''''''''''
After installing the needed package, Elasticsearch is configured like this:

.. literalinclude:: src/tasks/elasticsearch-config.yml
   :language: yaml

The Elasticsearch main configuration file, which is a template, is rendered in :bash:`/etc/elasticsearch/`. The template can be found :download:`here <src/templates/etc/elasticsearch/elasticsearch.yml.j2>`. In that template, you will find a variable called :yaml:`{{ machine }}`, which is rendered as the hostname of our ELK server, in our case *elk*. So in your case, you can use whatever you want, but from now on in this guide, we will use the hostname *elk*. Also, when the configuration file is placed, a notify is made so that the Elasticsearch service is started/restarted. The handler looks like this:

.. literalinclude:: src/handlers/elasticsearch-handler.yml
   :language: yaml

Logstash
''''''''
After installing the needed package, Logstash is configured like this:

.. literalinclude:: src/tasks/logstash-config.yml
   :language: yaml

The first task copies two configuration files, *pipelines.yml* and *logstash.yml*. The first file indicates to Logstash where to find our pipelines configuration files. You can find it :download:`here <src/files/etc/logstash/pipelines.yml>`. The second one is the main configuration file for Logstash. You can find it :download:`here <src/files/etc/logstash/logstash.yml>`.

The second task takes a template and renders it in the pipelines directory. The template represents the description of our main pipeline, that is, inputs, filters, and outputs. You can find it :download:`here <src/templates/etc/logstash/conf.d/main_pipeline.conf.j2>`.

.. note:: **Logstash Filters:** It is important to know the version of the filter plugins that you are using so you will be able to search for the proper documentation.

.. _kibana-label:

Kibana
''''''
After installing the needed package, Kibana is configured like this:

.. literalinclude:: src/tasks/kibana-config.yml
   :language: yaml

The Kibana main configuration file, which is a template, is rendered in :bash:`/etc/kibana/`. The template can be found :download:`here <src/templates/etc/kibana/kibana.yml.j2>`. Also, when the configuration file is placed, a notify is made so that the Kibana service is started/restarted. The handler looks like this:

.. literalinclude:: src/handlers/kibana-handler.yml
   :language: yaml

After installing and configuring Kibana, it is time to give structure to our logs and create/import the dashboards and visualizations needed:

1. Access the web interface through *http://elk:5601*. To access it using the domain name *elk* remember to add elk to your *hosts* file.
2. Organize the information. This will help you plot all your data easily.

  .. note:: Create the indexes, and the mappings BEFORE sending any data to Elasticsearch.

  a) Create *indexes* and *mappings*, that is, give types and formats to your data.

     * In the *Dev Tools* section, copy and paste the content of the index and mappings :download:`file <config/index_and_mappings.txt>`, then select it all and click on RUN. Note that these mappings are the ones that we use, you can take them as an example and create yours, for more information go to ELK's documentation about `mappings <https://www.elastic.co/guide/en/kibana/current/tutorial-load-dataset.html#_set_up_mappings>`_.
     * To easily see your mappings go to: Management -> Index management -> Select your index -> Mapping.

  b) Continue with **c** and **d** steps after :ref:`filebeat-label` is sending information to logstash. So please go to :ref:`filebeat-label`.


     * You can check that it is already done if you can create *index patterns*, that is, it won't let you create them if you don't have any data.

  c) Create the dashboard and visualizations.

     * Go to *Management*, then, under the Kibana section go to *Saved Objects*, then, *Import*, and import the dashboards and visualizations :download:`file <config/dashboards_and_visualizations.json>`.
     * If you want to export the visualizations to a JSON format, remember to export every saved object, because some visualizations may depend on other objects and they won't work if you don't export them all.

  d) In the section *Management* -> *Index Patterns* select one (no matter which one) index pattern and press the start button to make it the default one.

.. _filebeat-label:

Filebeat
''''''''
Remember that in our case Filebeat is installed in servers different from the ELK Server, see :ref:`installation-label`.

So, the installation playbook looks like this:

.. literalinclude:: src/tasks/filebeat.yml
   :language: yaml

As previously explained, the three first tasks are for adding the ELK's repository and installing the main component package. The last task is for configuring Filebeat. It takes a template file, which contains the Filebeat main configuration, that is, where it will take the logs from. You can find the template file :download:`here <src/templates/etc/filebeat/filebeat.yml.j2>`. Then, after Filebeat is configured, a notification is sent to a handler to start/restart the Filebeat service. The handler looks like this:

.. literalinclude:: src/handlers/filebeat-handler.yml
   :language: yaml

Testing
-------
If you want to test all the ELK Stack locally you can easily do it using `Vagrant <https://www.vagrantup.com/intro/index.html>`_.

.. note:: Elasticsearch and Logstash use together at least 5 GB of RAM when not in idle state.

The vagrantfile looks like this:

.. literalinclude:: src/Vagrantfile
   :language: ruby

In the configuration of each virtual machine, there is a subsection for provisioning. In that subsection, there is a variable that is accessed as :bash:`ansible.playbook`. You have to set it to the path to your ansible playbook. You should use the playbook that was explained in the previous section, :ref:`installation-label`. Also in this provisioning subsection, note that the :bash:`ansible.extra_vars` defines a variable called :bash:`machine`, so if you are using the playbook explained before, this variable must match the hostname of the virtual machine. The hostname of the virtual machine can be changed with the variable :bash:`vm.hostname`. For more information read the Vagrant documentation about `vagrantfiles <https://www.vagrantup.com/docs/vagrantfile/>`_.

To start up the virtual cluster use the following bash script with the argument :bash:`up`:

.. literalinclude:: src/scripts/run.sh
   :language: bash

.. note:: Change elk, cr0n05, 4p0l0, to the virtual machine names that you set up in your Vagrantfile. If you are using the vagrantfile from above, you do not have to change them.

Make the virtual machines visible between them by their hostname. You just have to change the :bash:`/etc/hosts` file and add the ip address of the virtual machine that you want to see followed by its hostname. For example, make elk visible by others and in the *elk* machine.

.. code-block:: yaml

   # file /etc/hosts
   0.0.0.0         elk      # allow others to use the elk hostname instead of the ip
   192.168.1.2     cr0n05   # make cr0n05 visible to elk by its hostname not just its ip
   192.168.1.3     4p0l0

After making them visible, run the script with the argument :bash:`provision-elk` so that Elasticsearch, Logstash, and Kibana will be installed. Configure Kibana as explained in :ref:`kibana-label`. Then run the script with the argument :bash:`provision-filebeat`. When it finishes you should be able to open your browser in the elk machine's ip address port 5601.

Authors
-------

- Hamilton Tobon Mosquera <htobonm@eafit.edu.co>
