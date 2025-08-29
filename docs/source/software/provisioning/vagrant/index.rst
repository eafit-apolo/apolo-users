.. _vagrant-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

Vagrant
=======

Basic information
-----------------
- **Official website:** https://www.vagrantup.com/
- **Version:** 2.2.3
- **License:** MIT License

Installation
------------
You can find the Vagrant's latest version in the link https://www.vagrantup.com/
downloads.html . Also, you can install it with your package manager (check the
version before install it).

Usage
-----

Vagrant commands usually have the following structure: :bash:`vagrant command
[<args>]` but in this particular case, we have custom options that help with our
ansible configuration so the structure changes to: :bash:`vagrant
--custom-option=option -- command [<args>]`

.. note::
   * Be careful with the spaces between the double minus and the command.
   * If you use a diferent configuration for vagrant remember to delete the
     custom option :bash:`--custom-option=option --` to use the vagrant's usual
     commands

#. Use the :bash:`up` command alongside the :bash:`--provision` argument to
   import the VM into VirtualBox and run ansible.

   .. code-block:: bash

      vagrant --machine=<single> -- up --provision

#. Check if ansible ran successfully. If it didn't, find the error and patch it.

#. Test your patch by syncing the changes and re-provision.

   .. code-block:: bash

      vagrant --machine=<single> -- rsync
      vagrant --machine=<single> -- provision

.. note::
   Our Vagrant's custom options are:

   - machine: Machine hostname for ansible and the playbooks's name.
   - vault-id: The password file for ansible.

**Useful commands**

- **ssh:** Connects to machine via SSH.
  :bash:`vagrant ssh`
- **reload:** Restarts vagrant machine, loads new Vagrantfile configuration.
  :bash:`vagrant reload`
- **halt:** Stops the vagrant machine.
  :bash:`vagrant halt`
- **destroy:** Stops and deletes all traces of the vagrant machine.
  :bash:`vagrant destroy`

For more help run :bash:`vagrant -h` or :bash:`vagrant <command> -h` for help on
any individual command.

Vagrantfile
^^^^^^^^^^^
The primary function of the Vagrantfile is to describe the type of machine
required for a project, and how to configure and provision these machines [1]_ .
The syntax of Vagrantfile is Ruby.

This vagrantfile is based on a vagranfile with custom variables to ease the use
of ansible_local handling and other options.

.. literalinclude:: src/vagrantfile
   :language: ruby
   :caption: :download:`vagrantfile <src/vagrantfile>`

.. note::

   For more information about vagrantfile and how to create it go to
   https://www.vagrantup.com/docs/vagrantfile/

Troublehooting
^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 1

   vagrant-storage/index

:Author:

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
- Tomás Felipe Llano Rios <tllanos@eafit.edu.co>

References
----------
.. [1] Vagrantfile. (n.d.). Retrieved January 21, 2019, from
       https://www.vagrantup.com/docs/vagrantfile/
