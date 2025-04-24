.. _wps-3.7.1-index:

.. role:: bash(code)
   :language: bash

WPS 3.7.1
=========

.. contents:: Table of Contents

Basic information
-----------------
- **Implementation Date:** 19/20/2018
- **URL:** https://www.mmm.ucar.edu/weather-research-and-forecasting-model
- **License:** Public domain license, more info in application README
- **Installed on:** Apolo II and Cronos

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies to run WPS:**
    * WRF 3.7.1
    * jasper 1.900.1

Installation
------------

The following procedure is the easiest way to install Wps v3.7.1 in a cluster.

#. A WPS module must be created to add the dependencies to the environment:

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load wps/3.7.1_intel-2017_update-1
        ##
        ## /share/apps/modules/wps/3.7.1_intel-2017_update-1
        ## Written by Alejandro Salgado-Gómez
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using wps-3.7.1\
                \nin the shared directory /share/apps/wps/3.7.1/intel-2017_update-1/\
                \nbuilded with intel-2017_update-1, wrf-3.7.1, netcdf-fortran-4.4.3,\
                \nnetcdf-4.4.0, hdf5-1.8.16, jasper-1.900.1\n"
        }

        module-whatis "(Name________) wps"
        module-whatis "(Version_____) 3.7.1"
        module-whatis "(Compilers___) intel-2017_update-1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/wps/3.7.1/intel-2017_update-1
        set         version       3.7.1
        set         sys           x86_64-redhat-linux

        module load intel/2017_update-1
        module load jasper/1.900.1_intel-2017_update-1

#. Descargar la versión deseada del software (Source code - tar.gz) [1]_

    .. code-block:: bash

        cd /home/asalgad2/wps
        wget http://www2.mmm.ucar.edu/wrf/src/WPSV3.7.1.TAR.gz
        tar -xvf WPSV3.7.1.TAR.gz

#. After decompressing WPS, we continue with the following steps for its configuration and compilation:

    .. code-block:: bash

        cd WPS

#. The necessary environment modules are loaded:

    .. code-block:: bash

        module load wps/3.7.1_<compilador>

#. We launch the configuration

    .. code-block:: bash

        ./configure

- The necessary environment modules are loaded:

#. Edit the configuration file (configure.wps) to enable the use of large files:

- Change the WRF_DIR variable to the location

    .. code-block:: bash

        WRF_DIR = /share/apps/wrf/3.7.1/intel-2017_update-1/

- Depending on the compiler version, the parameter -f90 = ifort must be removed from the following line

    .. code-block:: bash

        DM_FC = mpif90 -f90=ifort

#. Now if we can start with the Wps compilation:

    .. code-block:: bash

        ./compile | tee wps-compilation.log
        sudo mkdir -p /share/apps/wps/3.7.1/<compilador usado>
        sudo cp -r * /share/apps/wps/3.7.1/<compilador usado>

Mode of Use
-----------

- **NOTE:** Before starting it is necessary to load the WRF module if it exists, otherwise load its dependencies.

    .. code-block:: bash

        module load wrf/3.7.1_gcc-5.4.0

Geogrid
~~~~~~~

**Objective:** Generate the files 'geo_em.dxx.nc' as output, where xx represents the domain number. [2]_

#. Position yourself in the directory where you want to generate the output files, in our case it will be in the same directory of the geogrid.exe binary

    .. code-block:: bash

        cd WPS/gcc-5.4.0/

#. Edit the **geog_data_path** field in the **namelist.wps** file located in the WPSV3 directory to specify the location of the input files referring to the Terrain, usually located in a folder called **wrfhelp/WPS_GEOG**

    .. code-block:: bash

         geog_data_path = '/path/to/data/wrfhelp/WPS_GEOG'

#. Run Geogrid

    .. code-block:: bash

        ./geogrid.exe

Ungrib
~~~~~~

**Objective:** From GRIB files, generate files with an intermediate format that will then be processed by **Metgrid** [3]_

#. Execute the **link_grib.csh** script specifying as the only parameter the location of the input GRIB files

    .. code-block:: bash

         ./link_grib.csh /path/to/grib/files/

#. Create in the directory where the executable **ungrib.exe** is located a file called Vtable based on the desired file, either by copying it or by making a symbolic link.

    .. code-block:: bash

        ln -sf ./ungrib/Variable_Tables/VtableDeseada Vtable

#. Run ungrib.exe

    .. code-block:: bash

        ./ungrib.exe

Metgrid
~~~~~~~

**Objective:** Generate the files **met_em.d01.YYYY-MM-DD_HH:00:00.nc** and **met_em.dxx.YYYY-MM-DD_HH:00:00.nc**, which are necessary to use WRF.

#. Once the **Geogrid** and **Ungrib** files are generated in the root directory of the WPS binaries, run **Metgrid.**

    .. code-block:: bash

        ./metgrid

References
----------

.. [1] **Download link:** http://www2.mmm.ucar.edu/wrf/users/download/get_sources.html
.. [2] **Reference page:** http://www2.mmm.ucar.edu/wrf/OnLineTutorial/Basics/GEOGRID/index.html
.. [3] **Procedure based on official documentation:** http://www2.mmm.ucar.edu/wrf/OnLineTutorial/Basics/UNGRIB/

Authors
-------
- Alejandro Salgado-Gómez
- Andrés Felipe Zapata Palacio
