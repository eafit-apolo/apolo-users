.. _Zlib-1.2.11-intel:

Zlib 1.2.11 - Intel
===================

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** June 2020
- **Official Website:** https://www.zlib.net/
- **Supercomputer:** Apolo II
- **License:** Zlib License



Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module purge
        $ module load intel/19.0.4

2. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd $HOME/apps/zlib
        $ wget https://zlib.net/zlib-1.2.11.tar.gz
        $ tar -xvf zlib-1.2.11.tar.gz

3. After unzipping **Zlib**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd zlib-1.2.11
        $ ./configure --prefix=/share/apps/zlib/1.2.11/intel-19.0.4/ --archs="-arch x86_64"
        $ make -j 10 2>&1 | tee zlib-make.log
        $ make check 2>&1 | tee zlib-make-check.log
        $ sudo mkdir -p /share/apps/zlib/1.2.11/intel-19.0.4
        $ sudo make install 2>&1 | tee gmp-make-install.log

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load zlib/1.2.11_intel_19.0.4
        ##
        ## /share/apps/modules/zlib/1.2.11_intel_19.0.4
        ## Written by Tomas David Navarro & Santiago Alzate Cardona
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using zlib 1.2.11\
                          \nin the shared directory \
                          \n/share/apps/zlib/1.2.11/intel_19.0.4/\
                          \nbuilded with intel_19.0.4"
        }

        module-whatis "(Name________) zlib"
        module-whatis "(Version_____) 1.2.11"
        module-whatis "(Compilers___) intel-19.0.4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) intel"

        # for Tcl script use only
        set         topdir        /share/apps/zlib/1.2.11/intel_19.0.4
        set         version       1.2.11
        set         sys           x86_64-redhat-linux

        conflict zlib
        module load intel/19.0.4

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    PKG_CONFIG_PATH         $topdir/lib/pkgconfig

        prepend-path    MANPATH                 $topdir/share/man


Mode of use
-----------

    .. code-block:: bash

        $ module load zlib/1.2.11_intel_19.0.4

References
----------

.. [1] https://www.zlib.net/

Author
------

- Tomas David Navarro
- Santiago Alzate Cardona
