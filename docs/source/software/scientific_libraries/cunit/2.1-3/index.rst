.. _CUnit-2.1-3-index:

CUnit 2.1-3
===========

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** http://cunit.sourceforge.net/
- **License:**
- **Installed on:** Apolo II
- **Installation date:** 10/06/2020

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GCC (tested on 5.4.0)



Installation
------------

#. Download the 2.1-3 version of CUnit

   .. code-block:: bash

      $ wget https://github.com/Linaro/libcunit/releases/download/2.1-3/CUnit-2.1-3.tar.bz2
      $ tar -xvf CUnit-2.1-3.tar.bz2
      $ cd CUnit-2.1-3

#. After unpacking CUnit, continue with the following steps for configuration and compilation:

   .. code-block:: bash

      $ module load gcc/5.4.0
      $ aclocal
      $ autoconf
      $ automake  # If this command fails go to Troubleshooting
      $ ./configure --prefix=/share/apps/cunit/2.1-3/gcc-5.4.0/
      $ make
      $ make install

Troubleshooting
---------------
Automake will not work on Cent0S 6.2 or Rocks 6. Then, what you have to do is to use the autoreconf -i command and run automake again, this is because autoconf doesn't generate the files properly.

Module
------


   .. code-block:: bash

      #%Module1.0####################################################################
      ##
      ## module load cunit/2.1-3_gcc-5.4.0
      ##
      ## /share/apps/modules/cunit/2.1-3_gcc-5.4.0
      ## Written by Laura Sanchez Córdoba
      ## Date: June 10, 2020
      ##

      proc ModulesHelp {} {
           global version modroot
           puts stderr "Sets the environment for using CUnit-2.1-3\
                        \nin the shared directory /share/apps/cunit/2.1-3/gcc-5.4.0\
                        \nbuilt with gcc-5.4.0"
      }

      module-whatis "(Name________) cunit"
      module-whatis "(Version_____) 2.1-3"
      module-whatis "(Compilers___) gcc-5.4.0"
      module-whatis "(System______) x86_64-redhat-linux"
      module-whatis "(Libraries___) "

      # for Tcl script use only
      set         topdir        /share/apps/cunit/2.1-3/gcc-5.4.0
      set         version       2.1-3
      set         sys           x86_64-redhat-linux

      conflict cunit
      module load gcc/5.4.0

      prepend-path    LD_LIBRARY_PATH         $topdir/lib
      prepend-path    LIBRARY_PATH            $topdir/lib
      prepend-path    LD_RUN_PATH             $topdir/lib

      prepend-path    C_PATH          	      $topdir/lib

      prepend-path    C_INCLUDE_PATH          $topdir/include
      prepend-path    CXX_INCLUDE_PATH        $topdir/include
      prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

      prepend-path    PKG_CONFIG_PATH         $topdir/lib/pkgconfig

      prepend-path    MANPATH                 $topdir/share/man

      setenv		CUNIT_HOME		$topdir




Use
---

    .. code-block:: bash

       module load cunit/2.1-3_gcc-5.4.0

Resources
---------

    * CUnit README


:Author:

 * Laura Sánchez Córdoba
