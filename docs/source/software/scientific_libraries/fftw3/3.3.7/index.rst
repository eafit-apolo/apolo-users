.. _fftw3-3.3.7-index:


FFTW 3.3.7
==========

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** http://www.fftw.org/
- **License:** GNU GENERAL PUBLIC LICENSE Version 2
- **Installed on:** Apolo II and Cronos
- **Installation date:** 10/11/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Compiler >= 2017_update-1
    * Gnu GCC >= 5.5.0
    * Mpich2 >= 3.2.1



Installation
------------

Apolo
~~~~~

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        $ cd /home/mgomezzul/apps/fftw/3/intel
        $ wget http://www.fftw.org/fftw-3.3.7.tar.gz
        $ tar xf fftw-3.3.7.tar.gz


#. After unpacking fftw3, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ module unload impi/2017_update-1
        $ module load intel/2017_update-1
        $ module unload slurm
        $ cd fftw-3.3.7
        $ ./configure --prefix=/share/apps/fftw/3.3.7/intel-17.0.1 --build=x86_64-redhat-linux --enable-shared -enable-static -enable-sse2 --enable-avx --enable-avx2 --enable-openmp --enable-threads # Without Floating-point Precision
        $ make clean
        $ ./configure --prefix=/share/apps/fftw/3.3.7/intel-17.0.1 --build=x86_64-redhat-linux --enable-shared -enable-static -enable-sse2 --enable-avx --enable-avx2 --enable-openmp --enable-threads --enable-float # With Floating-point Precision
        $ make -j 16
        $ make check
        $ sudo mkdir -p /share/apps/fftw/3.3.7/intel-17.0.1
        $ sudo chown -R mgomezzul.apolo /share/apps/fftw/3.3.7/intel-17.0.1
        $ make install


Cronos
~~~~~~

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        $ cd /home/mgomezzul/apps/fftw/3/intel
        $ wget http://www.fftw.org/fftw-3.3.7.tar.gz
        $ tar xf fftw-3.3.7.tar.gz


#. After unpacking fftw3, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ module purge
        $ module load mpich2/3.2.1_gcc-5.5.0
        $ /home/mgomezzul/apps/fftw/src/gcc-5.5.0_mpich2-3.2.1
        $ wget http://www.fftw.org/fftw-3.3.7.tar.gz
        $ tar xf fftw-3.3.7.tar.gz
        $ cd fftw-3.3.7
        $ sudo mkdir -p /share/apps/fftw/3.3.7/gcc-5.5.0_mpich2-3.2.1
        $ sudo chown -R mgomezzul.apolo /share/apps/fftw/3.3.7/gcc-5.5.0_mpich2-3.2.1


    Version: parallel, threads and double precision floating point

        .. code-block:: bash

            $ ./configure --prefix=/share/apps/fftw/3.3.7/gcc-5.5.0_mpich2-3.2.1 --build=x86_64-redhat-linux --enable-shared --enable-static --enable-threads --enable-openmp --enable-mpi --enable-sse2 --enable-avx 2>&1 | tee fftw3-conf.log
            $ make -j 16 2>&1 | tee fftw3-make.log
            $ make -j 16 check 2>&1 | tee fftw3-make-check.log
            $ make install 2>&1 | tee fftw3-make-install.log

    Version: parallel, "threads" and simple floating point precision

        .. note::

            The idea is to produce the single and double precision version and install them in the same place as the names of the resulting files are different, making it easier for the user to use them.


        .. code-block:: bash

            $ make clean
            $ ./configure --prefix=/share/apps/fftw/3.3.7/gcc-5.5.0_mpich2-3.2.1 --build=x86_64-redhat-linux --enable-shared --enable-static --enable-threads --enable-openmp --enable-mpi --enable-sse2 --enable-avx  --enable-single 2>&1 | tee fftw3-conf.log
            $ make -j 16 2>&1 | tee fftw3-make.log
            $ make -j 16 check 2>&1 | tee fftw3-make-check.log
            $ make install 2>&1 | tee fftw3-make-install.log
            $ sudo chown -R root.root /share/apps/fftw/3.3.7/gcc-5.5.0_mpich2-3.2.1






Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load fftw/3.3.7_intel-17.0.1
        ##
        ## /share/apps/modules/fftw/3.3.7_intel-17.0.1
        ## Written by Mateo G
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using fftw 3.3.7\
                        \nin the shared directory \
                        \n/share/apps/fftw/3.3.7/intel-17.0.1\
                        \nbuilded with gcc-5.4.0"
        }

        module-whatis "(Name________) fftw"
        module-whatis "(Version_____) 3.3.7"
        module-whatis "(Compilers___) intel-17.0.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/fftw/3.3.7/intel-17.0.1
        set         version       3.3.7
        set         sys           x86_64-redhat-linux

        conflict fftw
        module load intel/2017_update-1


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
    TO-DO

Resources
---------
* http://www.fftw.org/fftw3_doc/


Author
------
    * Mateo Gómez Zuluaga
    * Juan Pablo Alcaraz Flórez
