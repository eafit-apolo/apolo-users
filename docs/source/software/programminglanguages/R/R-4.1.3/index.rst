.. _R-4.1.3-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash


R - 4.1.3
=========

Basic Information
-----------------

- **Instalation Date:** 18/03/2022
- **URL:** https://www.r-project.org/
- ** APolo Version** Apolo II
- ** License:** https://www.r-project.org/Licenses/

Dependencies
------------
- zlib >= 1.25
- bzip2 >= 1.0.6
- xz
- pcre2 >= 10.30
- curl >= 7.28.0 with https support
- JDK
- mpi
- mkl
- OneApi compiler
- lapack

Installation
------------
After the dependencies have been resolved and configured, the **R** installation can start.

.. note:: The intel compiler will be used to build R

1. Download the selected version from an official mirror (https://cran.r-project.org/mirrors.html).

    .. code-block:: bash

        $ wget https://cran.r-project.org/src/base/R-4/R-4.1.3.tar.gz
        $ tar xvzf R-4.1.3.tar.gz


2. Load the corresponding modules to set the building environment.

    .. code-block:: bash

        $ module load zlib/1.2.11_Intel_oneAPI-2022_update-1 bzip2/1.1.0_Intel_oneAPI-2022_update-1  xz/5.2.5_Intel_oneAPI-2022_update-1 pcre2/10.39_Intel_oneAPI-2022_update-1 curl/7.82.0_Intel_oneAPI-2022_update1
        $ module load java/jdk-17.0.2 intel/2022_oneAPI-update1 mpi/2021.5.1 mkl/2022.0.2 lapack/3.10.0_Intel_oneAPI-2022_update-1


3. Configure the resources

    .. code-block:: bash

        ./configure --prefix=/share/apps/r/4.1.3/Intel_oneAPI-2022_update-1 \
        --build=x86_64-redhat-linux --enable-R-shlib \
        --with-blas="-L/share/apps/intel/oneAPI/2022_update-1/mkl/2022.0.2/lib/intel64 \
        -lmkl_rt -liomp5 -lpthread" --with-lapack --enable-BLAS-shlib \
        --without-x --enable-memory-profiling \
        LDFLAGS="$LDFLAGS -qopenmp -L/share/apps/bzip2/1.1.0/Intel_oneAPI-2022_update-1/lib64 \
        -L/share/apps/pcre2/10.39/Intel_oneAPI-2022_update-1/lib64 \
        -L/share/apps/xz/5.2.5/Intel_oneAPI-2022_update-1/lib" \
        CFLAGS="$CFLAGS -fPIC -qopenmp -O3 -ipo -xHost \
        -I/share/apps/bzip2/1.1.0/Intel_oneAPI-2022_update-1/include \
        -I/share/apps/pcre2/10.39/Intel_oneAPI-2022_update-1/include \
        -I/share/apps/xz/5.2.5/Intel_oneAPI-2022_update-1/include" \
        CXXFLAGS="$CXXFLAGS -fPIC -qopenmp -O3 -ipo -xHost \
        -I/share/apps/bzip2/1.1.0/Intel_oneAPI-2022_update-1/include \
        -I/share/apps/xz/5.2.5/Intel_oneAPI-2022_update-1/include" \
        FFLAGS="$FFLAGS -fPIC -qopenmp -O3 -ipo -xHost" \
        FCFLAGS="$FCFLAGS -fPIC -qopenmp -O3 -ipo -xHost" --with-readline=no

4. Before doing make, delete or comment the following line on src/include/config.h.in

    ::

    #undef HAVE_MATHERR

5. Build the sources

    .. code-block::  bash

        $ make -j 16
        $ make -j 16 install


Module
------

The following is the module used for this version.

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modules r/4.1.3_Intel_oneAPI-2022_update-1
        ##
        ## /share/apps/r/4.1.3/Intel_oneAPI-2022_update-1  Written by Bryan Lopez Parra
        ##

        proc ModulesHelp { } {
            puts stderr "\tR/4.1.3_Intel_oneAPI-2022_update-1 - sets the Environment for R in \
            \n\tthe share directory /share/apps/r/4.1.3/Intel_oneAPI-2022_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for R language \
                    \n\tbuilt with  Intel MKL oneAPI 2022 (Update-1)version \
                    \n\t(Update-1)\n"

        # for Tcl script use only
        set       topdir     /share/apps/r/4.1.3/Intel_oneAPI-2022_update-1
        set       version    4.1.3
        set       sys        x86_64-redhat-linux

        conflict r

        module load zlib/1.2.11_Intel_oneAPI-2022_update-1 bzip2/1.1.0_Intel_oneAPI-2022_update-1  xz/5.2.5_Intel_oneAPI-2022_update-1 pcre2/10.39_Intel_oneAPI-2022_update-1 curl/7.82.0_Intel_oneAPI-2022_update1
        module load java/jdk-17.0.2 intel/2022_oneAPI-update1 mpi/2021.5.1 mkl/2022.0.2 lapack/3.10.0_Intel_oneAPI-2022_update-1

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib64/R/lib
        prepend-path    LD_RUN_PATH             $topdir/lib64/R/lib
        prepend-path    LIBRARY_PATH            $topdir/lib64/R/lib
        prepend-path    LD_LIBRARY_PATH         $topdir/lib64/R/modules
        prepend-path    LD_RUN_PATH             $topdir/lib64/R/modules
        prepend-path    LIBRARY_PATH            $topdir/lib64/R/modules

        prepend-path    C_INCLUDE_PATH          $topdir/lib64/R/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/lib64/R/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/lib64/R/include
        prepend-path    C_INCLUDE_PATH          $topdir/lib64/R/include/R_ext
        prepend-path    CXX_INCLUDE_PATH        $topdir/lib64/R/include/R_ext
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/lib64/R/include/R_ext

        prepend-path    PKG_CONFIG_PATH         $topdir/lib64/pkgconfig

        prepend-path    MAN_PATH                $topdir/share/man


:Authors:

- Jacobo Monsalve Guzmán <jmonsalve@eafit.edu.co>
