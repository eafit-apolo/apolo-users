.. _LAPACK-3.5.0-index:

LAPACK 3.5.0
============

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** http://www.netlib.org/lapack/
- **License:** http://www.netlib.org/lapack/LICENSE.txt
- **Installed on:** Apolo II and Cronos
- **Installation date:** 14/04/2020

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * CMAKE (tested on V3.7.1)
    * GCC (tested on 5.4.0)



Installation
------------

#. Download the 3.5.0 version of LAPACK

   .. code-block:: bash

      $ wget http://www.netlib.org/lapack/lapack-3.5.0.tgz
      $ tar -xvf lapack-3.5.0.tgz
      $ cd lapack-3.5.0

#. After unpacking NetCDF, continue with the following steps for configuration and compilation:

   .. code-block:: bash

      $ mkdir build
      $ cd build
      $ cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/share/apps/lapack/3.5.0/gcc/5.4.0/
      $ make -j <N>
      $ make -j <N> install


Module
------


   .. code-block:: bash

      #%Module1.0#####################################################################
      ##
      ## modules lapack/3.5.0_gcc-5.4.0
      ##
      ## /share/apps/modules/lapack/3.5.0_gcc-5.4.0  Written by Tomás David Navarro y Juan Diego Ocampo
      ##

      proc ModulesHelp { } {
          puts stderr "\tLapack/3.5.0 - sets the Environment for LAPACK 3.5.0 in \
                       \n\tThe share directory /share/apps/lapack/3.5.0/gcc/5.4.0\n"
      }

      module-whatis "\n\n\tSets the environment for using LAPACK 3.5.0 (Linear \
                    \n\tAlgebra Library) builded with gcc 5.4.0\n"

      # for Tcl script use only
      set   topdir     /share/apps/lapack/3.5.0/gcc/5.4.0
      set   version    3.5.0
      set   sys        x86_64-redhat-linux

      module load gcc/5.4.0

      prepend-path 	LD_LIBRARY_PATH 	$topdir/lib
      prepend-path 	LIBRARY_PATH    	$topdir/lib
      prepend-path 	LD_RUN_PATH     	$topdir/lib
      setenv 	     	LAPACK 	     		$topdir/lib/liblapack.a




Use
---

    TO DO

Resources
---------

    * http://www.netlib.org/lapack/


:Author:

 * Tomas David Navarro Munera
