.. _wrf-4.1.1-installation:

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents

   .. contents::
      :depth: 2
      :local:


WRF 4.1.1 Installation
======================

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- **Compiler:** Intel :math:`\boldsymbol{\ge}` 19.0.4
- **Requirements:**

  * zlib :math:`\boldsymbol{\ge}` 1.2.11 with Intel 19.0.4

  * szip :math:`\boldsymbol{\ge}` 2.1.1 with Intel 19.0.4

  * hdf5 :math:`\boldsymbol{\ge}` 1.12 with Intel 19.0.4

  * NetCDF-C :math:`\boldsymbol{\ge}` 4.7.4 with Intel 19.0.4

  * NetCDF-Fortran :math:`\boldsymbol{\ge}` 4.5.3 with Intel 19.0.4

  * MPICH :math:`\boldsymbol{\ge}` 3.3.2 with Intel 19.0.4

  * JasPer :math:`\boldsymbol{\ge}` 1.900.1 with Intel 19.0.4


Make sure you have all the dependencies installed correctly. If you don't have them installed or think you have them installed correctly, please go to the following guide because your installation will most likely fail. :ref:`wrf-4.1.1-installation-dependencies`

Build process
-------------

#. Get the source code

   .. code-block:: bash

      wget https://github.com/wrf-model/WRF/archive/v4.1.1.tar.gz
      tar xvf v4.1.1.tar.gz
      cd WRF-4.1.1


Distributed Memory Installation
-------------------------------
This is the installation for the distributed memory option that WRF has, please follow it exactly as it is.

#. Load the necessary modules

   .. code-block:: bash

      module load intel/19.0.4
      module load szip/2.1.1_intel_19.0.4
      module load zlib/1.2.11_intel_19.0.4
      module load hdf5/1.12_intel-19.0.4
      module load netcdf/4.7.4_intel-19.0.4
      module load netcdf-fortran/4.5.3_intel-19.0.4
      module load mpich2/3.3.2_intel-19.0.4
      module load jasper/1.900.1_intel-19.0.4

#. Execute the configuration script, you will be asked two questions, choose ``16`` for the fist one (Enables distributed-memory processing with the Intel compiler), and ``1`` for the second one.

   .. code-block:: bash

      ./configure


#. Compile WRF, with the case you need, we recommend the case to be ``em_real``.

    .. code-block:: bash

       ./compile <case> | tee wrf-compilation.log

    In :bash:`main/` you should see the following executables:

    * If you compile a real case:

      .. code-block:: bash

         wrf.exe
         real.exe
         ndown.exe
         tc.exe

    * If you compile an idealized case

      .. code-block:: bash

         wrf.exe
         ideal.exe

Modulefile
##########

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load wrf/4.1.1_intel-19.0.4
        ##
        ## /share/apps/modules/wrf/4.1.1/intel-19.0.4
        ## Written by Tomas Navarro & Santiago Alzate
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using wrf-4.1.1\
                          \nin the shared directory /share/apps/wrf/4.1.1/intel-19.0.4/\
                          \nbuilded with intel-2017_update-1, netcdf-fortran-4.4.4,\
                  \nnetcdf-4.5.0, hdf5-1.8.19, jasper-1.900.1"
        }

        module-whatis "(Name________) wrf"
        module-whatis "(Version_____) 4.1.1"
        module-whatis "(Compilers___) intel-2019_update-4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/wrf/4.1.1/intel-19.0.4
        set         version       4.1.1
        set         sys           x86_64-redhat-linux

        module load intel/19.0.4
        module load hdf5/1.12_intel-19.0.4
        module load netcdf/4.7.4_intel-19.0.4
        module load netcdf-fortran/4.5.3_intel-19.0.4
        module load mpich2/3.3.2_intel-19.0.4
        module load jasper/1.900.1_intel-19.0.4
        module load wps/4.1_intel-19.0.4

        setenv       WRFIO_NCD_LARGE_FILE_SUPPORT   1

        setenv       WRF_DIR                        $topdir

        prepend-path PATH               $topdir/main


Compile WPS 4.1 Distributed
###########################

The WRF Preprocessing System (WPS) [1]_ is a set of three programs whose collective
role is to prepare input to the real.exe program for real-data simulations.

#. Download the latest version of WSP

   .. code-block:: bash

      wget https://github.com/wrf-model/WPS/archive/v4.1.tar.gz
      tar xvf 4.1.tar.gz
      cd WPS-4.1

#. Load the correspondent modules and execute the configuration script, use the option ``19``.

   .. code-block:: bash

      module load wrf/4.1.1_intel-19.0.4
      ./configure

#. Edit the configuration file :bash:`configure.wps`

    In the section ``WRF_LIB =`` add after the following parameter ``-lnetcdf`` these parameters  ``-liomp5 -lpthread``

#. Compile it.

   .. code-block:: bash

      ./compile | tee wps-compilation.log


