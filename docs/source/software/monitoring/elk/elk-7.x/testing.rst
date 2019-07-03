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
