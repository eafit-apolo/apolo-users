.. _openblas-0.2.19-index:


OpenBLAS 0.2.19
===============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.openblas.net/
- **License:**  3-clause BSD license
- **Installed on:** Apolo II and Cronos
- **Installation date:** 21/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GNU GCC >= 5.4.0



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/openblas/src
        wget http://github.com/xianyi/OpenBLAS/archive/v0.2.19.tar.gz
        tar -zxvf v0.2.19.tar.gz


#. After unpacking OpenBLAS, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd OpenBLAS-0.2.19/
        echo add LAPACK support
        wget http://www.netlib.org/lapack/lapack-3.7.0.tgz
        sudo mkdir -p /share/apps/openblas/0.2.19/gcc/5.4.0
        sudo chown -R mgomezzul.apolo /share/apps/openblas/0.2.19/gcc/5.4.0
        module load gcc/5.4.0
        make
        make PREFIX=/share/apps/openblas/0.2.19/gcc/5.4.0 install



Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## modules openblas/0.2.19_gcc-5.4.0
        ##
        ## /share/apps/modules/openblas/0.2.19_gcc-5.4.0  Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\topenblas-0.2.19_gcc-5.4.0 - sets the Environment for OpenBLAS 0.2.19 in \
                        \n\tthe shared directory /share/apps/openblas/0.2.19/gcc-5.4.0 \n"
        }

        module-whatis "\n\n\tSets the environment for using OpenBLAS 0.2.19 \
                    \n\tbuilded with \
                    \n\tand gcc 5.4.0 version\n"

        # for Tcl script use only
        set   topdir	  /share/apps/openblas/0.2.19/gcc/5.4.0
        set   version	  0.2.19
        set   sys	  x86_64-redhat-linux


        module load gcc/5.4.0

        prepend-path LD_LIBRARY_PATH	$topdir/lib
        prepend-path LIBRARY_PATH	$topdir/lib
        prepend-path LD_RUN_PATH	$topdir/lib

        prepend-path C_INCLUDE_PATH     $topdir/include
        prepend-path CXX_INCLUDE_PATH   $topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include



Use
---

    .. code-block:: bash

        module load openblas/0.2.19_gcc-5.4.0



Resources
---------
 * https://www.openblas.net/


Author
------
   * Mateo Gómez Zuluaga
