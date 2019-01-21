.. _vagrant-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

Vagrant
=======

Basic information
-----------------
- **Official website:** https://www.vagrantup.com/
- **Version:** 2.0.2
- **License:** MIT License


Usage
-----
Vagrant commands usually have the following the structure: :bash:`vagrant --machine=<single> -- command [<args>]`

.. note::
   Be careful with the spaces between the double line and the command.
   
#. Use the :bash:`up` command alongside the :bash:`--provision` argument to import the VM into VirtualBox and run ansible.

   .. code-block:: bash

      vagrant --machine=<single> -- up --provision

#. Check if ansible ran successfully. If it didn't, find the error and patch it.

#. Test your patch by syncing the changes and re-provision.

   .. code-block:: bash

      vagrant --machine=<single> -- rsync
      vagrant --machine=<single> -- provision
      
**Useful commands**

- **ssh:** Connects to machine via SSH.                          
  :bash:`vagrant --machine=<single> -- ssh`
- **reload:** Restarts vagrant machine, loads new Vagrantfile configuration.
  :bash:`vagrant --machine=<single> -- reload`
- **halt:** Stops the vagrant machine.                            
  :bash:`vagrant --machine=<single> -- halt`
- **destroy:** Stops and deletes all traces of the vagrant machine.
  :bash:`vagrant --machine=<single> -- destroy`

For more help run :bash:`vagrant -h` or :bash:`vagrant <command> -h` for help on any individual command.

Vagrantfile
^^^^^^^^^^^
The primary function of the Vagrantfile is to describe the type of machine required for a project, and how to configure and provision these machines [1]_ . The syntax of Vagrantfile is Ruby.

.. literalinclude:: src/vagrantfile
   :language: ruby
   :caption: :download:`vagrantfile <src/vagrantfile>`

.. note::

   For more information about vagrantfile and how to create it go to https://www.vagrantup.com/docs/vagrantfile/

Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
- Tomás Felipe Llano Rios <tllanos@eafit.edu.co>

References
----------
.. [1] Vagrantfile. (n.d.). Retrieved January 21, 2019, from https://www.vagrantup.com/docs/vagrantfile/
