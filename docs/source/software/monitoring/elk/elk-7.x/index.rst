.. _elk-7.x-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

.. role:: ruby(code)
   :language: ruby

.. role:: json(code)
   :language: json

ELK Stack 7.x Installation and Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::

.. note::
  - It is **very important** to make your cluster nodes visible between them by their DNS. If you don't do it the services might not properly start and you will have to dig into the logs and find out the problem.
  - Correctly configure the date and time of your cluster. If you don't do so, you might get in trouble visualizing your logs in Kibana. This due that the log timestamp will be on a different date of that of the Kibana server.
  - Install Java JDK 8, more recent versions may have compatibility problems.
  - You must use the same version for Logstash, Elasticsearch, Kibana, and Filebeat to avoid compatibility problems.
  - Also, when reading the guides check that the guide version is compatible with the version of your ELK stack.
  - If you have more than 500MB in logs, the RAM used by Logstash and Elasticsearch is something to consider. By default 1GB for heap, plus the jvm (which runs some other things), so more or less 2.0 - 3.0 GB of RAM. Therefore ensure that you have at least 4-6GB of RAM (even more if you have gigabytes of logs) in the machine that you will install Elasticsearch and Logstash.
  - If RAM is not a problem for you, and you want to give more RAM to Elasticsearch or Logstash, you can increase the heap size by modifying the :bash:`jvm.options` file, which is usually located under :bash:`/etc/<service>` or under :bash:`/usr/share/<service>/config`. Look for the options :bash:`-Xms1g` and :bash:`-Xmx1g` and change the *1g* to the value that fits your needs. The value that you choose should be the same in both options, for more information about the heap read `here <https://www.elastic.co/guide/en/elasticsearch/reference/current/heap-size.html>`_.
  - Install, configure, and start the services in the following order, then you will avoid repeating some steps, and also some problems. Note that this order is the same as the one in the role *elk*.

    + Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/7.1/index.htm
    + Logstash: https://www.elastic.co/guide/en/logstash/7.1/index.html
    + Kibana: https://www.elastic.co/guide/en/kibana/7.1/index.html
    + Filebeat: https://www.elastic.co/guide/en/beats/filebeat/7.1/index.html

  - If any service fails or is working in an unexpected way you should check the logs. They are usually under :bash:`/usr/share/<service>/logs` or under :bash:`/var/log/<service>`.

Basic information
-----------------

- **Official website:** https://www.elastic.co/elk-stack

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

.. _testing-7.x-label:

Testing
-------
If you want to test all the ELK Stack locally you can easily do it using `Vagrant <https://www.vagrantup.com/intro/index.html>`_.

.. note:: Remember that if you have a relatively large amount of logs, Elasticsearch and Logstash use about 4-6GB RAM (or even more) when filtering and indexing data.

The vagrantfile looks like this:

.. literalinclude:: src/Vagrantfile
   :language: ruby

In the configuration of each virtual machine, there is a subsection for provisioning. In that subsection, there is a variable that is accessed as :bash:`ansible.playbook`. You have to set it to the path to your main ansible playbook. You should use the playbooks that were explained in the previous section, :ref:`installation-7.x-label`. Take a look at the provisioning subsection in the vagrantfile, note that the :bash:`ansible.extra_vars` defines a variable called :bash:`machine`, so if you are using the playbooks explained before, this variable must match the hostname of the virtual machine. The hostname of the virtual machine can be changed with the variable :bash:`vm.hostname`. For more information read the Vagrant documentation about `vagrantfiles <https://www.vagrantup.com/docs/vagrantfile/>`_. Before starting the cluster please see the directory structure of our Ansible project :download:`here <config/ansible_dir_structure.txt>`.

The *site.yml* is pretty simple:

.. literalinclude:: src/site.yml
   :language: yaml

The *4p0l0.yml*, *cr0n05.yml*, and *elk.yml* playbooks are simple too:

.. literalinclude:: src/playbooks/4p0l0.yml
   :language: yaml

.. literalinclude:: src/playbooks/cr0n05.yml
   :language: yaml

.. literalinclude:: src/playbooks/elk.yml
   :language: yaml

To start up the virtual cluster use the following bash script with the argument :bash:`up`:

.. literalinclude:: src/scripts/run.sh
   :language: bash

.. note:: Change elk, cr0n05, 4p0l0, to the virtual machine names that you set up in your Vagrantfile. If you are using the above vagrantfile you do not have to change them.

