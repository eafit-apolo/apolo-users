.. _NetCDF-4.4.4-index:

NetCDF 4.4.4
============

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** https://www.unidata.ucar.edu/downloads/netcdf/index.jsp
- **License:** MIT open source
- **Installed on:** Apolo II and Cronos
- **Installation date:** 14/11/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Parallel Studio XE Cluster Edition >= 17.0.1
    * netCDF-C >= 4.5.0
    * hdf5 >= 1.8.19
    * zlib >= 1.2.11
    * szip >= 2.1



Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/netCDF-Fortran/intel/
        wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.4.tar.gz
        tar -xvf netcdf-fortran-4.4.4.tar.gz


#. After unpacking NetCDF, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd netcdf-fortran-4.4.4
        module unload slurm
        module load netcdf/4.5.0_intel-17.0.1
        ./configure --prefix=/share/apps/netcdf-fortran/4.4.4/intel-2017_update-1 --build=x86_64-redhat-linux 2>&1 | tee netcdf-fortran-conf.log
        make 2>&1 | tee netcdf-fortran-make.log
        sudo mkdir -p /share/apps/netcdf-fortran/4.4.4/intel-2017_update-1
        sudo chown -R mgomezzul.apolo /share/apps/netcdf-fortran/4.4.4/intel-2017_update-1
        make install 2>&1 | tee netcdf-make-install.log
        sudo chown -R root.root /share/apps/netcdf-fortran/4.4.4/intel-2017_update-1



Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module netcdf-fortran/4.4.4_intel-2017_update-1
        ##
        ## /share/apps/netcdf-fortran/4.4.4/intel-2017_update-1     Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tnetcdf-fortran/4.4.4 - sets the Environment for ZLIB in \
            \n\tthe share directory /share/apps/netcdf-fortran/4.4.4/intel-2017_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using NetCDF-Fortran 4.4.4 \
                    \n\tbuilded with Intel Parallel Studio XE 2017\n"

        # for Tcl script use only
        set       topdir     /share/apps/netcdf-fortran/4.4.4/intel-2017_update-1
        set       version    4.4.4
        set       sys        x86_64-redhat-linux

        module load netcdf/4.5.0_intel-17.0.1

        prepend-path PATH		$topdir/bin

        prepend-path LD_LIBRARY_PATH    $topdir/lib
        prepend-path LIBRARY_PATH       $topdir/lib
        prepend-path LD_RUN_PATH        $topdir/lib

        prepend-path C_INCLUDE_PATH     $topdir/include
        prepend-path CXX_INCLUDE_PATH   $topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include
        prepend-path INCLUDE		$topdir/include

        prepend-path PKG_CONFIG_PATH    $topdir/lib/pkgconfig

        prepend-path MANPATH 		$topdir/share/man



Use
---
    TO-DO

Resources
---------

    * https://www.unidata.ucar.edu/downloads/netcdf/index.jsp
    * http://www.unidata.ucar.edu/software/netcdf/docs/getting_and_building_netcdf.html


Author
------
 * Mateo Gómez Zuluaga
