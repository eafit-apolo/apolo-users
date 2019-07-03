.. _elk-7.x-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

.. role:: ruby(code)
   :language: ruby

ELK Stack 7.x
^^^^^^^^^^^^^

.. toctree::
  
   installation-configuration
   testing
   adding-logging-source

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

Authors
-------

- Hamilton Tobon Mosquera <htobonm@eafit.edu.co>
