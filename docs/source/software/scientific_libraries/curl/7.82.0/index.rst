
CURL 7.82.0
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://curl.se/
- **License:**  https://curl.se/docs/copyright.html
- **Installed on:** Apolo II
- **Instalation date:** 14/03/2022

Prerequisites
-------------

- Intel oneAPI


Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module load intel

2. Download the desired version of the software

    .. code-block:: bash

        $ wget https://curl.se/download/curl-7.82.0.tar.gz
        $ tar xzvf curl-7.82.0.tar.gz

3. Move to the decompressed directory

    .. code-block:: bash

        $cd curl-7.82.0

4. Export the necessary variables and configure:

    .. code-block:: bash

        $ export CC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export FC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/ifort
        $ export  FCFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export CXX=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CXXFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ ./configure --prefix=/share/apps/curl/7.82.0/Intel_oneAPI-2022_update-1 --with-openssl

5. Compile and install:

    .. code-block:: bash

        $ make -j 16
        $ make -j 16 install

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## module curl/7.82.0_Intel_oneAPI-2022_update-1
        ##
        ## /share/apps/curl/7.82.0/Intel_oneAPI-2022_update-1     Written by Jacobo Monsalve Guzman
        ##

        proc ModulesHelp { } {
            puts stderr "\tcurl/7.82.0 - sets the Environment for CURL in \
            \n\tthe share directory /share/apps/curl/7.82.0\n"
        }

        module-whatis "\n\n\tSets the environment for using CURL-7.82.0 \
                    \n\tbuilded with Intel oneAPi update 2022-1 version\n"

        # for Tcl script use only
        set       topdir     /share/apps/curl/7.82.0/Intel_oneAPI-2022_update-1
        set       version    7.82.0
        set       sys        x86_64-redhat-linux

        prepend-path PATH               $topdir/bin
        prepend-path PATH               $topdir/sbin

        prepend-path LD_LIBRARY_PATH    $topdir/lib
        prepend-path LIBRARY_PATH       $topdir/lib
        prepend-path LD_RUN_PATH        $topdir/lib

        prepend-path C_INCLUDE_PATH     $topdir/include
        prepend-path CXX_INCLUDE_PATH   $topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include

        prepend-path PKG_CONFIG_PATH    $topdir/lib/pkgconfig


How to use
----------

    .. code-block:: bash

        $ module load curl/7.82.0_Intel_oneAPI-2022_update1

:Authors:

- Jacobo Monsalve Guzman
