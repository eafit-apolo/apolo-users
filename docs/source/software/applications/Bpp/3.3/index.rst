.. _bpp-3.3.0-index:


BP&P 3.3.0
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://abacus.gene.ucl.ac.uk/software/
- **License:** GNU GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II and Cronos
- **Installation date:** 07/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Parallel Studio XE 2017 Update 1 (Intel C Compiler)



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/bpp/intel
        wget http://abacus.gene.ucl.ac.uk/software/bpp3.3.tgz
        tar -zxvf bpp3.3.tgz



#. Manual compilation procedure.

    .. code-block:: bash

        cd bpp3.3/src
        module load intel/2017_update-1
        echo manual compilation
        icc -o bpp -fast bpp.c tools.c -lm
        icc -o bpp_sse -fast -DUSE_SSE -msse3 bpp.c tools.c -lm
        icc -o bpp_avx -fast -DUSE_AVX -mavx bpp.c tools.c -lm
        icc -o MCcoal -DSIMULATION -fast bpp.c tools.c -lm


#. After compiling BP&P, continue with the following steps:

    .. code-block:: bash

        sudo mkdir -p /share/apps/bpp/3.3/intel/2017_update-1/bin
        sudo cp bpp bpp_sse bpp_avx MCcoal /share/apps/bpp/3.3/intel/2017_update-1/bin




Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module bpp/3.3_intel-2017_update-1
        ##
        ## /share/apps/modules/bpp/3.3_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tbpp/3.3_intel-2017_update-1 - sets the Environment for Bpp in \
            \n\tthe share directory /share/apps/bpp/3.3/intel/2017_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using Bpp 3.3 \
                    \n\tbuilded with Intel Parallel Studio XE 2017\n"

        # for Tcl script use only
        set       topdir     /share/apps/bpp/3.3/intel/2017_update-1
        set       version    3.3
        set       sys        x86_64-redhat-linux

        module load intel/2017_update-1

        prepend-path PATH    $topdir/bin



Usage mode
------------

    .. code-block:: bash

       module load bpp/3.3_intel-2017_update-1



Resources
---------
 * http://abacus.gene.ucl.ac.uk/software/


Author
------
    * Mateo Gómez Zuluaga
