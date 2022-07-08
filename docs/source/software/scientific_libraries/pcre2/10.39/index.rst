
PCRE-2 10.39
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://pcre.org/
- **License:**  https://pcre.org/licence.txt
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

        $ wget https://github.com/PhilipHazel/pcre2/releases/download/pcre2-10.39/pcre2-10.39.tar.gz
        $ tar xzvf pcre2-10.39.tar.gz

3. Move to the decompressed directory

    .. code-block:: bash

        $ cd pcre2-10.39

4. Export the necessary variables and configure:

    .. code-block:: bash

        $ export CC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export FC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/ifort
        $ export  FCFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export CXX=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CXXFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ ./configure --prefix=/share/apps/pcre2/10.39/Intel_oneAPI-2022_update-1/

5. Compile and install:

    .. code-block:: bash

        $ make -j 16
        $ make -j 16 install

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modules pcre2/10.39_Intel_oneAPI-2022_update-1
        ##
        ## /share/apps/modules/pcre2/10.39 Written by Jacobo Monsalve
        ###

        proc ModulesHelp { } {
            puts stderr "\tpcre2/10.39 - sets the Environment for PCRE2 10.39 in \
                        \n\tThe share directory /share/apps/pcre2/10.39/Intel_oneAPI-2022_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using PCRE2 10.39\
                    \nbuilded with Intel oneAPI 2022 update 1\n"

        # for Tcl script use only
        set   topdir     /share/apps/pcre2/10.39/Intel_oneAPI-2022_update-1
        set   version    10.39
        set   sys        x86_64-redhat-linux

        module load intel/2022_oneAPI-update1
        prepend-path      PATH         $topdir/bin
        prepend-path      LD_LIBRARY_PATH         $topdir/lib64
        prepend-path      LIBRARY_PATH            $topdir/lib64
        prepend-path      LD_RUN_PATH             $topdir/lib64
        prepend-path      MANPATH             $topdir/man
        prepend-path     C_INCLUDE_PATH       $topdir/include
        prepend-path     CXX_INCLUDE_PATH     $topdir/include
        prepend-path     CPLUS_INCLUDE_PATH   $topdir/include
        prepend-path    PKG_CONFIG_PATH         $topdir/lib64/pkgconfig

How to use
----------

    .. code-block:: bash

        $ module load pcre2/10.39_Intel_oneAPI-2022_update-1

:Authors:

- Jacobo Monsalve Guzman
