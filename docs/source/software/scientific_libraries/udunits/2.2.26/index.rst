.. _udunits-2.2.26-index:

udunits 2.2.26
==============

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** https://www.unidata.ucar.edu/software/udunits/
- **License:**
- **Installed on:** Apolo II
- **Installation date:** 10/06/2020

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GCC (tested on 5.4.0)
    * CUnit (tested on 2.1-3)



Installation
------------

#. Download the 2.2.26 version of udunits

   .. code-block:: bash

      $ wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.26.tar.gz
      $ tar -xvf udunits-2.2.26.tar.gz
      $ cd udunits-2.2.26

#. After unpacking udunits, continue with the following steps for configuration and compilation:

   .. code-block:: bash

      $ module load gcc/5.4.0
      $ module load cunit/2.1-3_gcc-5.4.0
      $ ./configure --prefix=/share/apps/cunit/2.2.26/gcc-5.4.0/
      $ make
      $ make check # optional, needs CUnit library
      $ make install
      $ make install-html install-pdf # optional
      $ make clean



Module
------


   .. code-block:: bash

      #%Module1.0####################################################################
      ##
      ## module load udunits/2.2.26_gcc-5.4.0
      ##
      ## /share/apps/modules/udunits/2.2.26_gcc-5.4.0
      ## Written by Laura Sanchez Córdoba
      ## Date: June 10, 2020
      ##

      proc ModulesHelp {} {
          global version modroot
          puts stderr "Sets the environment for using udunits-2.2.26\
                      \nin the shared directory /share/apps/udunits/2.2.26/gcc-5.4.0\
                      \nbuilt with gcc-5.4.0"
      }

      module-whatis "(Name________) udunits"
      module-whatis "(Version_____) 2.2.26"
      module-whatis "(Compilers___) gcc-5.4.0"
      module-whatis "(System______) x86_64-redhat-linux"
      module-whatis "(Libraries___) cunit/2.1-3_gcc-5.4.0"

      # for Tcl script use only
      set         topdir        /share/apps/udunits/2.2.26/gcc-5.4.0
      set         version       2.2.26
      set         sys           x86_64-redhat-linux

      conflict udunits
      module load gcc/5.4.0
      module load cunit/2.1-3_gcc-5.4.0

      prepend-path    LD_LIBRARY_PATH         $topdir/lib
      prepend-path    LIBRARY_PATH            $topdir/lib
      prepend-path    LD_RUN_PATH             $topdir/lib

      prepend-path    C_PATH          	      $topdir/lib

      prepend-path    C_INCLUDE_PATH          $topdir/include
      prepend-path    CXX_INCLUDE_PATH        $topdir/include
      prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

      prepend-path	INFODIR			          $topdir/share/info
      prepend-path	INFOPATH		          $topdir/share/info

      setenv		UDUNITS_HOME		      $topdir
      setenv		UDUNITS2_XML_PATH	      $topdir/share/udunits/udunits2.xml




Use
---

    .. code-block:: bash

       module load udunits/2.2.26_gcc-5.4.0

Resources
---------

    * https://www.unidata.ucar.edu/software/udunits/udunits-current/doc/udunits/udunits2.html


:Author:

 * Laura Sánchez Córdoba
