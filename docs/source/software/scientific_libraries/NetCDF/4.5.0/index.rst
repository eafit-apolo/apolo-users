.. _NetCDF-4.5.0-index:

NetCDF 4.5.0
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
    * hdf5 >= 1.8.19
    * zlib >= 1.2.11
    * szip >= 2.1



Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/netCDF/intel
        wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.5.0.tar.gz
        tar -xvf netcdf-4.5.0.tar.gz

#. After unpacking NetCDF, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd netcdf-c-4.5.0
        module unload slurm
        module load hdf5/1.8.19_intel-2017_update-1
        ./configure --prefix=/share/apps/netcdf/4.5.0/intel-17.0.1 --build=x86_64-redhat-linux 2>&1 | tee netcdf-conf.log
        make 2>&1 | tee netcdf-make.log
        sudo mkdir -p /share/apps/netcdf/4.5.0/intel-17.0.1
        sudo chown -R mgomezzul.apolo /share/apps/netcdf/4.5.0/intel-17.0.1
        make install 2>&1 | tee netcdf-make-install.log
        sudo chown -R root.root /share/apps/netcdf/4.5.0/intel-17.0.1


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load netcdf/4.5.0_intel-17.0.1
        ##
        ## /share/apps/modules/netcdf/4.5.0_intel-17.0.1
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using netcdf 4.5.0\
                \nin the shared directory \
                \n/share/apps/netcdf/4.5.0/intel-17.0.1 builded with\
                \nIntel Paralle Studio XE 2017 Update 1 Cluster Edition,\
                \nzlib-1.2.11, szip-2.1, hdf5-1.8.19 and libtools-2.4.6."
        }

        module-whatis "(Name________) netcdf"
        module-whatis "(Version_____) 4.5.0"
        module-whatis "(Compilers___) intel-17.0.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) libtools-2.4.6,szip-2.1,zlib-1.2.11"

        # for Tcl script use only
        set         topdir        /share/apps/netcdf/4.5.0/intel-17.0.1
        set         version       4.5.0
        set         sys           x86_64-redhat-linux

        conflict netcdf
        module load intel/2017_update-1
        module load szip/2.1_intel-2017_update-1
        module load zlib/1.2.11_intel-2017_update-1
        module load libtool/2.4.6_intel-17.0.1
        module load hdf5/1.8.19_intel-2017_update-1

        prepend-path	PATH			$topdir/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib

        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLUDE_PATH	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include

        prepend-path	PKG_CONFIG_PATH		$topdir/lib/pkgconfig

        prepend-path	MANPATH			$topdir/share/man



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
