.. _trinity-2.4.0-index:

.. contents:: Table of Contents

***************
Trinity 2.4.0
***************

- **Installation date:** 01/03/2017
- **URL:** https://github.com/trinityrnaseq/trinityrnaseq/wiki
- **Apolo version:** Apolo II
- **License:** Copyright (c) 2014, trinityrnaseq


Dependencies
-------------

- GNU Gcc >= 4.9.4
- Intel Parallel Studio XE Cluster Edition 2017 Update 1
- bowtie2 >= 2.3.0
- ncbi-blast+ >= 2.6.0
- R and edgeRsource("https://bioconductor.org/biocLite.R")
- r >= 3.3.
    - edgeR
    - DESeq2
    - ROTS
    - qvalue
    - goseq

Installation
------------

After solving the aforementioned dependencies, you can proceed with the installation of Trinity.

1. Download the binaries

.. code-block:: bash

    wget https://github.com/trinityrnaseq/trinityrnaseq/archive/Trinity-v2.4.0.tar.gz
    tar xf Trinity-v2.4.0.tar.gz

2. Compilation (makefile)

.. code-block:: bash

    cd trinityrnaseq-Trinity-v2.4.0/
    module load intel/2017_update-1
    #change -openmp for -fopenmp in the following scripts
    emacs Chrysalis/Makefile_icpc
    emacs Inchworm/configure
    emacs trinity-plugins/parafly-code/configure
    emacs trinity-plugins/parafly-code/configure.ac
    make TRINITY_COMPILER=intel 2>&1 | tee trinity-make.log
    make TRINITY_COMPILER=intel plugins 2>&1 | tee trinity-make-plugins.log

3. Test the installation

.. code-block:: bash

    module load ncbi-blast/2.6.0_x86_64
    module load bowtie2/2.3.0_intel-2017_update-1
    cd sample_data/test_Trinity_Assembly/
    ./runMe.sh

Module
-------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module trinity/2.4.0_intel-2017_update-1
    ##
    ## /share/apps/modules/trinity/2.4.0_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\ttrinity/2.4.0_intel-2017_update-1 - sets the Environment for Trinity in \
        \n\tthe share directory /share/apps/trinity/2.4.0/intel/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using Trinity 2.4.0 \
                   \n\tbuilded with Intel Parallel Studio XE 2017\n"

    # for Tcl script use only
    set       topdir     /share/apps/trinity/2.4.0/intel/2017_update-1
    set       version    2.4.0
    set       sys        x86_64-redhat-linux

    conflict trinity
    module load gcc/4.9.4
    module load bowtie2/2.3.0_intel-2017_update-1
    module load ncbi-blast/2.6.0_x86_64
    module load r/3.3.2_intel_mkl_2017_update-1

    prepend-path PATH    $topdir


Usage mode
-----------

.. code-block:: bash

    module load trinity/2.4.0_intel-2017_update-1


References
----------

- https://github.com/trinityrnaseq/trinityrnaseq/wiki/Installing%20Trinity

Author
------

- Mateo Gómez Zuluaga
