.. _bwa-0.7.15:

BWA 0.7.15
===========

.. contents:: Table of contents

Basic information
--------------------

- **Installation date:** 27/02/2017
- **URL:** http://bio-bwa.sourceforge.net/
- **Apolo version:** Apolo II
- **License:** GPL

Dependencies
------------

- Intel Parallel Studio XE Cluster Edition 2017 Update 1

Installation
------------

After solving the previously mentioned dependencies, you can proceed with the installation of **BWA.**

1. Download the latest version of the software (Source code - bz2) (https://sourceforge.net/projects/bio-bwa/files/):

.. code-block:: bash

    cd /home/$USER/apps/bwa/src
    wget https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.15.tar.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fbio-bwa%2Ffiles%2F&ts=1488235843&use_mirror=ufpr
    tar xf bwa-0.7.15.tar.bz2

2. Compilation (Makefile), do the following steps:

.. code-block:: bash

    cd bwa-0.7.15
    module load intel/2017_update-1
    emacs Makefile
    ...
    CC=                     icc
    ...
    make 2>&1 | tee bwa-make.log

3. After compiling **BWA**, we continue with the following steps:

.. code-block:: bash

    sudo mkdir -p /share/apps/bwa/0.7.15/intel/2017_update-1/bin
    sudo cp bwa /share/apps/bwa/0.7.15/intel/2017_update-1/bin

Module
------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module bwa/0.7.15_intel-2017_update-1
    ##
    ## /share/apps/modules/bwa/0.7.15_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tbwa/0.7.15_intel-2017_update-1 - sets the Environment for Bwa in \
        \n\tthe share directory /share/apps/bwa/0.7.15/intel/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using Bwa 0.7.15 \
                   \n\tbuilded with Intel Parallel Studio XE 2017\n"

    # for Tcl script use only
    set       topdir     /share/apps/bwa/0.7.15/intel/2017_update-1
    set       version    0.7.15
    set       sys        x86_64-redhat-linux

    module load intel/2017_update-1

    prepend-path PATH    $topdir/bin



Usage mode
-----------

Load the necessary environment through the **module:**

.. code-block:: bash

    module load bwa/0.7.15_intel-2017_update-1

TO-DO

References
----------

- Makefile (inside bz2)

Author
------

- Mateo Gómez Zuluaga