Make the virtual machines visible between them by their hostname. You just have to change the :bash:`/etc/hosts` file and add the ip address of the virtual machine that you want to see followed by its hostname. For example, make elk visible by others and in the *elk* machine.

.. code-block:: bash

   # file /etc/hosts
   0.0.0.0         elk      # allow others to use the elk hostname instead of the ip
   192.168.1.2     cr0n05   # make cr0n05 visible to elk by its hostname not just its ip
   192.168.1.3     4p0l0

After making them visible, run the script with the argument :bash:`provision-elk` so that Elasticsearch, Logstash, and Kibana will be installed. Configure Kibana as explained in :ref:`kibana-7.x-label`. Then run the script with the argument :bash:`provision-filebeat`. Now if everything is ok, you can add logging sources, create visualizations and dashboards and whatever you want. To stop the cluster run :bash:`$ ./run.sh halt`.

.. _new-source-7.x:

Adding a new Logging Source
---------------------------
If you already have installed your ELK cluster, adding a new logging source is simple. This guide is based only on the full ELK Stack, if you have a log collector different from Filebeat, or you send your logs directly to Elasticsearch without Logstash, you should know how to do. But the principles should be the same. Follow these steps:

Logging Source
''''''''''''''
1. Identify your logging source. For example, you want to track the users that log in to your SSH server. So the sshd service writes its logs to the file :bash:`/var/log/secure`.

2. After knowing where to take your logs from, you have to identify the specific logs that are useful for you. For example:

.. code-block:: bash
   :linenos:

   Jun 25 15:30:02 elk sshd[5086]: pam_unix(sshd:session): session closed for user vagrant
   Jun 25 17:08:11 elk sshd[5185]: Accepted publickey for vagrant from 10.0.2.2 port 54128 ssh2: RSA SHA256:64u6q4IdjxSFhVGdqwJa60y/nMx7oZWb0dAsNqMIMvE
   Jun 25 17:08:11 elk sshd[5185]: pam_unix(sshd:session): session opened for user vagrant by (uid=0)

The first and third logs might not be useful in this case, but the second log is the one that helps us.

.. _how-to-filter-7.x:

