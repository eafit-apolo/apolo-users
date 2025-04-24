.. _boost1.66-index:


Boost 1.66.0
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.boost.org/
- **License:** Boost Software License - Version 1.0 - August 17th, 2003
- **Installed on:** Apolo II and Cronos
- **Installation date:** 19/02/2018

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GNU Gcc >= 5.5.0
    * OpenMPI >= 1.10.7
    * Python >= 2.7.14
    * ICU = 58.2


Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        module load python/2.7.14_intel-18_u1 gcc/5.5.0 openmpi/1.10.7_gcc-5.5.0 icu/58.2_gcc-5.5.0
        cd /home/mgomezzul/apps/boost/src/gcc-5.5.0/boost_1_66_0
        wget https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz
        tar xf boost_1_66_0.tar.gz



#. After unpacking Boost, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        mkdir -p /share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7
        sudo chown -R mgomezzul.apolo /share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7
        cd boost_1_66_0/tools/build
        ./bootstrap.sh
        /b2 install --prefix=/share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7
        export PATH=/share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7/bin:$PATH
        cd ../..
        b2 address-model=64 link=static,shared threading=multi toolset=gcc variant=release -j 16 -sICU_PATH=/share/apps/icu/58.2/gcc-5.5.0 -sICU_ROOT=/share/apps/icu/58.2/gcc-5.5.0 --prefix=/share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7 stage install
        sudo chown -R root.root /share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load boost/1.66.0_gcc-5.5.0_openmpi-1.10.7
        ##
        ## /share/apps/modules/boost/1.66.0_gcc-5.5.0_openmpi-1.10.7
        ## Written by Mateo Gómez Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using Boost 1.66.0\
                \nin the shared directory \
                \n/share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7\
                \nbuilded with gcc-5.5.0, OpenMPI-1.10.7, ICU-58.2\
                \nand python-2.7.14."
        }

        module-whatis "(Name________) boost"
        module-whatis "(Version_____) 1.66.0"
        module-whatis "(Compilers___) gcc-5.5.0_openmpi-1.10.7"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) icu-58.2"

        # for Tcl script use only
        set         topdir        /share/apps/boost/1.66.0/gcc-5.5.0_openmpi-1.10.7
        set         version       1.66.0
        set         sys           x86_64-redhat-linux

        conflict boost
        module load python/2.7.14_intel-18_u1
        module load icu/58.2_gcc-5.5.0
        module load openmpi/1.10.7_gcc-5.5.0

        prepend-path	PATH			$topdir/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib

        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLUDE_PATH	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include




Resources
---------
    * https://software.intel.com/en-us/articles/building-boost-with-intel-c-compiler-150
    * http://www.linuxfromscratch.org/blfs/view/cvs/general/boost.html
    * http://www.boost.org/doc/libs/1_66_0/more/getting_started/unix-variants.html



Author
------
    * Mateo Gómez Zuluaga
    * Juan Pablo Alcaraz Flórez
