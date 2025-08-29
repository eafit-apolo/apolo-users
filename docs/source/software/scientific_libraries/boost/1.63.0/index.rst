.. _boost1.63-index:


Boost 1.63.0
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.boost.org/
- **License:** Boost Software License - Version 1.0 - August 17th, 2003
- **Installed on:** Apolo II and Cronos
- **Installation date:** 22/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GNU GCC >= 5.4.0 (64 Bits)
    * OpenMPI >= 1.8.8 (64 Bits)
    * Python >= 2.7.12
    * ICU >= 58.2



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/boost/gcc/5.4.0
        wget https://downloads.sourceforge.net/project/boost/boost/1.63.0/boost_1_63_0.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.63.0%2F&ts=1487777375&use_mirror=superb-dca2
        tar -zxvf boost_1_63_0.tar.gz



#. After unpacking Boost, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd boost_1_63_0/tools/build/
        module load openmpi/1.8.8-x86_64_gcc-5.4.0_cuda-8.0 python/2.7.12_intel-2017_update-1 icu/58.2_gcc-5.4.0
        ./bootstrap.sh
        sudo mkdir -p /share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0
        sudo chown -R mgomezzul.apolo /share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0
        emacs ~/user-config.jam
        ...
        using mpi ;
        ...
        ./bjam install --prefix=/share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0
        export PATH=/share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0/bin:$PATH
        cd ../..
        bjam --build-dir=/tmp/build-boost toolset=gcc stage address-model=64 --prefix=/share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0 install


Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## modules boost/1.63.0_gcc-5.4.0_openmpi-1.8.8-x86_64_cuda-8.0
        ##
        ## /share/apps/modules/boost/1.63.0_gcc-5.4.0_openmpi-1.8.8-x86_64_cuda-8.0  Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tboost/1.63.0_gcc-5.4.0_openmpi-1.8.8-x86_64_cuda-8.0 - sets the environment for BOOST C++ \
                        \n\tLIB in the shared directory /share/apps/boost/1.63.0/intel_impi/2017_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using BOOST 1.63.0 \
                \n\tbuilded with gcc-5.4.0, OpenMPI 1.8.8 x86_64, Python 2.7.12 Intel\n"

        # for Tcl script use only
        set     topdir     /share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0
        set     version    1.63.0
        set     sys        x86_64-redhat-linux

        conflict boost

        module load openmpi/1.8.8-x86_64_gcc-5.4.0_cuda-8.0
        module load python/2.7.12_intel-2017_update-1
        module load icu/58.2_gcc-5.4.0

        prepend-path    PATH			$topdir/bin

        prepend-path    C_INCLUDE_PATH		$topdir/include
        prepend-path 	CXX_INCLUDE_PATH   	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include

        prepend-path    LD_LIBRARY_PATH		$topdir/lib
        prepend-path    LIBRARY_PATH		$topdir/lib
        prepend-path 	LD_RUN_PATH        	$topdir/lib

        setenv 		BOOST_HOME		$topdir
        setenv		BOOST_INCLUDE_DIR	$topdir/include
        setenv		BOOST_LIBRARY		$topdir/lib


Use
---
    .. code-block:: bash

        module load boost/1.63.0_gcc-5.4.0_openmpi-1.8.8-x86_64_cuda-8.0


Resources
---------
    * http://www.boost.org/doc/libs/1_46_1/more/getting_started/unix-variants.html
    * https://software.intel.com/en-us/articles/building-boost-with-intel-c-compiler-150
    * http://www.boost.org/doc/libs/1_61_0/doc/html/mpi/getting_started.html#mpi.bjam
    * http://www.boost.org/build/doc/html/bbv2/overview/invocation.html
    * http://kratos-wiki.cimne.upc.edu/index.php/How_to_compile_the_Boost_if_you_want_to_use_MPI


Author
------
    * Mateo Gómez Zuluaga