Filtering
'''''''''
Now it's time to parse and filter the log by the important information. You accomplish this task using Logstash and the Kibana's Grok debugging tool. Grok is a Logstash filtering plugin used to match patterns in your logs and extract from them useful information. For more information about Grok read `the documentation <https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html>`_. So, follow these steps:

1. Open Kibana. Go to *Dev Tools* -> *Grok Debugger*. Here you will find three main text areas. The first one is where you put the log that you want to filter. The second one is where you tell Grok how to parse it. The third one is where you see your results in JSON format, which is the format in which your logs are sent and indexed by Elasticsearch.

2. But how to filter an arbitrary log?. Grok uses regular expressions to match patterns in the log. You can tag these patterns and give them a name, and by that name is how you will find your information under your Elasticsearch indices. Here is the regular expression that matches the *timestamp*, the *event* state (if the user could or couldn't log in), the *user* that tried to log in, the *ip address* that is trying to log in, the *port* number and the user *signature*. So put the second line log presented above in the first white box in Kibana. Put the regular expression below in the second white box, and press simulate:

.. code-block:: ruby

   %{SYSLOGTIMESTAMP:log.timestamp} %{SYSLOGHOST:system_hostname} sshd(.*)?: (?<sshd_event>[a-zA-Z]+) %{DATA:sshd_method} for (invalid user )?%{DATA:sshd_user} from %{IPORHOST:sshd_guest_ip} port %{NUMBER:sshd_guest_port} ssh2(: %{GREEDYDATA:sshd_guest_signature})?

3. First, the regular expression library used by Grok is `Oniguruma <https://github.com/kkos/oniguruma/blob/master/doc/RE>`_. The regular expression presented above is pretty simple to understand:

   - **%{SYSLOGTIMESTAMP:log.timestamp}**: *SYSLOGTIMESTAMP* is a Grok built-in regular expression, these and many more built-in regular expressions can be found in this `repository <https://github.com/logstash-plugins/logstash-patterns-core/blob/master/patterns/grok-patterns>`_. *log.timestamp* is how I decided to **identify** the matched string. So this expression will match from *Jun ...* to *... 17:08:11*.
   - **%{SYSLOGHOST:system_hostname}**: *SYSLOGHOST* matches the log hostname and identifies it as *system_hostname*. Note that this is your server's hostname, not the user's hostname.
   - **sshd(.\*)?**: This expression matches the literal string 'sshd', followed by anything (but new line), '.', the parentheses are grouping operators, so they group the expression '.*', '('')', and this whole expression is optional, '?', which means it might appear in the log or may not appear. In other words, there might not be something after the word 'sshd', if so, then it won't match anything. Note that this expression doesn't have any identifier, that is because I don't care whatever is matched there.
   - **(?<sshd_event>[a-zA-Z]+)**: This is an important expression. The expression '(?<xxx>...)' can be used when there isn't a default Grok pattern for your needs. Instead of 'xxx' you type the name that you want to give to that matched string. Instead of '...' you put the regular expression that matches your needed string. In this case, I know that the event is composed only by letters, so '[a-zA-Z]' means any lowercase or uppercase letter, the '+' means one or more times. So in summary, '[a-zA-Z]+' means any lowercase or uppercase letter one or more times. This expression can be replaced by the Grok default pattern %{DATA:sshd_event}, but I wanted to use '(?<xxx>...)' so that you can use it when you need it.
   - **%{DATA:sshd_method}**: *DATA* matches anything (but new lines), but that anything may or may not appear, that is, it's optional. But I always need the *sshd_method* field, why to let it as optional?. Well, it's just for simplicity, instead of typing my own regular expression I wanted to use the built-in %{DATA:...}.
   - **(invalid user )?**: If the event is 'Invalid' instead of 'Accepted' or 'Failed' this string appears, so that's why it is optional.
   - **%{DATA:sshd_user}**: *DATA* matches anything (but new lines), but that anything may or may not appear, that is, it's optional.
   - **%{IPORHOST:sshd_guest_ip}**: *IPORHOST* matches IP addresses, including IPv6. That IP address is given the identifier *sshd_guest_ip*.
   - **%{NUMBER:sshd_guest_port}**: *NUMBER* matches numbers, in this case, the client's socket port number.
   - **(: %{GREEDYDATA:sshd_guest_signature})?**: *GREEDYDATA* matches anything (but new lines). In this case, it matches the guest signature, but sometimes it might not appear, so that's why it is enclosed in an optional construct '(...)?'.
   - The other expressions, 'sshd', 'for', 'from', 'port', and 'ssh2' are literal strings, so Grok has to find them in the string that is being parsed, **otherwise the whole string is rejected**.

4. Now that you know how to parse your log, it's time to change your Logstash pipeline configuration. Before proceeding, I recommend you to read this short guide about how a pipeline configuration file `looks <https://www.elastic.co/guide/en/logstash/current/configuration-file-structure.html>`_. Also, it would be very useful to read about what is Logstash `for <https://www.elastic.co/guide/en/logstash/current/index.html>`_. Go to the end of the *filter* section and add the following:

.. code-block:: ruby

   if [fromsecure] {

   }

If you added this logging source before, :bash:`/var/log/secure`, don't add that *if* sentence, you surely have it somewhere else in the *filter* section. But, why :bash:`[fromsecure]`?, what does that mean?. It checks if the JSON received has a field called *fromsecure*. I'll explain the existence of that field later in :ref:`add-path-filebeat-7.x`, just add it.

5. Under that *if* sentence add a *grok* block. This is how you tell to Logstash that you want to use a *filter* plugin, in this case *Grok*. So, add the following:

.. code-block:: ruby

   grok {
     match => {
       "message" => []
     }
     add_field => {}
   }

The *match* and *add_field* sub-blocks tell Grok that you want to use those options. The *match* option is used to parse (what was explained in the third point) fields, those fields are passed to the *filter* section by the *input* section, which in turn receives messages from a *Filebeat* service, or a `Dead letter queue <https://www.elastic.co/guide/en/logstash/current/dead-letter-queues.html>`_. The *add_field* adds fields to the JSON message in case that the match option successfully matched a string. This is useful in the *output* part of the pipeline, so you send to Elasticsearch only what was successfully parsed, and not everything that arrives at the *input*.

6. Under the *match* sub-block and the brackets, and between double quotes, add the regular expression that you need to match your log. Under the *add_field* sub-block add the following too:

.. code-block:: ruby

   grok {
     match => {
       "message" => [
         "%{SYSLOGTIMESTAMP:log.timestamp} %{SYSLOGHOST:system_hostname} sshd(.*)?: (?<sshd_event>[a-zA-Z]+) %{DATA:sshd_method} for (invalid user )?%{DATA:sshd_user} from %{IPORHOST:sshd_guest_ip} port %{NUMBER:sshd_guest_port} ssh2(: %{GREEDYDATA:sshd_guest_signature})?"
       ]
     }
     add_field => {
       "type" => "secure_sshd_login_attempt"
       "secure_correctly_filtered" => "true"
     }
   }


The *type* field serves to differentiate your logs in the same *index* in Elasticsearch. For example, :bash:`/var/log/secure` stores logs about the system security (e.g who executes sudo commands), not only logs about ssh. The *secure_correctly_filtered* is used in the *output* section to send only the information that was correctly filtered.

7. The following filter plugin is **extremely important** to correctly visualize your information. Kibana uses a *metafield*, called **@timestamp**, to organize and show you the information based on dates. Logstash adds that field by default when a log is received in the *input* section. The problem is that the *log.timestamp* field that we added before has a different date, it has the timestamp that corresponds to the log creation. The time when the log arrives to Logstash is likely to be very different from the time that the log was generated by the service (in this case sshd). There might be a difference of months, even years, because the log that you are indexing might be from the last month/year. To solve this problem Logstash has a plugin called *date*. This plugin can be used to replace the information in the metafield *@timestamp* with any other field that has a timestamp, in our case *log.timestamp*. It has more `options <https://www.elastic.co/guide/en/logstash/current/plugins-filters-date.html>`_ than the two presented here. The basic usage is the following:

.. code-block:: ruby

   date {
     match => [ "log.timestamp", "MMM dd yyyy HH:mm:ss", "MMM d yyyy HH:mm:ss", "MMM dd HH:mm:ss", "MMM d HH:mm:ss" ]
     timezone => "America/Bogota"
   }

The *match* option tells the plugin to parse the field in the first string given in the array, *log.timestamp*. The following strings are the format in which the field to parse might have the timestamp. For example, "MMM dd yyyy HH:mm:ss", means that the timestamp might be in the format: Three letter month, MMM. A two digit day, dd. A four digit year, yyyy. A two digit hour, HH. A two digit minutes, mm. And a two digit seconds, ss. The rest of the options tells to the plugin that the timestamp might have those variants.

The *timezone* option tells the plugin to update the timezone in *@timestamp* for the given timezone. Elasticsearch uses UTC as timezone. It cannot be changed, that is, Elasticsearch uses it to work properly. Even though we cannot change it, we update the *@timestamp* with our real timezone because Kibana converts it underneath to your browser's timezone. So, it is important to have the same timezone in your browser and in your logs.

It is important to say that this plugin is **used only** in case that Grok parsed successfully the log.

8. The following filter plugin is used to remove unnecessary fields from the JSON that will be sent to Elasticsearch. This is how we can use it:

.. code-block:: ruby

   mutate {
      remove_field => ["fromsecure", "log.timestamp"]
   }

The *remove_field* option is given a list of fields that you want to remove. The *fromsecure* field is used in the *if* sentence above and is not needed anymore, I'll explain it later in :ref:`add-path-filebeat-7.x`. The *log.timestamp* is not needed anymore because we already have a field that contains the log timestamp, *@timestamp*.

9. We are done with the filters needed by Logstash. So, up to this point you should have something like this:

.. literalinclude:: src/templates/etc/logstash/conf.d/guide_main_pipeline.conf.j2
   :linenos:
   :language: ruby

The first block, *input*, indicates to Logstash where it will receive logs from. In our case Filebeat, on port 5044, and something called the **Dead Letter Queue**. This is where logs that couldn't be indexed go. For example, Logstash received a log, but Elasticsearch crashed, so the log cannot be indexed and the log is sent to the Dead Letter Queue so it can be reindexed later.

The last block, *output*, indicates to Logstash where it will send logs to. In this case Elasticsearch, which is in the host *elk* on port *9200*, to the *index* secure. Elasticsearch indexes will be explained in :ref:`create-indexes-mappings-7.x`, think about them as tables where your logs will be stored.

Can you note the *if* sentence in line 42. Do you remember the *add_field* option explained in the Grok filter, well it is used here to send logs to the proper index if and only if they were correctly filtered by Grok.

10. Restart the Logstash service and hopefully, everything will work perfectly. Sometimes, the service seems to start correctly but it failed reading the pipeline file (what we just write). To check that everything is perfect check out the log when Logstash is starting, commonly :bash:`/usr/share/logstash/logs/logstash-plain.log`. You should see some logs similar to these:

.. code-block:: bash

   [2019-07-03T10:04:46,238][INFO ][logstash.agent           ] Pipelines running {:count=>1, :running_pipelines=>[:main], :non_running_pipelines=>[]}
   [2019-07-03T10:04:46,705][INFO ][org.logstash.beats.Server] Starting server on port: 5044
   [2019-07-03T10:04:50,337][INFO ][logstash.agent           ] Successfully started Logstash API endpoint {:port=>9600}

.. _create-indexes-mappings-7.x:

Creating Indexes and Mappings
'''''''''''''''''''''''''''''
Indexes can be seen analogically to SQL tables. They are where your information is stored. Mappings are how you structure that data using a JSON format. Let's see the example to match the log parsed above:

