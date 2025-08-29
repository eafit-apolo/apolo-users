
BZIP2 1.1
=========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://pcre.org/ https://gitlab.com/bzip2/bzip2/-/tree/master
- **License:**  https://sourceware.org/bzip2/index.html
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

2. Download the software

    .. code-block:: bash

        $ git clone https://gitlab.com/bzip2/bzip2

3. Move to the directory

    .. code-block:: bash

        $ cd bzip2

4. Export the necessary variables and configure:

    .. code-block:: bash

        $ export CC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export FC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/ifort
        $ export  FCFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export CXX=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CXXFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ mkdir build && cd build
        $ cmake -DCMAKE_INSTALL_PREFIX:PATH=/share/apps/bzip2/1.1.0/Intel_oneAPI-2022_update-1

5. Compile and install:

    .. code-block:: bash

        $ cmake --build . --target install --config Release

Module
------

    .. code-block:: tcl


        #%Module1.0#####################################################################
        ##
        ## modules bzip2/1.0.8_Intel_oneAPI-2022_update-1
        ##
        ## /share/apps/modules/bzip2/1.0.8  Written by Jacobo Monsalve
        ###

        proc ModulesHelp { } {
            puts stderr "\tbzip2/1.1.0 - sets the Environment for BZIP2 1.1.0 in \
                        \n\tThe share directory /share/apps/bzip2/1.1.0/Intel_oneAPI-2022_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using bzip2 1.1.0 \
                    \n\tbuilded with Intel oneAPI 2022 update 1\n"
        # for Tcl script use only
        set   topdir     /share/apps/bzip2/1.1.0/Intel_oneAPI-2022_update-1
        set   version    1.1.0
        set   sys        x86_64-redhat-linux

        module load intel/2022_oneAPI-update1
        prepend-path      PATH                    $topdir/bin
        prepend-path      LD_LIBRARY_PATH         $topdir/lib64
        prepend-path      LIBRARY_PATH            $topdir/lib64
        prepend-path      LD_RUN_PATH             $topdir/lib64

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include
        prepend-path    PKG_CONFIG_PATH         $topdir/lib/pkgconfig

        setenv            BZIP2                  $topdir/lib64/libbz2.so

How to use
----------

    .. code-block:: bash

        $ module load bzip2/1.1.0_Intel_oneAPI-2022_update-1

:Authors:

- Jacobo Monsalve Guzman
