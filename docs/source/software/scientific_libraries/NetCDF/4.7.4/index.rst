.. _NetCDF-4.7.4-index:

NetCDF 4.7.4
============

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** https://www.unidata.ucar.edu/downloads/netcdf/index.jsp
- **License:** MIT open source
- **Installed on:** Apolo II
- **Installation date:** June 2020

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

        cd $HOME/apps/netCDF/intel
        git clone https://github.com/Unidata/netcdf-c.git

#. After unpacking NetCDF, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd netcdf-c
        $ module load hdf5/1.12_intel_19.0.4
        $ export LDFLAGS="-L/share/apps/hdf5/1.12/intel-19.0.4/lib"
        $ export CPPFLAGS="-I/share/apps/hdf5/1.12/intel-19.0.4/include"
        $ ./configure --prefix=/share/apps/netcdf/4.7.4/intel-19.0.4 --build=x86_64-redhat-linux --enable-largefile
        $ make 2>&1 | tee netcdf-make.log
        $ sudo mkdir -p /share/apps/netcdf/4.5.0/intel-17.0.1
        $ sudo make install 2>&1 | tee netcdf-make-install.log


Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load netcdf/4.7.4_intel-19.0.4
        ##
        ## /share/apps/modules/netcdf/4.7.4_intel-19.0.4
        ## Written by Tomas Navarro & Santiago Alzate
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using netcdf 4.7.4\
                          \nin the shared directory \
                          \n/share/apps/netcdf/4.7.4/intel-19.0.4 builded with\
                          \nIntel Paralle Studio XE 2019 Update 4 Cluster Edition,\
                          \nzlib-1.2.11, szip-2.1.1, hdf5-1.12"
        }

        module-whatis "(Name________) netcdf"
        module-whatis "(Version_____) 4.7.4"
        module-whatis "(Compilers___) intel-19.0.4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) szip-2.1,zlib-1.2.11"

        # for Tcl script use only
        set         topdir        /share/apps/netcdf/4.7.4/intel-19.0.4
        set         version       4.7.4
        set         sys           x86_64-redhat-linux

        conflict netcdf
        module load intel/19.0.4
        module load szip/2.1.1_intel_19.0.4
        module load zlib/1.2.11_intel_19.0.4
        module load hdf5/1.12_intel-19.0.4

        #setenv                 NETCDF                  $topdir

        prepend-path    PATH                    $topdir/bin

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

    module load netcdf/4.7.4_intel-19.0.4

Resources
---------

    * https://www.unidata.ucar.edu/downloads/netcdf/index.jsp

Author
------
 * Tomas David Navarro
 * Santiago Alzate Cardona