.. code-block:: bash

   PUT /secure
   {
     "mappings":{
       "properties":{
         "type": { "type" : "keyword" },
	 "system_hostname":{ "type": "keyword" },
	 "sshd_guest_ip":{ "type": "ip" },
	 "sshd_guest_port":{ "type": "integer" },
	 "sshd_guest_signature":{ "type": "text" },
	 "sshd_event":{ "type": "keyword" },
	 "sshd_method":{ "type": "keyword" },
	 "sshd_user":{ "type": "keyword" }
       }
     }
   }

Elasticsearch offers a REST API to manage the data. So, *PUT* inserts new information into Elasticsearch. So, if you created an index with the name *secure* before, Elasticsearch will throw an error unless you use *POST*, which is used to update the existing information. *"mappings"* refers to the property that describes the structure of the index. *"properties"* as its name says, is used to describe the properties of the mappings. The following items are the fields and its types, that is, these fields describe the types of the information parsed in logstash. For example, *"sshd_guest_ip"* is the field that represents the ip address parsed from the logs. Its type is *ip*, Elasticsearch has a built-in type called *ip* which eases the visualization of ip addresses. The *"type"* field is useful when your source, in this case :bash:`/var/log/secure`, sends logs from many services. Remember the *add_field* option under the Grok plugin in :ref:`how-to-filter-7.x`, we added the field: "type" => "sshd_login_attempt". But, if you are also indexing the sudo commands logs, you can change this field to something like: "type" => "secure_sudo_command". In this way, you can differentiate them easily.

