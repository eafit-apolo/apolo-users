.. _curl-7.82.0:

Curl 7.82.0
===========

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 03/03/2022
- **Official Website:** https://github.com/curl/curl
- **Supercomputer:** Apolo II



Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module load gcc/11.2.0

2. Download the desired version of the software (Source code - tar.bz2) [1]_

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget https://curl.se/download/curl-7.82.0.tar.bz2
        $ tar -xvf curl-7.82.0.tar.bz2

3. After unzipping **Curl**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd curl-7.82.0

        $ ./configure --prefix=/share/apps/curl/7.82.0/gcc-11.2.0 --disable-static --with-openssl --enable-threaded-resolver

        $ make -j 10 2>&1 | tee curl-make.log
        $ make -j 10 check 2>&1 | tee curl-make-check.log
        $ sudo mkdir -p /share/apps/curl/7.82.0
        $ sudo make install 2>&1 | tee curl-make-install.log

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## module curl/7.82.0_gcc-11.2.0
        ##
        ## /share/apps/curl/7.82.0/gcc-11.2.0     Written by Bryan Lopez Parra
        ##

        proc ModulesHelp { } {
            puts stderr "\tcurl/7.82.0 - sets the Environment for CURL in \
            \n\tthe share directory /share/apps/curl/7.82.0/gcc-11.2.0\n"
        }

        module-whatis "\n\n\tSets the environment for using CURL-7.82.0 \
                       \n\tbuilded with gcc 11.2.0 version\n"

        # for Tcl script use only
        set       topdir     /share/apps/curl/7.82.0/gcc-11.2.0
        set       version    7.82.0
        set       sys        x86_64-redhat-linux

        module load gcc/11.2.0

        prepend-path PATH               $topdir/bin

        prepend-path LD_LIBRARY_PATH    $topdir/lib
        prepend-path LIBRARY_PATH       $topdir/lib
        prepend-path LD_RUN_PATH        $topdir/lib

        prepend-path C_INCLUDE_PATH     $topdir/include
        prepend-path CXX_INCLUDE_PATH   $topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include

        prepend-path PKG_CONFIG_PATH    $topdir/lib/pkgconfig


Mode of use
-----------

    .. code-block:: bash

        $ module load curl/7.82.0_gcc-11.2.0

References
----------

.. [1] https://curl.se/

:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
