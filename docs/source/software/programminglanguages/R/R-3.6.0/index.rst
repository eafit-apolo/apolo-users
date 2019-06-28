.. _R-3.6.0-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

R - 3.6.0
=========

Basic information
-----------------

- **Deploy date:** 28 June 2019
- **Official Website:** https://www.r-project.org/
- **License:** https://www.r-project.org/Licenses/
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`

Dependencies
------------
* zlib >= 1.2.5
* bzip2 >= 1.0.6 compiled with :code:`-fPIC` option
* xz (liblzma) REF https://tukaani.org/xz/
* PCRE >= 8.20 > 10.0 with UTF-8 support
* curl >= 7.22 with https support
* libicu-4.2.1-14.el6.x86_64 and libicu-devel-4.2.1-14.el6.x86_64
* BLAS and LAPACK (Optional) with OpenBlas or MKL
* JDK >= 1.7.0

Installation
------------
After the dependencies have been resolved and configured, the **R** installation can start.

.. note:: The Intel Compiler will be used to build R.

1. Download the selected version from an official mirror (https://cran.r-project.org/mirrors.html).

.. code-block:: bash

    $ wget https://cran.r-project.org/src/base/R-3/R-3.6.0.tar.gz
    $ tar -zxvf R-3.6.0.tar.gz

2. Load the corresponding modules to set the building environment.

.. note:: For BLAS and LAPACK is recommended to use Intel MKL (https://software.intel.com/en-us/articles/build-r-301-with-intel-c-compiler-and-intel-mkl-on-linux)

.. code-block:: bash

    $ module purge # Clean predefined environment
    $ module load zlib bzip2 xz pcre curl java mkl intel

3. Configure and build the sources.

.. code-block:: bash

    $ ./configure --prefix=/share/apps/r/3.6.0/intel-18.0.2/ --build=x86_64-redhat-linux --enable-R-shlib \
        --with-blas="-lmkl_rt -liomp5 -lpthread" --with-lapack --enable-BLAS-shlib --without-x --enable-memory-profiling \
         LDFLAGS="$LDFLAGS -qopenmp -L/share/apps/bzip2/1.0.6/gcc-5.5.0/lib/ -L/share/apps/pcre/8.41/gcc-5.5.0/lib/ \
         -L/share/apps/xz/5.2.3/gcc-5.5.0/lib/" CFLAGS="$CFLAGS -fPIC -qopenmp -O3 -ipo -xHost \
         -I/share/apps/bzip2/1.0.6/gcc-5.5.0/include/ -I/share/apps/pcre/8.41/gcc-5.5.0/include/ \
         -I/share/apps/xz/5.2.3/gcc-5.5.0/include" CXXFLAGS="$CXXFLAGS -fPIC -qopenmp -O3 -ipo -xHost \
         -I/share/apps/bzip2/1.0.6/gcc-5.5.0/include/ -I/share/apps/xz/5.2.3/gcc-5.5.0/include" \
         FFLAGS="$FFLAGS -fPIC -qopenmp -O3 -ipo -xHost" FCFLAGS="$FCFLAGS -fPIC -qopenmp -O3 -ipo -xHost"

    $ make -j10 && make install

Module
------

The following is the module used for this version.

.. code-block:: tcl

    #%Module1.0#####################################################################
    ##
    ## modules r/3.6.0_intel-18.0.2_mkl
    ##
    ## /share/apps/modules/r/3.6.0_intel-18.0.2_mkl  Written by Johan Yepes
    ##

    proc ModulesHelp { } {
        puts stderr "\tR/3.6.0_intel-18.0.2_mkl - sets the Environment for R in \
        \n\tthe share directory /share/apps/r/3.6.0/intel_mkl/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for R language \
                  \n\tbuilded with Intel Parallel Studio XE Cluster Edition 2018\
                  \n\t(Update-1) and Intel MKL 2018 (Update-2)  version\n"

    # for Tcl script use only
    set       topdir     /share/apps/r/3.6.0/intel-18.0.2
    set       version    3.6.0
    set       sys        x86_64-redhat-linux

    conflict r

    module load java/jdk-8_u152 mkl/18.0.2 intel/18.0.2

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


Authors
-------

- Johan Sebastián Yepes Ríos <jyepesr1@eafit.edu.co>
