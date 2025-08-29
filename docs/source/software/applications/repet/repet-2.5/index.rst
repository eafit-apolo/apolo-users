.. _repet-2.5-index:

.. role:: bash(code)
    :language: bash

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

The tar file containing REPET can be found `here`_. The compressed package already contains the binaries so there is no need to compile anything. Once you have uncompressed REPET and installed all the dependencies you should configure your environment so that every program needed is in your PATH. Also, you should configure the PYTHONPATH environment variable, so that every REPET python module is reachable.

.. _here: https://urgi.versailles.inra.fr/Tools/REPET

.. code-block:: bash

    $ export PYTHONPATH=$REPET_HOME

For more information on setting up your REPET environment, you should follow the guide provided at the beginning of the following web page: https://urgi.versailles.inra.fr/Tools/REPET/TEdenovo-tuto.

REPET needs a MySQL server, even though we chose MariaDB. Instructions to configure a MySQL server can be found on this `link`_. You also need to create a database and a user for REPET:

.. _link: https://dev.mysql.com/doc/refman/8.0/en/binary-installation.html

.. code-block:: mysql

    # tables engine must be MyISAM
    mysql> SET default_storage_engine=MYISAM;

    # in order to avoid errors regarding character encoding
    mysql> CREATE DATABASE database_name CHARACTER  set utf8 COLLATE  utf8_bin;

    # create user and grant privileges on database
    mysql> CREATE USER 'username'@'hostname' IDENTIFIED BY 'password';
    mysql> GRANT ALL ON database_name.* TO 'username'@'hostname';
    mysql> FLUSH PRIVILEGES;

Repet needs a working environment with some python modules installed:

.. code-block:: bash

   # load REPET module
   $ module load REPET

   # create a conda environment named env_name and install mysql-python, pyyaml as needed for REPET
   $ conda create -n env_name mysql-python pyyaml

.. note:: REPET module will load python/2.7.15_miniconda-4.5.4 automatically and will copy a RepeatMasker directory
           into your home which you will have to configure as follow.

If you want to use REPET with RepeatMasker:
    * The first time you run :bash:`module load REPET` you will have to move into RepeatMasker directory and run :bash:`perl ./configure`.

.. code-block:: bash

          $ cd $HOME/RepeatMasker
          $ perl ./configure

It will prompt you to enter the path for some applications. You should enter the following:

.. code-block:: bash

        # perl path
        Enter path: env

        # RepeatMasker path
        Enter path: /home/<your_username>/RepeatMasker

        # TRF path
        Enter path: /share/apps/REPET/2.5/third_party/others/bin/

        # RMblast path
        Enter path: /share/apps/REPET/2.5/third_party/rmblast/2.9.0/bin/

* Be aware that RepeatMasker comes by default with the open Dfam database. If you want to use RepBase library you should copy the compressed version to RepeatMasker's top directory and uncompress it from there. Then reconfigure RepeatMasker:

.. code-block:: bash

          $ module load REPET
          $ cp RepBaseRepeatMaskerEdition-XXXXXXXX.tar.gz $HOME/RepeatMasker/
          $ cd $HOME/RepeatMasker
          $ gunzip RepBaseRepeatMaskerEdition-XXXXXXXX.tar.gz
          $ tar xvf RepBaseRepeatMaskerEdition-XXXXXXXX.tar
          $ rm RepBaseRepeatMaskerEdition-XXXXXXXX.tar
          $ perl ./configure

* When you load REPET module the following script will be executed. It will loads the environment variables for every REPET dependency, and REPET itself. It also load the Python 2.7 module and GCC module.

.. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load REPET 2.5
        ##
        ## /share/apps/modules/REPET/2.5
        ## Written by Vincent Arcila
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using REPET\
                  \nin the shared directory /share/apps/REPET/2.5"
        }

        module-whatis "(Name________) REPET"
        module-whatis "(Version_____) 2.5"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Interpreter_____) Python 2.7"

        # for Tcl script use only
        set	    topdir	  /share/apps/REPET/2.5
        set         version       2.5
        set         sys           x86_64-redhat-linux
        set	    sourceDir	  /share/apps/REPET/2.5/third_party/RepeatMasker/1.332
        set	    targetDir     $::env(HOME)/RepeatMasker

        conflict glibc

        module load gcc/5.4.0
        module load python/2.7.15_miniconda-4.5.4

        if {! [file exist $targetDir]} {
            file mkdir $targetDir
            foreach f [glob -directory $sourceDir -nocomplain *] {
            file copy -force $f $targetDir
            }
        }

        puts stderr "NOTE: If this is the first time you load the module remember to move into
        RepeatMasker's directory \nand execute the configuration script for RepeatMasker:
        \n\n\t$ cd ::env(HOME)/RepeatMasker\n\t$ perl ./configure \n\nIf you want to configure
        RepBase follow the instructions provided in: http://apolo-docs.readthedocs.io"

        prepend-path    PATH			$targetDir
        prepend-path	PATH			$topdir/REPET/bin
        prepend-path	PATH			$topdir/third_party/RepeatMasker/1.332/
        prepend-path    PATH                    $topdir/third_party/others/bin
        prepend-path	PATH			$topdir/third_party/genometools/1.5.9/bin
        append-path	PATH			$topdir/third_party/blast/2.2.9/bin
        append-path	PATH			$topdir/third_party/rmblast/2.9.0/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib

        prepend-path    LD_LIBRARY_PATH         $topdir/third_party/genometools/1.5.9/lib
        prepend-path    LIBRARY_PATH            $topdir/third_party/genometools/1.5.9/lib
        prepend-path    LD_RUN_PATH             $topdir/third_party/genometools/1.5.9/lib

        prepend-path	PERL5LIB		$topdir/third_party/RepeatMasker/1.332
        prepend-path	PERL5LIB		$topdir/libexec

        prepend-path	INCLUDE_PATH		$topdir/include
        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLUDE_PATH	$topdir/include

        setenv		REPET_PATH		$topdir/REPET
        setenv		PYTHONPATH		$topdir/REPET

Usage
-----

.. note:: If you don't already have a MariaDB account contact the system administrator. Remember to ask for the database name and hostname for the MariaDB server.

In order to use REPET you should load REPET module and activate your Python environment:

.. code-block:: bash

    $ module load REPET

    $ source activate env_name

REPET's main pipelines are TEdenovo and TEannot. Each of them has it's specific guidelines and dependencies. REPET provides vast documentation for this pipelines: https://urgi.versailles.inra.fr/Tools/REPET/TEdenovo-tuto, https://urgi.versailles.inra.fr/Tools/REPET/TEannot-tuto.

REPET implements a module for using resource managers such as :ref:`SLURM <slurm-index>` or TORQUE. It will use this module to send jobs to a queue. In order to manage SBATCH parameters, you will have to edit the configuration file for the pipeline you are using (e.g. TEdenovo.cfg). Each job has its own parameters, which can be specified as follows:

.. code-block:: yaml

    resources: longjobs --partition=longjobs --time=03:00:00 --out=out.log --error=err.log

This entry will make TEdenovo.py use 'longjobs' as the partition. The job will have 3 hours to finish. The job will redirect stdout to out.log and stderr to err.log.

The first word must be the partition where you want your job to be sent. Even though, you should specify the partition again using :code:`--partition=<partition_name>`. It is mandatory to specify the partition as well as the time for the job to finish.

If for some reason some step did not finish as expected and you do not get an error message, you should erase all data on jobs table, so REPET can use :ref:`SLURM <slurm-index>` to launch jobs again:

.. code-block:: bash

        # connect to your MariaDB server
        $ mysql -u <MariaDB_username> -h <MariaDB_server_hostname> -p

        # select your database
        mysql> USE <your_database>;

        # erase all data in the table
        mysql> TRUNCATE TABLE jobs;

.. note:: If getting the following error: **ERROR 1130 (HY000): Host 'not.your.hostname.com' is not allowed to connect to this MariaDB server** you should try creating the user using the ip from which you will connect and then add "skip-name-resolve" to MariaDB configuration:

    .. code-block:: yaml

        [mariadb]
        skip-name-resolve

Also, be aware that almost all steps create a directory in which will be the output files from those specific steps. If your step failed, there will be the logs along with the files the step produced.

Examples
********

:ref:`SLURM <slurm-index>` scripts for REPET:

    * We provide the scripts and config files needed to run REPET on our cluster, you can download the examples:

        - :download:`TEannot-example <repet-examples/TEannot-example.zip>`

        - :download:`TEdenovo-example <repet-examples/TEdenovo-example.zip>`


    * You should modify some values accordingly (e.g. you project name or MariaDB username on .cfg files).
    * This scripts are based on https://github.com/stajichlab/REPET-slurm. More information on the usage for this scripts can be found there.

Recommended resources
----------------------------

#. A repository containing bash scripts to use REPET with SLURM: https://github.com/stajichlab/REPET-slurm.

#. A REPET practical course: https://biosphere.france-bioinformatique.fr/wikia2/index.php/REPET_practical_course#Start_TEdenovo_pipeline.

#. README from REPET: https://urgi.versailles.inra.fr/Tools/REPET/README.

#. A extensive guide for our resource manager: :ref:`SLURM <slurm-index>`.

Authors
--------

- Vincent Alejandro Arcila Larrea (vaarcilal@eafit.edu.co).
