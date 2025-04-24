.. _boost1.67-index:


Boost 1.67.0
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
    * Intel Parallel Studio XE Cluster Edition (Intel MPI) >= 2017 Update 1
    * Python2 (Intel Version) >= 2.7.14
    * ICU >= 58.2
    * GNU GCC >= 5.4.0
    * OpenMPI >= 1.10.7
    * Python2 >= 2.7.14
    * ICU >= 58.2

Installation
------------

Intel
~~~~~

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        module load intel/2017_update-1 impi/2017_update-1 mkl/2017_update-1 python/2.7.14_intel-18_u1 gcc/5.5.0 icu/58.2_gcc-5.5.0
        cd /home/mgomezzul/apps/boost/src/intel-17.0.1/boost_1_67_0
        wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_76_0.tar.gz
        tar xf boost_1_67_0.tar.gz



#. After unpacking Boost, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        mkdir -p /share/apps/boost/1.67.0/intel-17.0.1
        sudo chown -R mgomezzul.apolo /share/apps/boost/1.67.0/intel-17.0.1
        cd boost_1_67_0/tools/build
        sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' -i bootstrap.sh
        ./bootstrap.sh --with-toolset=intel-linux
        ./b2 install --prefix=/share/apps/boost/1.67.0/intel-17.0.1 toolset=intel-linux
        export PATH=/share/apps/boost/1.67.0/intel-17.0.1/bin:$PATH
        cd ../..
        sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' -i bootstrap.sh
        mpiicc -show # A partir de esta salida armar el contenido del siguiente archivo.
        emacs user-config.jam
        ...
        using mpi : mpiicc :
            <library-path>/share/apps/intel/ps_xe/2017_update-1/compilers_and_libraries_2017.1.132/linux/mpi/intel64/lib
            <library-path>/share/apps/intel/ps_xe/2017_update-1/compilers_and_libraries_2017.1.132/linux/mpi/intel64/lib/release_mt
            <include>/share/apps/intel/ps_xe/2017_update-1/compilers_and_libraries_2017.1.132/linux/mpi/intel64/include
            <find-shared-library>mpifort
            <find-shared-library>mpi
            <find-shared-library>mpigi
            <find-shared-library>dl
            <find-shared-library>rt
            <find-shared-library>pthread ;
        ...
        b2 --prefix=/share/apps/boost/1.67.0/intel-17.0.1 toolset=intel-linux stage install
        sudo chown -R root.root /share/apps/boost/1.67.0/intel-17.0.1



Free Software
~~~~~~~~~~~~~

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        module load openmpi/1.10.7_gcc-5.4.0 icu/58.2_gcc-5.5.0
        cd /home/mgomezzul/apps/boost/src/gcc-5.4.0
        wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_76_0.tar.gz
        tar xf boost_1_67_0.tar.gz


#. After unpacking Boost, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        mkdir -p /share/apps/boost/1.67.0/gcc-5.4.0
        sudo chown -R mgomezzul.apolo /share/apps/boost/1.67.0/gcc-5.4.0
        cd boost_1_67_0/tools/build
        sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' -i bootstrap.sh
        ./bootstrap.sh --with-toolset=gcc
        ./b2 install --prefix=/share/apps/boost/1.67.0/gcc-5.4.0 toolset=gcc
        export PATH=/share/apps/boost/1.67.0/gcc-5.4.0/bin:$PATH
        cd ../..
        sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' -i bootstrap.sh
        emacs user-config.jam
        ...
        using mpi ;
        ...
        b2 --prefix=/share/apps/boost/1.67.0/gcc-5.4.0 toolset=gcc stage install
        sudo chown -R root.root /share/apps/boost/1.67.0/gcc-5.4.0



Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load boost/1.67.0_intel-17.0.1
        ##
        ## /share/apps/modules/boost/1.67.1_intel-17.0.1
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using boost 1.67.0\
                \nin the shared directory /share/apps/boost/1.67.0/intel-17.0.1\
                \nbuilded with Intel Parallel Studio XE 2017 Update-1."
        }

        module-whatis "(Name________) boost"
        module-whatis "(Version_____) 1.67.0"
        module-whatis "(Compilers___) intel-17.0.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) icu"

        # for Tcl script use only
        set         topdir        /share/apps/boost/1.67.0/intel-17.0.1
        set         version       1.67.0
        set         sys           x86_64-redhat-linux

        conflict boost
        module load intel/2017_update-1
        module load icu/58.2_intel-2017_update-1
        module load python/2.7.12_intel-2017_update-1
        module load impi/2017_update-1
        module load mkl/2017_update-1

        prepend-path	PATH			$topdir/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib

        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLLUDE_PATH	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include



Resources
---------
    * https://software.intel.com/en-us/articles/building-boost-with-intel-c-compiler-150
    * http://www.linuxfromscratch.org/blfs/view/cvs/general/boost.html
    * http://www.boost.org/doc/libs/1_66_0/more/getting_started/unix-variants.html
    * https://www.boost.org/doc/libs/1_67_0/more/getting_started/unix-variants.html
    * https://www.boost.org/doc/libs/1_67_0/doc/html/mpi/getting_started.html
    * https://www.boost.org/doc/libs/1_66_0/doc/html/bbv2/overview.html
    * http://www.linuxfromscratch.org/blfs/view/8.2/general/boost.html


Author
------
    * Mateo Gómez Zuluaga
    * Juan Pablo Alcaraz Flórez