.. _add-path-filebeat-7.x:

Adding the log path to Filebeat
'''''''''''''''''''''''''''''''
Now that you have your data filtered and properly structured, it's time to start sending it to Logstash. Edit the file :bash:`/etc/filebeat/filebeat.yml`, under the section *filebeat.inputs:* add:

.. code-block:: yaml
   :linenos:

   - type: log
     paths:
       - /var/log/secure*
     fields:
       fromsecure: true
     fields_under_root: true

The first line indicates the type of information that will be collected. The second line indicates the paths where your logs are located, in this case :bash:`/var/log/`, and :bash:`secure*` matches all the logs that start with the name *secure*. This wildcard is used becase some logs have a date at the end of its name, so it will be inefficiently to add over and over again a path when a log appears in :bash:`/var/log/`. The fourth line, *fields*, indicates to Filebeat to add a new field in to the JSON sent to Logstash. Do you remember the first *if* sentence in the :ref:`how-to-filter-7.x` section. Well, this field is added so that in Logstash you can differentiate the many different log sources. The last option, *fields_under_root*, is used to add the fields under the root of the JSON, and not nested into a field called *beat*.

Restart the Filebeat service and hopefully everything will work perfectly.

Create Index Patterns
'''''''''''''''''''''
Now that you have some data indexed in Elasticsearch, you can create *Index Patterns*. These are used by Kibana to match indexes and take the data that will be plotted from those indexes matched by your pattern.

Go to *Management* -> *Index Pattern* -> *Create index pattern*. Select its name, and as filter field select *@timestamp*.

Plot your data
''''''''''''''
The easiest plot you can create is a frequency histogram. That's what I will explain, but there are a lot more features that Kibana `offers <https://www.elastic.co/guide/en/kibana/current/visualize.html>`_.

In Kibana go to *Visualize*, press the **+** button, select your type of visualization, in this case, *Vertical Bar*.

Authors
-------

- Hamilton Tobon Mosquera <htobonm@eafit.edu.co>
