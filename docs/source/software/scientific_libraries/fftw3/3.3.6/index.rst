.. _fftw3-3.3.6-index:


FFTW 3.3.6
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.fftw.org/
- **License:** GNU GENERAL PUBLIC LICENSE Version 2
- **Installed on:** Apolo II and Cronos
- **Installation date:** 21/03/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GCC >= 5.4.0
    * OpenMPI >= 1.8.8



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/fftw/3/gcc/5.4.0
        wget ftp://ftp.fftw.org/pub/fftw/fftw-3.3.6-pl2.tar.gz
        tar -zxvf fftw-3.3.6-pl2.tar.gz


#. After unpacking fftw3, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd fftw-3.3.6-pl2
        module load openmpi/1.8.8_gcc-5.4.0
        module unload slurm
        ./configure --prefix=/share/apps/fftw/3.3.6/gcc-5.4.0_openmpi-1.8.8 --build=x86_64-redhat-linux --enable-shared --enable-static --enable-threads --enable-openmp --enable-mpi --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-avx-128-fma --with-gnu-ld 2>&1 | tee fftw-conf.log
        echo Ignore warning of OpenGL not found
        make 2>&1 | tee fftw-make.log
        sudo mkdir -p /share/apps/fftw/3.3.6/gcc-5.4.0_openmpi-1.8.8
        sudo chown -R mgomezzul.apolo /share/apps/fftw/3.3.6/gcc-5.4.0_openmpi-1.8.8
        make install 2>&1 | tee fftw-make-install.log
        sudo chown -R root.root /share/apps/fftw/3.3.6/gcc-5.4.0_openmpi-1.8.8


Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module fftw/3.3.6_gcc-5.4.0_openmpi-1.8.8
        ##
        ## /share/apps/modules/fftw/3.3.6_gcc-5.4.0_openmpi-1.8.8 Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            global version
            puts stderr "\tSets the environment for FFTW-$version in the next \
                    \n\tthe shared directory /share/apps/fftw/3.3.6/gcc_5.4.0_openmpi-1.8.8\n"
        }

        module-whatis "\n\n\tSets the environment for using FFTW3 \
                    \n\t(library for computing the discrete Fourier transform)  \
                    \n\tbuilded with gcc-5.4.0 and openmpi-1.8.8"

        # for Tcl script use only
        set     topdir          /share/apps/fftw/3.3.6/gcc-5.4.0_openmpi-1.8.8
        set     version         3.3.6
        set     sys             x86_64-redhat-linux

        module load gcc/5.4.0
        module load openmpi/1.8.8_gcc-5.4.0

        prepend-path    PATH                    $topdir/bin

        prepend-path 	C_INCLUDE_PATH     	$topdir/include
        prepend-path 	CXX_INCLUDE_PATH	$topdir/include
        prepend-path 	CPLUS_INCLUDE_PATH	$topdir/include

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    INFOPATH                $topdir/share/info
        prepend-path    MANPATH                 $topdir/share/man

        prepend-path	PKG_CONFIG_PATH		$topdir/lib/pkgconfig




Use
---
    TO-DO


Resources
---------
* http://www.fftw.org/fftw3_doc/


Author
------
    * Mateo Gómez Zuluaga
