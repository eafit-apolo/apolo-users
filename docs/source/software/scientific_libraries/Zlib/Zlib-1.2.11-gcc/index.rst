.. _Zlib-1.2.11-gcc:

Zlib 1.2.11-gcc
===============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 03/03/2022
- **Official Website:** https://www.zlib.net/
- **Supercomputer:** Apolo II
- **License:** Zlib License



Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        module load gcc/11.2.0

2. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget https://zlib.net/zlib-1.2.11.tar.gz
        $ tar -zxvf zlib-1.2.11.tar.gz

3. After unzipping **Zlib**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd zlib-1.2.11

        $ ./configure --prefix=/share/apps/zlib/1.2.11/gcc-11.2.0

        $ make -j 10 2>&1 | tee zlib-make.log
        $ make check 2>&1 | tee zlib-make-check.log
        $ sudo mkdir -p /share/apps/zlib/1.2.11
        $ make install 2>&1 | tee gmp-make-install.log

Module
------

    .. code-block:: tcl

        ##
        ## module load zlib/1.2.11_gcc-11.2.0
        ##
        ## /share/apps/zlib/1.2.11/gcc-11.2.0
        ## Written by Bryan Lopez Parra
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using zlib 1.2.11\
                          \nin the shared directory \
                          \n/share/apps/zlib/1.2.11/gcc-11.2.0/\
                          \nbuilded with gcc 11.2.0"
        }

        module-whatis "(Name________) zlib"
        module-whatis "(Version_____) 1.2.11"
        module-whatis "(Compilers___) gcc-11.2.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) gcc"

        # for Tcl script use only
        set         topdir        /share/apps/zlib/1.2.11/gcc-11.2.0
        set         version       1.2.11
        set         sys           x86_64-redhat-linux

        conflict zlib
        module load gcc/11.2.0

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

        $ module load zlib/1.2.11_gcc-11.2.0

References
----------

.. [1] https://www.zlib.net/

:Authors:

- Bryan López Parra <blopez@eafit.edu.co>
