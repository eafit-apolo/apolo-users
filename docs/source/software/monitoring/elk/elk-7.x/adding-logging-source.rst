.. _adding-logging-source-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

.. role:: ruby(code)
   :language: ruby

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

   %{SYSLOGTIMESTAMP:log_timestamp} %{SYSLOGHOST:system_hostname} sshd(.*)?: (?<sshd_event>[a-zA-Z]+) %{DATA:sshd_method} for (invalid user )?%{DATA:sshd_user} from %{IPORHOST:sshd_guest_ip} port %{NUMBER:sshd_guest_port} ssh2(: %{GREEDYDATA:sshd_guest_signature})?

3. First, the regular expression library used by Grok is `Oniguruma <https://github.com/kkos/oniguruma/blob/master/doc/RE>`_. The regular expression presented above is pretty simple to understand:

   - **%{SYSLOGTIMESTAMP:log_timestamp}**: *SYSLOGTIMESTAMP* is a Grok built-in regular expression, these and many more built-in regular expressions can be found in this `repository <https://github.com/logstash-plugins/logstash-patterns-core/blob/master/patterns/grok-patterns>`_. *log_timestamp* is how I decided to **identify** the matched string. So this expression will match from *Jun ...* to *... 17:08:11*.
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
         "%{SYSLOGTIMESTAMP:log_timestamp} %{SYSLOGHOST:system_hostname} sshd(.*)?: (?<sshd_event>[a-zA-Z]+) %{DATA:sshd_method} for (invalid user )?%{DATA:sshd_user} from %{IPORHOST:sshd_guest_ip} port %{NUMBER:sshd_guest_port} ssh2(: %{GREEDYDATA:sshd_guest_signature})?"
       ]
     }
     add_field => {
       "type" => "secure_sshd_login_attempt"
       "secure_correctly_filtered" => "true"
     }
   }


The *type* field serves to differentiate your logs in the same *index* in Elasticsearch. For example, :bash:`/var/log/secure` stores logs about the system security (e.g who executes sudo commands), not only logs about ssh. The *secure_correctly_filtered* is used in the *output* section to send only the information that was correctly filtered.

7. The following filter plugin is **extremely important** to correctly visualize your information. Kibana uses a *metafield*, called **@timestamp**, to organize and show you the information based on dates. Logstash adds that field by default when a log is received in the *input* section. The problem is that the *log_timestamp* field that we added before has a different date, it has the timestamp that corresponds to the log creation. The time when the log arrives to Logstash is likely to be very different from the time that the log was generated by the service (in this case sshd). There might be a difference of months, even years, because the log that you are indexing might be from the last month/year. To solve this problem Logstash has a plugin called *date*. This plugin can be used to replace the information in the metafield *@timestamp* with any other field that has a timestamp, in our case *log_timestamp*. It has more `options <https://www.elastic.co/guide/en/logstash/current/plugins-filters-date.html>`_ than the two presented here. The basic usage is the following:

.. code-block:: ruby

   date {
     match => [ "log_timestamp", "MMM dd yyyy HH:mm:ss", "MMM d yyyy HH:mm:ss", "MMM dd HH:mm:ss", "MMM d HH:mm:ss" ]
     timezone => "America/Bogota"
   }

The *match* option tells the plugin to parse the field in the first string given in the array, *log_timestamp*. The following strings are the format in which the field to parse might have the timestamp. For example, "MMM dd yyyy HH:mm:ss", means that the timestamp might be in the format: Three letter month, MMM. A two digit day, dd. A four digit year, yyyy. A two digit hour, HH. A two digit minutes, mm. And a two digit seconds, ss. The rest of the options tells to the plugin that the timestamp might have those variants.

The *timezone* option tells the plugin to update the timezone in *@timestamp* for the given timezone. Elasticsearch uses UTC as timezone. It cannot be changed, that is, Elasticsearch uses it to work properly. Even though we cannot change it, we update the *@timestamp* with our real timezone because Kibana converts it underneath to your browser's timezone. So, it is important to have the same timezone in your browser and in your logs.

It is important to say that this plugin is **used only** in case that Grok parsed successfully the log.

8. The following filter plugin is used to remove unnecessary fields from the JSON that will be sent to Elasticsearch. This is how we can use it:

.. code-block:: ruby

   mutate {
      remove_field => ["fromsecure", "log_timestamp"]
   }

The *remove_field* option is given a list of fields that you want to remove. The *fromsecure* field is used in the *if* sentence above and is not needed anymore, I'll explain it later in :ref:`add-path-filebeat-7.x`. The *log_timestamp* is not needed anymore because we already have a field that contains the log timestamp, *@timestamp*.

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

Go to *Management* -> *Index Pattern* -> *Create index pattern*. Select its name, and as time filter field select *@timestamp*.

Plot your data
''''''''''''''
The easiest plot you can create is a frequency histogram. That's what I will explain, but there are a lot more features that Kibana `offers <https://www.elastic.co/guide/en/kibana/current/visualize.html>`_.

In Kibana go to *Visualize*, press the **+** button, select your type of visualization, in this case, *Vertical Bar*. Afther this, select the index pattern that corresponds to the *secure* logs. Now to create a frequency historgram of the users that failed logging in follow these steps:

1. In the left hand side of the Kibana web page you should see a subsection called *Buckets*. Click on *X-Axis*.
2. As aggregation select *Terms*. For more information about Term `aggregation <https://www.elastic.co/guide/en/elasticsearch/reference/7.2/search-aggregations-bucket-terms-aggregation.html>`_.
3. As field select *sshd_user*.
4. As custom label write: User name.
5. Now instead of *X-Axis* select *Add sub-buckes*. Then select *Split Series*.
6. Here as aggregation select *Terms* again.
7. As field select *sshd_event*.
8. Now type the following in the bar that is in the upper part of your browser (*Filters:*) -> sshd_event : "Failed". This is called *Kibana Query Language* and you can use it to filter your data and plot only what might be useful in the visualization. More information on this query language here, `Kibana Query Language <https://www.elastic.co/guide/en/kibana/7.2/kuery-query.html>`_.
9. Click on the *play* button in the left hand side of your browser.
10. Save your visualization with a descriptive name, something like: *[sshd] Failed attempts to log in*
11. Create a new *Dashboard* if you haven't created one yet, and add your visualization. You should see something like:

.. image:: images/visualization.png
  :alt: Kibana vertical bars visualization.
