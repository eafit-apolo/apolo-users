.. _Szip-2.1.1-intel:

Szip 2.1.1 - Intel
==================

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** June 2020
- **Official Website:** https://www.zlib.net/
- **Supercomputer:** Apolo II
- **License:** Non commercial Use **[SEARCH]**


Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        module purge
        module load intel/19.0.4

2. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/salzatec1/apps/szip
        $ wget https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz
        $ tar -xvf szip-2.1.1.tar.gz



3. After unzipping SZIP, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd szip-2.1.1

        $ ./configure --prefix=/share/apps/szip/2.1.1/intel-19.0.4 --build=x86_64-redhat-linux

        $ make -j 10 2>&1 | tee szip-make.log
        $ make check 2>&1 | tee szip-make-check.log
        $ sudo mkdir -p /share/apps/szip/2.1.1/intel-19.0.4
        $ sudo make install 2>&1 | tee szip-make-install.log

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load szip/2.1.1_intel_19.0.4
        ##
        ## /share/apps/modules/szip/2.1.1_intel_19.0.4
        ## Written by Tomas David Navarro & Santiago Alzate Cardona
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using szip 2.1.1\
                          \nin the shared directory \
                          \n/share/apps/szip/2.1.1/intel_19.0.4/\
                          \nbuilded with intel-19.0.4"
        }

        module-whatis "(Name________) szip"
        module-whatis "(Version_____) 2.1.1"
        module-whatis "(Compilers___) intel-19.0.4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) intel"

        # for Tcl script use only
        set         topdir        /share/apps/szip/2.1.1/intel_19.0.4
        set         version       2.1.1
        set         sys           x86_64-redhat-linux

        conflict szip
        module load intel/19.0.4

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

Mode of use
-----------

    .. code-block:: bash

        $ module load szip/2.1.1_intel_19.0.4

References
----------

.. [1] https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz

Author
------

- Tomas David Navarro
- Santiago Alzate Cardona
