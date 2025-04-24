.. _testing-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

.. role:: ruby(code)
   :language: ruby

.. _testing-7.x-label:

#######
Testing
#######

Testing of the whole ELK Stack can be easily done using `Vagrant <https://www.vagrantup.com/intro/index.html>`_.

.. note:: Recall that when having a relatively large amount of logs, Elasticsearch and Logstash use about 4-6GB RAM (or even more) when filtering and indexing data.

#. The vagrantfile looks like this:

   .. literalinclude:: src/test/Vagrantfile
      :language: ruby


   For the purpose of this guide use the Ansible project :download:`here <src/test/elk_ansible_test_project.zip>`. This project is explained in :ref:`installation-7.x-label`. Although, in case of setting up another configuration, read the explanation below of the Vagrantfile above so that it can be replicated.

      * In the configuration of each virtual machine, there is a subsection for provisioning. In that subsection, there is a variable that is accessed as :bash:`ansible.playbook`. Set it to the path of the main ansible playbook.
      * Take a look at the provisioning subsection in the vagrantfile, note that the :bash:`ansible.extra_vars` defines a variable called :bash:`machine`, this variable must match the hostname of the virtual machine.
      * The hostname of the virtual machine can be changed with the variable :bash:`vm.hostname`. For more information, read the Vagrant documentation about `vagrantfiles <https://www.vagrantup.com/docs/vagrantfile/>`_.
      * The variables :bash:`elk_ip` and :bash:`elk_hostname` under the configuration of :bash:`4p0l0` and :bash:`cr0n05`, are used to make :bash:`elk` visible by its hostname automatically.

   The :bash:`site.yml` uses one playbook or another depending on the value of the variable :bash:`machine`:

   .. literalinclude:: src/site.yml
      :language: yaml

   The :bash:`playbooks/4p0l0.yml`, :bash:`playbooks/cr0n05.yml`, and :bash:`playbooks/elk.yml` playbooks are simple too:

   .. literalinclude:: src/playbooks/4p0l0.yml
      :language: yaml

   .. literalinclude:: src/playbooks/cr0n05.yml
      :language: yaml

   .. literalinclude:: src/playbooks/elk.yml
      :language: yaml

   The roles :bash:`elk` and :bash:`master` are responsible for setting up ELK and Filebeat respectively. Go to :ref:`installation-7.x-label`, for a more detailed explanation.

      * Before starting the virtual cluster please see the directory structure that should be matched in order to run the tests :download:`here <config/ansible_dir_structure.txt>`.

#. To start up the virtual cluster use the following bash script:

   .. literalinclude:: src/scripts/run.sh
      :language: bash

   From the root of the project run:

   .. code-block:: bash

      $ ./scripts/run.sh up

#. Now provision :bash:`elk`, run:

   .. code-block:: bash

      $ ./scripts/run.sh provision-elk

   After correctly provisioning :bash:`elk`, set up the :ref:`kibana-7.x-mappings-label` in Kibana.

   .. warning::
      Before provisioning filebeat it is very important to set up the *indexes and mappings* in Kibana.

#. After setting up Kibana run:

   .. code-block:: bash

      $ ./scripts/run.sh provision-filebeat

#. If everything is ok, new logging sources can be addded, as well as, create visualizations and dashboards, etc.

#. To stop the cluster run:

   .. code-block:: bash

      $ ./scripts/run.sh halt
