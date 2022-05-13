.. _fftw3-3.3.10-index:


FFTW 3.3.10
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.fftw.org/
- **License:** GNU GENERAL PUBLIC LICENSE Version 2
- **Installed on:** Apolo II
- **Installation date:** 28/03/2022

Tested on (Requirements)
------------------------

* **OS base:** Rocky Linux 8.5 (x86_64)
* **Dependencies:**
    * GCC >= 11.2.0
    * OpenMPI >= 1.8.8
    * UCX >= 1.12.1



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget http://www.fftw.org/fftw-3.3.10.tar.gz
        $ tar -zxvf fftw-3.3.10.tar.gz


#. After unpacking fftw3, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd fftw-3.3.10
        $ module load openmpi/4.1.2_gcc-11.2.0
        $ ./configure --prefix=/share/apps/fftw/3.3.10/gcc-11.2.0 --build=x86_64-redhat-linux --enable-shared -enable-static -enable-sse2 --enable-avx --enable-avx2 --enable-openmp --enable-threads --enable-float
        $ make -j 16 |& tee make.log
        $ sudo mkdir -p /share/apps/fftw/3.3.10
        $ sudo make install 2>&1 | tee fftw-make-install.log

Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load fftw/3.3.10_gcc-11.2.0
        ##
        ## /share/apps/modules/fftw/3.3.7_intel-17.0.1
        ## Written by Bryan Lopez Parra
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using fftw 3.3.7\
                        \nin the shared directory \
                        \n/share/apps/fftw/3.3.7/intel-17.0.1\
                        \nbuilded with gcc-5.4.0"
        }

        module-whatis "(Name________) fftw"
        module-whatis "(Version_____) 3.3.10"
        module-whatis "(Compilers___) gcc-11.2.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/fftw/3.3.10/gcc-11.2.0
        set         version       3.3.10
        set         sys           x86_64-redhat-linux

        conflict fftw
        module load gcc/11.2.0
        module load openmpi/4.1.2_gcc-11.2.0


        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLLUDE_PATH       $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    PKG_CONFIG_PATH         $topdir/lib/pkgconfig

        prepend-path    MANPATH                 $topdir/share/man





Use
---
    $ module load fftw/3.3.10_gcc-11.2.0


Resources
---------
* http://www.fftw.org/fftw3_doc/


:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
