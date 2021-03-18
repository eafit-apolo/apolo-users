.. _bpp-4.3.8-index:


BP&P 4.3.8
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/bpp/bpp/
- **License:** GNU GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II and Cronos
- **Installation date:** 07/02/2021

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Parallel Studio XE 2019 (Intel C Compiler)



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/tdnavarrom/apps/bpp/intel
        wget https://github.com/bpp/bpp/releases/download/v4.3.8/bpp-4.3.8-linux-x86_64.tar.gz
        tar zxf v4.3.8.tar.gz




#. Manual compilation procedure.

    .. code-block:: bash

        cd bpp-4.3.8/src/
        module load intel/19.0.4
        make


#. After compiling BP&P, continue with the following steps:

    .. code-block:: bash

        sudo mkdir /share/apps/bpp/4.3.8/intel/19.0.4/bin -p
        sudo cp src/bpp /share/apps/bpp/4.3.8/intel/19.0.4/bin/





Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module bpp/4.3.8_intel-19.0.4
        ##
        ## /share/apps/modules/bpp/4.3.8_intel-19.0.4     Written by Tomas Navarro
        ##

        proc ModulesHelp { } {
            puts stderr "\tbpp/4.3.8_intel-19.0.4 - sets the Environment for Bpp in \
            \n\tthe share directory /share/apps/bpp/4.3.8/intel/19.0.4\n"
        }

        module-whatis "\n\n\tSets the environment for using Bpp 4.3.8 \
                    \n\tbuilded with Intel Parallel Studio XE 2019\n"

        # for Tcl script use only
        set       topdir     /share/apps/bpp/4.3.8/intel/19.0.4
        set       version    4.3.8
        set       sys        x86_64-redhat-linux

        module load intel/19.0.4

        prepend-path PATH    $topdir/bin




Usage mode
------------

    .. code-block:: bash

       module load bpp/3.3_intel-2017_update-1



Resources
---------
 * https://github.com/bpp/bpp/


:Authors:

- Tomas Navarro <tdnavarrom@eafit.edu.co>
