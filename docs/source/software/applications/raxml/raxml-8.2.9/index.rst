.. _rax9:

.. contents:: Table of Contents

***********
RAxML 8.2.9
***********

- **Installation date:** 07/02/2017
- **URL:** http://sco.h-its.org/exelixis/web/software/raxml/
- **Apolo version:** Apolo II
- **License:** GNU GENERAL PUBLIC LICENSE Version 3

Dependencies
-------------

-Intel Parallel Studio XE 2017 Update 1 (Intel C Compiler and Intel MPI)

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    wget https://github.com/stamatak/standard-RAxML/archive/v8.2.9.tar.gz
    tar -zxvf v8.2.9.tar.gz


#. compilation config and editing the makefile

.. code-block:: bash

    cd standard-RAxML-8.2.9
    module load impi/2017_update-1
    cp Makefile.AVX2.HYBRID.gcc Makefile.AVX2.HYBRID.icc
    emacs Makefile.AVX2.HYBRID.icc (Cambiar CC = mpicc por CC = mpiicc)
    make -f Makefile.AVX2.HYBRID.icc 2>&1 | tee raxml-make.log

Module
---------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module raxml/8.2.9_intel_impi-2017_update-1
    ##
    ## /share/apps/modules/raxml/8.2.9_intel_impi-2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\traxml/8.2.9_intel-2017_update-1 - sets the Environment for Raxml in \
        \n\tthe share directory /share/apps/raxml/8.2.9/intel_impi/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using Raxml 8.2.9 \
                   \n\tbuilded with Intel Parallel Studio XE 2017\n"

    # for Tcl script use only
    set       topdir     /share/apps/raxml/8.2.9/intel_impi/2017_update-1
    set       version    8.2.9
    set       sys        x86_64-redhat-linux

    module load impi/2017_update-1

    prepend-path PATH    $topdir/bin

Usage mode
----------------

.. code-block:: bash

    module load raxml/8.2.9_intel_impi-2017_update-1

References
------------

- manual
- http://sco.h-its.org/exelixis/web/software/raxml/cluster.html
- http://sco.h-its.org/exelixis/resource/doc/Phylo100225.pdf

Author
------

- Mateo Gómez Zuluaga
