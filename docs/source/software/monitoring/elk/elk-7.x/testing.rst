.. _testing-index:

.. role:: yaml(code)
   :language: yaml

.. role:: bash(code)
   :language: bash

.. role:: ruby(code)
   :language: ruby

.. _testing-7.x-label:

Testing
-------

Testing of the whole ELK Stack can be easily done using `Vagrant <https://www.vagrantup.com/intro/index.html>`_.

.. note:: Recall that when having a relatively large amount of logs, Elasticsearch and Logstash use about 4-6GB RAM (or even more) when filtering and indexing data.

#. The vagrantfile looks like this:

   .. literalinclude:: src/Vagrantfile
      :language: ruby


   For the purpose of this guide use the Ansible project HERE. This project is explained in :ref:`installation-7.x-label`. Although, in case of setting up another configuration, read this explanation of the Vagrantfile above.

      * In the configuration of each virtual machine, there is a subsection for provisioning. In that subsection, there is a variable that is accessed as :bash:`ansible.playbook`. Set it to the path of the main ansible playbook.
      * Take a look at the provisioning subsection in the vagrantfile, note that the :bash:`ansible.extra_vars` defines a variable called :bash:`machine`, this variable must match the hostname of the virtual machine.
      * The hostname of the virtual machine can be changed with the variable :bash:`vm.hostname`. For more information, read the Vagrant documentation about `vagrantfiles <https://www.vagrantup.com/docs/vagrantfile/>`_.
      * Before starting the virtual cluster please see the directory structure that should be matched in order to run the tests :download:`here <config/ansible_dir_structure.txt>`.

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

   The roles *elk* and *master* are responsible for setting up ELK and Filebeat respectively. Go to :ref:`installation-7.x-label`, for a more detailed explanation.

#. To start up the virtual cluster use the following bash script with the argument :bash:`up`:

   .. literalinclude:: src/scripts/run.sh
      :language: bash

   .. note:: Change elk, cr0n05, 4p0l0, to the virtual machine names that were set up in the Vagrantfile. Do not change them if using the Vagrantfile above.

   Make the virtual machines visible between them by their hostname. Enter each virtual machine. Change the :bash:`/etc/hosts` file and add the ip address of the virtual machine that want to see followed by its hostname. For example, make elk visible by others and in the *elk* machine. CHANGE THIS ADD A TASK TO DO THIS.

   .. code-block:: bash

      # file /etc/hosts
      0.0.0.0         elk      # allow others to use the elk hostname instead of the ip
      192.168.1.2     cr0n05   # make cr0n05 visible to elk by its hostname not just its ip
      192.168.1.3     4p0l0

#. After making them visible, provision :bash:`elk`, run:

   .. code-block:: bash

      $ scripts/run.sh provision-elk

   After correctly provisioning :bash:`elk`, set up the *indexes, mappingsDashboards* in :ref:`kibana-7.x-label`.

.. note::
   Before provisioning filebeat it is very important to set up the *indexes and mappings* in Kibana.

#. After setting up:

   .. code-block:: bash

      $ scripts/run.sh provision-filebeat

#. Now if everything went ok, it can be added logging sources, create visualizations and dashboards, etc. To stop the cluster run:

   .. code-block:: bash

      $ scripts/run.sh halt