Modulefile
##########

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load wps/4.1_intel-19.0.4
        ##
        ## /share/apps/modules/wps/4.1/intel-19.0.4
        ## Written by Tomas Navarro & Santiago Alzate
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using wps-4.1\
                          \nin the shared directory /share/apps/wps/4.1/intel-19.0.4/\
                          \nbuilded with intel-2019_update-4, wrf-4.1.1, netcdf-fortran-4.5.3,\
                  \nnetcdf-4.7.4, hdf5-1.12, jasper-1.900.1\n"
        }

        module-whatis "(Name________) wps"
        module-whatis "(Version_____) 4.1"
        module-whatis "(Compilers___) intel-2019_update-4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/wps/4.1/intel-19.0.4
        set         version       4.1
        set         sys           x86_64-redhat-linux

        module load intel/19.0.4
        module load jasper/1.900.1_intel-19.0.4

        prepend-path PATH               $topdir



Shared Memory Installation
--------------------------

This is the installation for the Shared-Memory/Serial option that WRF has, please follow it exactly as it is.

#. Load the necessary modules

   .. code-block:: bash

      module load intel/19.0.4
      module load szip/2.1.1_intel_19.0.4
      module load zlib/1.2.11_intel_19.0.4
      module load hdf5/1.12_intel-19.0.4
      module load netcdf/4.7.4_intel-19.0.4
      module load netcdf-fortran/4.5.3_intel-19.0.4
      module load jasper/1.900.1_intel-19.0.4

#. Execute the configuration script, you will be asked two questions, choose ``14`` for the fist one (Enables shared-memory processing with the Intel compiler), and ``1`` for the second one.

   .. code-block:: bash

      ./configure


#. Compile WRF, with the case you need, we recommend the case to be ``em_real``.

    .. code-block:: bash

       ./compile <case> | tee wrf-compilation.log

    In :bash:`main/` you should see the following executables:

    * If you compile a real case:

      .. code-block:: bash

         wrf.exe
         real.exe
         ndown.exe
         tc.exe

    * If you compile an idealized case

      .. code-block:: bash

         wrf.exe
         ideal.exe

Modulefile
##########

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load wrf/4.1.1_sm_intel-19.0.4
        ##
        ## /share/apps/modules/wrf/4.1.1/sm-intel-19.0.4
        ## Written by Tomas Navarro & Santiago Alzate
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using wrf-4.1.1\
                          \nin the shared directory /share/apps/wrf/4.1.1/sm-intel-19.0.4/\
                          \nbuilded with intel-2017_update-1, netcdf-fortran-4.4.4,\
                  \nnetcdf-4.5.0, hdf5-1.8.19, jasper-1.900.1"
        }

        module-whatis "(Name________) wrf"
        module-whatis "(Version_____) 4.1.1 Shared-Memory"
        module-whatis "(Compilers___) intel-2019_update-4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/wrf/4.1.1/sm-intel-19.0.4
        set         version       4.1.1
        set         sys           x86_64-redhat-linux

        module load intel/19.0.4
        module load hdf5/1.12_intel-19.0.4
        module load netcdf/4.7.4_intel-19.0.4
        module load netcdf-fortran/4.5.3_intel-19.0.4
        module load jasper/1.900.1_intel-19.0.4
        module load wps/4.1_sm_intel-19.0.4

        setenv       WRFIO_NCD_LARGE_FILE_SUPPORT   1

        setenv       WRF_DIR                        $topdir

        prepend-path PATH               $topdir/main



Compile WPS 4.1 Serial
######################

The WRF Preprocessing System (WPS) [1]_ is a set of three programs whose collective
role is to prepare input to the real.exe program for real-data simulations.

#. Download the latest version of WSP

   .. code-block:: bash

      wget https://github.com/wrf-model/WPS/archive/v4.1.tar.gz
      tar xvf 4.1.tar.gz
      cd WPS-4.1

#. Load the correspondent modules and execute the configuration script, use the option ``17``.

   .. code-block:: bash

      module load wrf/4.1.1_intel-19.0.4
      ./configure

#. Edit the configuration file :bash:`configure.wps`

    In the section ``WRF_LIB =`` add after the following parameter ``-lnetcdf`` these parameters  ``-liomp5 -lpthread``

#. Compile it.

   .. code-block:: bash

      ./compile | tee wps-compilation.log


Modulefile
##########

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load wps/4.1_sm_intel-19.0.4
        ##
        ## /share/apps/modules/wps/4.1/sm-intel-19.0.4
        ## Written by Tomas Navarro & Santiago Alzate
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using wps-4.1\
                          \nin the shared directory /share/apps/wps/4.1/sm-intel-19.0.4/\
                          \nbuilded with intel-2019_update-4, wrf-4.1.1, netcdf-fortran-4.5.3,\
                  \nnetcdf-4.7.4, hdf5-1.12, jasper-1.900.1\n"
        }

        module-whatis "(Name________) wps"
        module-whatis "(Version_____) 4.1 Serial"
        module-whatis "(Compilers___) intel-2019_update-4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/wps/4.1/sm-intel-19.0.4
        set         version       4.1
        set         sys           x86_64-redhat-linux

        module load intel/19.0.4
        module load jasper/1.900.1_intel-19.0.4

        prepend-path PATH               $topdir




References
----------

.. [1] Mesoscale & Microscale Meteorology Laboratory. (n.d.). Chapter 3: WRF Preprocessing System. [online] Available at: http://www2.mmm.ucar.edu/wrf/users/docs/user_guide/users_guide_chap3.html [Accessed 28 Aug. 2019].
