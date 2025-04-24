.. _topHat-2.1.1-index:

.. role:: bash(code)
   :language: bash

TopHat 2.1.1
============

.. contents:: Table of Contents

Basic information
-----------------
- **Installation Date:** 07/11/2018
- **URL:** http://ccb.jhu.edu/software/tophat/index.shtml
- **License:** Boost Software License, Version 1.0
- **Installed on:** Apolo II & Cronos

Tested on (Requirements)
------------------------

* **Dependencies to run TopHat:**
    - Bowtie2
    - Intel compiler (C y C++)

Installation
------------

After solving the previously mentioned dependencies, you can proceed with the installation.

#. Download the latest version of the software (Source code - tar.gz) (ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz):

    .. code-block:: bash

        tar -zxvf tophat-2.1.1.Linux_x86_64.tar.gz
        sudo mkdir -p /share/apps/tophat/2.1.1/gcc-4.4.7/bin
        cp tophat-2.1.1.Linux_x86_64/* /share/apps/tophat/2.1.1/gcc-4.4.7/bin

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load tophat/2.1.1_gcc-4.4.7
        ##
        ## /share/apps/modules/tophat/2.1.1_gcc-4.4.7
        ## Written by Juan Pablo Alcaraz Florez
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using tophat 2.1.1\
                        \nin the shared directory \
                        \n/share/apps/tophat/2.1.1/gcc-4.4.7/\
                        \nbuilded with gcc-4.4.7"
        }

        module-whatis "(Name________) tophat"
        module-whatis "(Version_____) 2.1.1"
        module-whatis "(Compilers___) gcc-4.4.7"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) bowtie2"

        # for Tcl script use only
        set         topdir        /share/apps/tophat/2.1.1/gcc-4.4.7/
        set         version       2.1.1
        set         sys           x86_64-redhat-linux

        conflict tophat
        module load bowtie2/2.3.4.1_intel-18.0.2

        prepend-path PATH    $topdir/bin

References
----------

- Manual dentro del paquete del software

Authors
-------

- Juan Pablo Alcaraz Flórez
