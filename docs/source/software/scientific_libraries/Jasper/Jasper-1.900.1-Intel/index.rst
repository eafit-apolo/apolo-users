.. _Jasper-1.900.1-intel:

Jasper 1.900.1
==============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** June 2020
- **Official Website:** https://www.ece.uvic.ca/~frodo/jasper/
- **Supercomputer:** Apolo II
- **License:** JasPer License Version 2.0

Prerequisites
-------------

- Python 2.7, Python 3.4 or higher
- numpy
- Pysam
- matplotlib (Just in case you want to generate graphics)

Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module load intel/19.0.4

2. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
        $ unzip jasper-1.900.1.zip

3. After decompressing JASPER, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd jasper-1.900.1
        $ ./configure --prefix=/share/apps/jasper/1.900.1/intel-19.0.4 --build=x86_64-redhat-linux
        $ make -j 10 2>&1 | tee jasper-make.log
        $ make check 2>&1 | tee jasper-make-check.log
        $ sudo mkdir -p /share/apps/jasper/1.900.1/intel-19.0.4
        $ make install 2>&1 | tee jasper-make-install.log

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load jasper/1.900.1_intel-19.0.4
        ##
        ## /share/apps/modules/jasper/1.900.1_intel-2017_update-1
        ## Written by Tomas Navarro & Santiago Alzate
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using jasper 1in the shared directory /share/apps/jasper/1.900.1/intel-19.0.4/\
                          \nbuilded with Intel Parallel Studio XE .900.1\
                          \n2017\n"
        }

        module-whatis "(Name________) jasper"
        module-whatis "(Version_____) 1.900.1"
        module-whatis "(Compilers___) intel-2019_update-4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/jasper/1.900.1/intel-19.0.4
        set         version       1.900.1
        set         sys           x86_64-redhat-linux

        setenv          JASPERLIB               $topdir/lib
        setenv          JASPERINC               $topdir/include

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLLUDE_PATH       $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include


Mode of use
-----------

    .. code-block:: bash

        $ module load jasper/1.900.1_intel-19.0.4

References
----------

.. [1] https://www.ece.uvic.ca/~frodo/jasper/#download

Author
------

- Tomas David Navarro
- Santiago Alzate Cardona
