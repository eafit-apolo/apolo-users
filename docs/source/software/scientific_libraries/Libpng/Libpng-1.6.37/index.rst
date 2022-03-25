.. _Libpng-1.6.37:

Libpng-1.6.37
=============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 03/03/2022
- **Official Website:** http://www.libpng.org/
- **Supercomputer:** Apolo II



Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module load intel/2022_oneAPI-update1

2. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.37/libpng-1.6.37.tar.xz
        $ tar -zxvf libpng-1.6.37.tar.xz

3. After unzipping **Libpng**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd libpng-1.6.37

        $ ./configure --prefix=/share/apps/libpng/1.6.37/Intel_oneAPI-2022_update-1

        $ make -j 10 2>&1 | tee zlib-make.log
        $ make check 2>&1 | tee zlib-make-check.log
        $ sudo mkdir -p /share/apps/libpng/1.6.37
        $ sudo make install 2>&1 | tee gmp-make-install.log

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modulefile /share/apps/libpng/1.6.37
        ##

        proc ModulesHelp { } {
             global version modroot
                  puts stderr "\t Libpng 1.6.37"
        }

        module-whatis "\n\n\tSets the environment for using Libpng 1.6.37 \n"

        set     topdir          /share/apps/libpng/1.6.37/Intel_oneAPI-2022_update-1
        set     version         1.6.37
        set     sys             x86_64-redhat-linux

        prepend-path    PATH                    $topdir/bin

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    MANPATH                 $topdir/share

        setenv          LIBPNG_HOME             $topdir



Mode of use
-----------

    .. code-block:: bash

        $ module load libpng/1.6.37_Intel_oneAPI-2022_update-1

References
----------

.. [1] http://www.libpng.org/

:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
