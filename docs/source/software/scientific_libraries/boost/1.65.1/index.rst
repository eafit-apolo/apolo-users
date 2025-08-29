.. _boost1.65.1-index:


Boost 1.65.1
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.boost.org/
- **License:** Boost Software License - Version 1.0 - August 17th, 2003
- **Installed on:** Apolo II and Cronos
- **Installation date:** 10/11/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Compile >= intel-17.0.1
    * Python >= 2.7.12
    * ICU >= 58.2


Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        $ cd /home/mgomezzul/apps/boost/gcc/5.4.0
        $ https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz
        $ tar xf boost_1_65_1.tar.gz



#. After unpacking Boost, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd boost_1_65_1
        $ module load python/2.7.12_intel-2017_update-1
        $ module load icu/58.2_intel-2017_update-1
        $ sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' -i bootstrap.sh # Correción "Bug"
        $ cd tools/build
        $ sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' -i bootstrap.sh # Correción "Bug"
        $ ./bootstrap.sh
        $ sudo mkdir -p /share/apps/boost/1.65.1/intel-17.0.1
        $ sudo chown -R mgomezzul.apolo /share/apps/boost/1.65.1/intel-17.0.1
        $ ./b2 install --prefix=/share/apps/boost/1.65.1/intel-17.0.1
        $ export PATH=/share/apps/boost/1.65.1/intel-17.0.1/bin:$PATH
        $ cd ../..
        $ mkdir /tmp/boost
        $ b2 --build-dir=/tmp/boost address-model=64 toolset=intel stage --prefix=/share/apps/boost/1.65.1/intel-17.0.1 install



Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load boost/1.65.1_intel-17.0.1
        ##
        ## /share/apps/modules/boost/1.65.1_intel-17.0.1
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using boost 1.65.1\
                        \nin the shared directory /share/apps/boost/1.65.1/intel-17.0.1\
                        \nbuilded with Intel Parallel Studio XE 2017 Update-1."
        }

        module-whatis "(Name________) boost"
        module-whatis "(Version_____) 1.65.1"
        module-whatis "(Compilers___) intel-17.0.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) icu"

        # for Tcl script use only
        set         topdir        /share/apps/boost/1.65.1/intel-17.0.1
        set         version       1.65.1
        set         sys           x86_64-redhat-linux

        conflict boost
        module load intel/2017_update-1
        module load icu/58.2_intel-2017_update-1
        module load python/2.7.12_intel-2017_update-1


        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLLUDE_PATH       $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include




Resources
---------
    * https://software.intel.com/en-us/articles/building-boost-with-intel-c-compiler-150
    * http://www.linuxfromscratch.org/blfs/view/cvs/general/boost.html
    * http://www.boost.org/doc/libs/1_65_1/more/getting_started/unix-variants.html


Author
------
    * Mateo Gómez Zuluaga
    * Juan Pablo Alcaraz Flórez
