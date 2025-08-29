.. _NetCDF-fortran-4.5.3_disable-netcdf-4-index:

NetCDF-Fortran 4.5.3 disable netcdf 4
=====================================

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** https://www.unidata.ucar.edu/downloads/netcdf/index.jsp
- **License:** MIT open source
- **Installed on:** Apolo II
- **Installation date:** 03/03/2022

Tested on (Requirements)
------------------------

* **OS base:** Rocky Linux 8.5 (x86_64)
* **Dependencies:**
    * gcc >= 9.3.0
    * curl >= 7.77.0
    * zlib >= 1.2.11
    * netcdf-c >= 4.8.0


Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/blopezp
        wget https://downloads.unidata.ucar.edu/netcdf-fortran/4.5.3/netcdf-fortran-4.5.3.tar.gz

#. After unpacking NetCDF, continue with the following steps for configuration and compilation only WRF-CMAQ:

    .. code-block:: bash

        $ cd netcdf-fortran
        $ module load gcc/9.3.0 netcdf/4.8.0_gcc-9.3.0_disable-netcdf-4 mpich/3.4.2_gcc-9.3.0
        $ CPPFLAGS="-I/share/apps/netcdf/4.8.0/gcc-9.3.0/include" LDFLAGS="-L/share/apps/netcdf/4.8.0/gcc-9.3.0/lib" ./configure --prefix=/share/apps/netcdf-fortran/4.5.3_disable-netcdf-4/gcc-9.3.0
        $ make 2>&1 | tee netcdf-make.log
        $ sudo mkdir -p /share/apps/netcdf-fortran/4.5.3_disable-netcdf-4
        $ sudo make install 2>&1 | tee netcdf-make-install.log


Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load netcdf-fortran/4.5.3_gcc-9.3.0_disable-netcdf-4
        ##
        ## /share/apps/netcdf-fortran/4.5.3_disable-netcdf-4/gcc-9.3.0
        ## Written by Bryan Lopez Parra
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using netcdf 4.5.3\
                          \nin the shared directory \
                          \n/share/apps/netcdf-fortran/4.5.3_disable-netcdf-4/gcc-9.3.0 builded with\
                          \nIntel gcc 9.3.0\"
        }

        module-whatis "(Name________) netcdf-fortran"
        module-whatis "(Version_____) 4.5.3"
        module-whatis "(Compilers___) gcc-9.3.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) zlib-1.2.11"

        # for Tcl script use only
        set         topdir        /share/apps/netcdf-fortran/4.5.3_disable-netcdf-4/gcc-9.3.0
        set         version       4.5.3
        set         sys           x86_64-redhat-linux

        conflict netcdf-fortran

        module load netcdf/4.8.0_gcc-9.3.0_disable-netcdf-4

        prepend-path    PATH                    $topdir/bin

        setenv          NETCDF                  $topdir
        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    PKG_CONFIG_PATH         $topdir/lib/pkgconfig

        prepend-path    MANPATH                 $topdir/share/man



Mode Of Use
-----------

.. code-block:: bash

    module load netcdf-fortran/4.5.3_gcc-9.3.0_disable-netcdf-4

Resources
---------

    * https://www.unidata.ucar.edu/downloads/netcdf/index.jsp


:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
