.. _repet-2.5-index:

REPET 2.5
=========

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** https://urgi.versailles.inra.fr/Tools/REPET
- **License:** CeCILL License 2.0
- **Tested on** CentOS (x86_64) ≥ 6.6 (Rocks 6.2)

Installation
------------

   .. note:: Official installation instructions can be found in https://urgi.versailles.inra.fr/Tools/REPET/INSTALL.

A detailed list of dependencies can be found at https://urgi.versailles.inra.fr/Tools/REPET/INSTALL#dependencies. Notice that every executable that is needed by REPET should be reachable from your PATH. Be aware that the cause of most of the errors when running REPET is due to the malfunction of a dependency.

The tar file containing REPET can be found `here`_. The compressed package already contains the binaries so there is no need to compile anything. Once you have uncompressed REPET and installed all the dependencies you should configure your environment so that every program is in your PATH. Also, you should configure PYTHONPATH evironment variable, so that every REPET python module is reachable.

.. _here: https://urgi.versailles.inra.fr/Tools/REPET

.. code-block:: bash

    $ export PYTHONPATH=$REPET_HOME

For more information on setting up your REPET environment you should follow the guide provided in the beginning of the following web page: https://urgi.versailles.inra.fr/Tools/REPET/TEdenovo-tuto.

REPET needs a MySQL server. Instructions to configure a MySQL server can be found on this `link`_. You also need to create a database and a user for REPET:

.. _link: https://dev.mysql.com/doc/refman/8.0/en/binary-installation.html

.. code-block:: mysql

    # tables engine must be MyISAM
    mysql> SET storage_engine=MYISAM;    
    mysql> SET table_type=BDB;

    # in order to avoid errors regarding character encoding
    mysql> CREATE DATABASE database_name CHARACTER  set utf8 COLLATE  utf8_bin;

    # check if tables engine is MyISAM
    mysql> USE database_name;
    mysql> SHOW TABLE status;

    # create user and grant privileges on database
    mysql> CREATE USER 'username'@'hostname' IDENTIFIED BY 'password';
    mysql> GRANT ALL ON database_name.* TO 'username'@'hostname';
    mysql> FLUSH PRIVILEGES;

Repet needs a working environment with some python modules installed:

.. code-block:: bash   

   # load conda module for Python 2.7
   $ module load python/2.7.15_miniconda-4.5.4

   # create a conda environment named env_name and install mysql-python, pyyaml as needed for REPET
   $ conda create mysql-python pyyaml -n env_name


Usage
-----

In order to use REPET you should load REPET module and your Python 2 environment:

.. code-block:: bash
    
    $ module load REPET/2.5
    $ module load gcc/5.4.0
    $ module load python/2.7.15_miniconda-4.5.4
    $ source activate env_name

   .. note:: It is vital for some dependencies that you load gcc/5.4.0, which provides some required libraries.

REPET's main pipelines are TEdenovo and TEannot. Each of them has it's specific guidelines and dependencies. REPET provides vast documentation for this pipelines: https://urgi.versailles.inra.fr/Tools/REPET/TEdenovo-tuto, https://urgi.versailles.inra.fr/Tools/REPET/TEannot-tuto.

REPET implements a module for using resource managers such as :ref:` or TORQUE. REPET will use this module to send jobs to a queue. In order to manage

Authors
-------

- Vincent Alejandro Arcila Larrea (vaarcilal@eafit.edu.co).
