.. _vagrant-index:

VAGRANT
=========

- The main purpose of this article is documenting how to face a problem with the machine storage, but we will see briefly how to download it.

.. contents:: Table of Contents

Basic information
-----------------

- **Official documentation:** https://www.vagrantup.com/

Tested on (Requirements)
------------------------

- **Base OS:** Fedora 31
- **OS for the virtual machine:** CentOS 8

Installation and implementation
--------------------------------

- Search the name of the vagrant package in your packet manager and install it, then make some directory to locate
    the machines we will create

    .. code-block:: bash

        $ sudo yum install vagrant #install vagrant
        $ mkdir Desktop/vagrant #create the directory
        $ cd Desktop/vagrant
        $ vagrant init #for creating the vagrant file

- At this point yo will see a vagrantfile that you can edit. Set your box with the os that you prefer, the host for the
    machine, configure the nets and the box provider. When the file is complete, save it and run the following commands:

    .. code-block:: bash

        $ vagrant up #you will have to wait, is a long process
        $ vagrant ssh

- I faced some problem with my CentOS 8 machine, it had only 10G of space and 30G of free space, so I did the following:

    .. code-block:: bash

        $ sudo cfdisk #change the space, and write to the disk
        $ sudo xfs_growfs -d / #for making the changes
        $ df -h #for checking if it worked

References
----------

-   Vagrant documentation.
    retrieved from https://www.vagrantup.com/intro/getting-started/boxes.html

-   Vagrant documentation.
    retrieved from https://www.vagrantup.com/intro/getting-started/up.html

Author
--------

Manuela Herrera-López



