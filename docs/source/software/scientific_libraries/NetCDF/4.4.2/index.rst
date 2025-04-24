.. _NetCDF-4.4.2-index:

NetCDF 4.4.2
============

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** https://www.unidata.ucar.edu/software/netcdf/
- **License:** Copyright University Corporation for Atmospheric Research/Unidata
- **Installed on:** Apolo II and Cronos
- **Installation date:** 13/02/2018

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * mpich2 v3.2.1
    * HDF5 v1.8.15-patch-1
    * PNetCDF/1.6.1
    * NetCDF-C/4.3.3


Installation
------------

.. note::

    netCDF-C must be installed before the nerCDF-Fortran installation proceedure.


#. Configure the following environment variables that specify the compilers to use:

    .. code-block:: bash

        export CC=mpicc
        export CXX=mpicxx
        export FC=mpif90
        export F77=mpif90
        export F90=mpif90
        NETCDF=
        MPICH2=
        export CPPFLAGS="-I$HDF5/include -I$NETCDF/include -I/export/apps/mpich2/3.2.1/gcc-5.5.0/include"
        export CFLAGS="-I$HDF5/include -I$NETCDF/include -I/export/apps/mpich2/3.2.1/gcc-5.5.0/include"
        export CXXFLAGS="-I$HDF5/include -I$NETCDF/include -I/export/apps/mpich2/3.2.1/gcc-5.5.0/include"
        export FCFLAGS="-I$HDF5/include -I$NETCDF/include -I/export/apps/mpich2/3.2.1/gcc-5.5.0/include"
        export FFLAGS="-I$HDF5/include -I$NETCDF/include -I/export/apps/mpich2/3.2.1/gcc-5.5.0/include"
        export LDFLAGS="-L$HDF5/lib -L$NETCDF/lib -L/export/apps/mpich2/3.2.1/gcc-5.5.0/lib"
        HDF5=
        NCDIR=


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/netcdf/src/
        wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.2.tar.gz
        tar -xvf netcdf-fortran-4.4.2.tar.gz

#. After unpacking NetCDF, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd netcdf-4.4.2

        ./configure --prefix=/share/apps/netcdf/4.3.3/gcc-5.5.0_mpich2-3.2.1 --build=x86_64-redhat-linux --enable-large-file-tests --enable-parallel-tests --enable-largefile

        make -j 10 2>&1 | tee netcdff-make.log
        make check 2>&1 | tee netcdff-make-check.log
        sudo mkdir -p /share/apps/netcdf/4.3.3/gcc-5.5.0_mpich2-3.2.1
        sudo chown -R mgomezzul.apolo /share/apps/netcdf/4.3.3/gcc-5.5.0_mpich2-3.2.1
        make install 2>&1 | tee netcdff-make-install.log
        sudo chown -R root.root /share/apps/netcdf/4.3.3/gcc-5.5.0_mpich2-3.2.1


#. Generate the module with the following environment variable:

    .. code-block:: bash

         setenv          PNET                    $topdir
         sudo moduleGenerator


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load netcdf/4.4.2_gcc-5.5.0_mpich2-3.2.1
        ##
        ## /share/apps/modules/netcdf/4.3.3_gcc-5.5.0_mpich2-3.2.1
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using netcdf-4.3.3\
                        \nin the shared directory /share/apps/netcdf/4.3.3/gcc-5.5.0_mpich2-3.2.1\
                        \nbuilded with gcc-5.5.0, mpich2-3.2.1, hdf5-1.8.15-patch1, pnetcdf/1.6.1."
        }

        module-whatis "(Name________) netcdf"
        module-whatis "(Version_____) 4.4.2"
        module-whatis "(Compilers___) gcc-5.5.0, mpich2-3.2.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) zlib-1.2.11, szip-2.1.1, hdf5-1.8.15-patch1, pnetcdf-1.6.1"

        # for Tcl script use only
        set         topdir        /share/apps/netcdf/4.3.3/gcc-5.5.0_mpich2-3.2.1
        set         version       4.4.2
        set         sys           x86_64-redhat-linux

        conflict netcdf
        module load mpich2/3.2.1_gcc-5.5.0
        module load hdf5/1.8.15-patch1_gcc-5.5.0_mpich2-3.2.1
        module load pnetcdf/1.6.1_gcc-5.5.0_mpich2-3.2.1

        setenv          NETCDF                  $topdir

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    PKG_CONFIG_PATH         $topdir/lib/pkgconfig

        prepend-path    MANPATH                 $topdir/share/man



Use
---
    .. code-block:: bash

        module load netcdf/4.4.2_gcc-5.5.0_mpich2-3.2.1

Resources
---------

 * ftp://ftp.unidata.ucar.edu/pub/netcdf/
 * https://www.unidata.ucar.edu/software/netcdf/docs/copyright.html


Author
------
 * Andrés Felipe Zapata Palacio
