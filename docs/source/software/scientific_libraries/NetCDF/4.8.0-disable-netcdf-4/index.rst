.. _NetCDF-4.8.0-disable-netcdf-4-index:

NetCDF 4.8.0 disable netcdf 4
=============================

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** https://www.unidata.ucar.edu/software/netcdf/
- **License:** Copyright University Corporation for Atmospheric Research/Unidata.
- **Installed on:** Apolo II
- **Installation date:** 03/03/2022

Tested on (Requirements)
------------------------

* **OS base:** Rocky Linux 8.5 (x86_64)
* **Dependencies:**
    * gcc v9.3.0
    * curl v.7.77.0
    * Mpich v.3.4.2
    * Zlib v.1.2.11


Installation
------------

#. Load required modules.

   .. code-block:: bash

        module load gcc/9.3.0
        module load curl/7.77.0_gcc-9.3.0
        module load mpich/3.4.2_gcc-9.3.0

#. Configure the following environment variables that specify the compilers to use:

    .. code-block:: bash

        export CC=mpicc
        export CXX=mpicxx
        export FC=mpif90
        export F77=mpif90
        export F90=mpif90

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/blopezp
        wget https://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.8.0.tar.gz
        tar -xvf netcdf-4.3.3.tar.gz

#. After unpacking NetCDF, continue with the following steps for configuration and compilation only WRF-CMAQ:

    .. code-block:: bash

        cd netcdf-c-4.8.0.tar.gz

        CPPFLAGS="-I/share/apps/curl/7.77.0/gcc-9.3.0/include" LDFLAGS="-L/share/apps/curl/7.77.0/gcc-9.3.0/lib" ./configure --prefix=/share/apps/netcdf/4.8.0/gcc-9.3.0 --disable-netcdf-4

        make -j 10 2>&1 | tee netcdf-make.log
        make check 2>&1 | tee netcdf-make-check.log
        sudo mkdir -p /share/apps/netcdf/4.8.0
        sudo make -j 10 install 2>&1 | tee netcdf-make-install.log


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load netcdf/4.8.0_gcc-9.3.0
        ##
        ## /share/apps/modules/netcdf/4.8.1_Intel_oneAPI_2022-update-1
        ## Written by Bryan Lopez Parra
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using netcdf 4.8.1\
                          \nin the shared directory \
                          \n/share/apps/netcdf/4.8.0/gcc-9.3.0 builded with\
                          \nGCC 9.3.0,\
                          \nzlib-1.2.11"
        }

        module-whatis "(Name________) netcdf"
        module-whatis "(Version_____) 4.8.0"
        module-whatis "(Compilers___) gcc-9.3.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) zlib-1.2.11"

        # for Tcl script use only
        set         topdir        /share/apps/netcdf/4.8.0/gcc-9.3.0
        set         version       4.8.0
        set         sys           x86_64-redhat-linux

        conflict netcdf

        module load curl/7.77.0_gcc-9.3.0



        #setenv                 NETCDF                  $topdir

        prepend-path    PATH                    $topdir/bin

        setenv          NCDIR                   $topdir

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

        module load zlib/1.2.11_gcc-9.3.0

Resources
---------

 * https://ftp.unidata.ucar.edu/pub/netcdf/
 * https://www.unidata.ucar.edu/software/netcdf/docs/copyright.html


:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
