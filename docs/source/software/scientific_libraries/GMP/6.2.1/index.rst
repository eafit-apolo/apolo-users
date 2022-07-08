.. _gmp6.2.1-index:

GMP 6.2.1
=========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://gmplib.org/
- **License:** Free Software Foundation’s GNU General Public License
- **Installed on:** Apolo II
- **Installation date:** 03/03/2022


Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash


        cd /home/blopezp
        wget https://gmplib.org/download/gmp-6.2.1/gmp-6.2.1.tar.xz
        tar -xvf gmp-6.2.1.tar.xz


#. After unpacking GMP, continue with the following steps for configuration and compilation:

    .. code-block:: bash


        cd gmp-6.2.1
        ./configure --prefix=/share/apps/gmp/6.2.1/gcc-8.5.0  --build=x86_64-redhat-linux-gnu --enable-cxx --enable-assert --with-gnu-ld
        make -j 10 2>&1 | tee gmp-make.log
        sudo mkdir -p /share/apps/gmp/6.2.1
        sudo make install 2>&1 | tee gmp-make-install.log


Module
------

    .. code-block:: bash


        #%Module1.0####################################################################
        ##
        ## module load gmp/6.2.1_gcc-8.5.0
        ##
        ## /share/apps/modules/gmp/6.1.2_gcc-8.5.0
        ## Written by Bryan Lopez Parra
        ##
        proc ModulesHelp {} {
            global version modroot
            puts stderr "\n\n\tSets the environment for using gmp (GNU Multiple \
                        \n\tPrecision Arithmetic Library) builded gcc 8.5.0 version\n"
        }
        module-whatis "(Name________) gmp"
        module-whatis "(Version_____) 6.2.1"
        module-whatis "(Compilers___) gcc-8.5.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "
        # for Tcl script use only
        set         topdir        /share/apps/gmp/6.2.1/gcc-8.5.0
        set         version       6.2.1
        set         sys           x86_64-redhat-linux
        conflict gmp

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib
        prepend-path    GMP_LIBRARIES           $topdir/lib
        prepend-path    GMPXX_LIBRARIES         $topdir/lib
        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include
        prepend-path    GMP_INCLUDE_DIR         $topdir/include
        prepend-path    GMPXX_INCLUDE_DIR       $topdir/include
        prepend-path    INFOPATH                $topdir/share/info



Use
---
    .. code-block:: bash

        module load gmp/6.2.1_gcc-8.5.0


Resources
---------

    * https://gmplib.org/#DOWNLOAD


:Authors:

- Bryan López Parra <blopezp@eafit.edu.co>
