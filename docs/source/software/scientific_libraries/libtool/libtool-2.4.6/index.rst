.. _libtool-2.4.6:

Libtool 2.4.6
=============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 03/03/2022
- **Official Website:** https://www.gnu.org/software/libtool/
- **Supercomputer:** Apolo II
- **License:** GNU License version 3.0



Installation
------------

1. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
        $ tar -zxvf libtool-2.4.6.tar.gz

2. After unzipping **Libtool**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd libtool-2.4.6

        $ ./configure --prefix=/share/apps/libtool/2.4.6/gcc-8.5.0

        $ make -j 10 2>&1 |& tee libtool-make.log
        $ make check 2>&1 |& tee libtool-make-check.log
        $ sudo mkdir -p /share/apps/libtool/2.4.6
        $ make -j 10 install 2>&1 |& tee libtool-make-install.log

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modules libtool/2.4.6_Intel_gcc-8.5.0
        ##
        ## /share/apps/modules/libtool/2.4.6  Written by Bryan Lopez Parra
        ###

        proc ModulesHelp { } {
            puts stderr "\tLibtool/2.4.6 - sets the Environment for LIBTOOL 2.4.6 in \
                         \n\tThe share directory /share/apps/libtool/2.4.6/gcc-8.5.0\n"
        }

        module-whatis "\n\n\tSets the environment for using LIBTOOL 2.4.6 \
                      \n\tbuilded with Intel GCC 8.5.0\n"

        # for Tcl script use only
        set   topdir     /share/apps/libtool/2.4.6/gcc-8.5.0
        set   version    2.4.6
        set   sys        x86_64-redhat-linux


        prepend-path      PATH                    $topdir/bin
        prepend-path      LD_LIBRARY_PATH         $topdir/lib
        prepend-path      LIBRARY_PATH            $topdir/lib
        prepend-path      LD_RUN_PATH             $topdir/lib
        prepend-path      INCLUDE_PATH            $topdir/include



Mode of use
-----------

    .. code-block:: bash

        $ module load libtool/2.4.6_gcc-8.5.0

References
----------

.. [1] https://www.gnu.org/software/libtool/


:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
