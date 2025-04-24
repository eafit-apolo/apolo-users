.. _hdf5-1.8.150p1-index:


Hdf5 1.8.15 Patch 1
===================

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.15-patch1/
- **License:**  GNU GENERAL PUBLIC LICENSE Version 2
- **Installed on:** Apolo II and Cronos
- **Installation date:** 13/02/2018

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * mpich2 v3.2.1
    * Zlib v1.2.11
    * Szip v2.1.1



Installation
------------

#. Load required modules.

   .. code-block:: bash

        module purge
        module load gcc/5.5.0
        module load mpich2/3.2.1_gcc-5.5.0
        module load szip/2.1.1_gcc-5.5.0
        module load zlib/1.2.11_gcc-5.5.0



#. Configure the following environment variables that specify the compilers to use:

    .. code-block:: bash

        $ export CC=mpicc
        $ export CXX=mpic++
        $ export FC=mpif90
        $ export F90=mpif90

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/hdf5/src/
        wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.15-patch1/src/hdf5-1.8.15-patch1.tar.gz
        tar -xvf hdf5-1.8.15-patch1.tar.gz


#. After unpacking HDF5, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd hdf5-1.8.15-patch1

        ./configure --prefix=/share/apps/hdf5/1.8.15-patch1/gcc-5.5.0_mpich2-3.2.1 --build=x86_64-redhat-linux --enable-fortran --enable-parallel --with-zlib=/share/apps/zlib/1.2.11/gcc-5.5.0 --with-szlib=/share/apps/szip/2.1.1/gcc-5.5.0

        make -j 10 2>&1 | tee hdf5-make.log
        make check 2>&1 | tee hdf5-make-check.log
        sudo mkdir -p /share/apps/hdf5/1.8.15-patch1/gcc-5.5.0_mpich2-3.2.1
        sudo chown -R mgomezzul.apolo /share/apps/hdf5/1.8.15-patch1/gcc-5.5.0_mpich2-3.2.1
        make install 2>&1 | tee hdf5-make-install.log
        sudo chown -R root.root /share/apps/hdf5/1.8.15-patch1/gcc-5.5.0_mpich2-3.2.1


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load hdf5/1.8.15-patch1_gcc-5.5.0_mpich2-3.2.1
        ##
        ## /share/apps/modules/hdf5/1.8.15-patch1_gcc-5.5.0_mpich2-3.2.1
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using HDF5-1.8.15-patch1\
                        \nin the shared directory /share/apps/hdf5/1.8.15-patch1/gcc-5.5.0_mpich2-3.2.1\
                        \nbuilded with gcc-5.5.0, mpich2-3.2.1, zlib-1.2.1, szip-2.1.1."
        }

        module-whatis "(Name________) hdf5"
        module-whatis "(Version_____) 1.8.15-patch1"
        module-whatis "(Compilers___) gcc-5.5.0_mpich2-3.2.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) szip-2.1.1, zlib-1.2.11"

        # for Tcl script use only
        set         topdir        /share/apps/hdf5/1.8.15-patch1/gcc-5.5.0_mpich2-3.2.1
        set         version       1.8.15-patch1
        set         sys           x86_64-redhat-linux

        conflict hdf5
        module load mpich2/3.2.1_gcc-5.5.0
        module load szip/2.1.1_gcc-5.5.0
        module load zlib/1.2.11_gcc-5.5.0

        setenv          HDF5                    $topdir

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include




Use
---

    .. code-block:: bash

        module load hdf5/1.8.15-patch1_gcc-5.5.0_mpich2-3.2.1


Resources
---------
    * https://support.hdfgroup.org/downloads/index.html


Author
------
   * Andrés Felipe Zapata Palacio
