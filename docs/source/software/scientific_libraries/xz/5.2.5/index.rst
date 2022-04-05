
XZ 5.2.5
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://tukaani.org/xz/
- **License:**  https://git.tukaani.org/?p=xz.git;a=blob;f=COPYING
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

        $ wget https://tukaani.org/xz/xz-5.2.5.tar.gz
        $ tar xvzf xz-5.2.5.tar.gz

3. Move to the decompressed directory

    .. code-block:: bash

        $cd xz-5.2.5

4. Export the necessary variables and configure:

    .. code-block:: bash

        $ export CC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export FC=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/ifort
        $ export  FCFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $ export CXX=/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/bin/intel64/icc
        $ export CXXFLAGS="-I/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/include -L/share/apps/intel/oneAPI/2022_update-1/compiler/2022.0.2/linux/lib -O3 -xHost -ip"
        $./configure --prefix=/share/apps/xz/5.2.5/Intel_oneAPI-2022_update-1

5. Compile and install:

    .. code-block:: bash

        $ make -j 16
        $ make -j 16 install

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modules xz/5.2.5_Intel_oneAPI-2022_update-1
        ##
        ## /share/apps/modules/xz/5.2.5  Written by Jacobo Monsalve
        ###

        proc ModulesHelp { } {
            puts stderr "\txz/5.2.5 - sets the Environment for XZ 5.2.5 in \
                        \n\tThe share directory /share/apps/xz/5.2.5/Intel_oneAPI-2022_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using XZ 5.2.5 \
                    \n\tbuilded with Intel oneAPI 2022 update 1\n"

        # for Tcl script use only
        set   topdir     /share/apps/xz/5.2.5/Intel_oneAPI-2022_update-1
        set   version    5.2.5
        set   sys        x86_64-redhat-linux

        module load intel/2022_oneAPI-update1
        prepend-path      PATH                    $topdir/bin
        prepend-path      LD_LIBRARY_PATH         $topdir/lib
        prepend-path      LIBRARY_PATH            $topdir/lib
        prepend-path      LD_RUN_PATH             $topdir/lib


        prepend-path      C_INCLUDE_PATH          $topdir/include
        prepend-path      CXX_INCLUDE_PATH        $topdir/include
        prepend-path      CPLUS_INCLUDE_PATH      $topdir/include
        prepend-path      PKG_CONFIG_PATH         $topdir/lib/pkgconfig


How to use
----------

    .. code-block:: bash

        $ module load xz/5.2.5_Intel_oneAPI-2022_update-1

:Authors:

- Jacobo Monsalve Guzman
