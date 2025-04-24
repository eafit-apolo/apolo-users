.. _bowtie2-2.3.0-index:


bowtie2 2.3.0
=============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://bowtie-bio.sourceforge.net/bowtie2/index.shtml
- **License:** GNU GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II and Cronos
- **Installation date:** 27/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Parallel Studio XE Cluster Edition 2017 Update 1



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/bowtie2/
        wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.0/bowtie2-2.3.0-source.zip/download
        unzip bowtie2-2.3.0-source.zip


#. Do the following changes in the Makefile

    .. code-block:: bash

        cd bowtie2-2.3.0
        module load intel/2017_update-1
        emacs Makefile
        ...
        prefix = /share/apps/bowtie2/2.3.0/intel/2017_update-1
        bindir = $(prefix)/bin

        INC =
        GCC_PREFIX = $(shell dirname `which icc`)
        GCC_SUFFIX =
        CC ?= $(GCC_PREFIX)/icc$(GCC_SUFFIX)
        CPP ?= $(GCC_PREFIX)/icpc$(GCC_SUFFIX)
        CXX ?= $(CPP)
        HEADERS = $(wildcard *.h)
        BOWTIE_MM = 1
        BOWTIE_SHARED_MEM = 0
        ...
        make 2>&1 | tee bowtie2-make.log

#. After compiling bowtie2, continue with the following steps:

    .. code-block:: bash

        sudo mkdir -p /share/apps/bowtie2/2.3.0/intel/2017_update-1
        sudo chown -R mgomezzul.apolo /share/apps/bowtie2/2.3.0/intel/2017_update-1
        make install 2>&1 | tee bowtie2-make-install.log
        sudo chown -R root.root /share/apps/bowtie2/2.3.0/intel/2017_update-1



Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module bowtie2/2.3.0_intel-2017_update-1
        ##
        ## /share/apps/modules/bowtie2/2.3.0_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tbowtie2/2.3.0_intel-2017_update-1 - sets the Environment for Bowtie2 in \
            \n\tthe share directory /share/apps/bowtie2/2.3.0/intel/2017_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using Bowtie2 2.3.0 \
                    \n\tbuilded with Intel Parallel Studio XE 2017\n"

        # for Tcl script use only
        set       topdir     /share/apps/bowtie2/2.3.0/intel/2017_update-1
        set       version    2.3.0
        set       sys        x86_64-redhat-linux

        module load intel/2017_update-1

        prepend-path PATH    $topdir/bin



Usage mode
-------------

    .. code-block:: bash

       module load bowtie2/2.3.0_intel-2017_update-1



Resources
---------
 * http://bowtie-bio.sourceforge.net/bowtie2/index.shtml


Author
------
    * Mateo Gómez Zuluaga
