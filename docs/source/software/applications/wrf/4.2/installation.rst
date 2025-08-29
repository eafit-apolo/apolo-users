.. _wrf-4.2-installation:

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents

   .. contents::
      :depth: 2
      :local:


WRF 4.2 Installation
====================

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux (x86_64) :math:`\boldsymbol{\ge}` 8.5
- **Compiler:** GCC 9.3.0
- **Requirements:**

  * gcc 9.3.0

  * curl 7.77.0 with gcc 9.3.0

  * MPICH 3.4.2 with gcc 9.3.0

  * zlib 1.2.12 with gcc 9.3.0

  * hdf5 1.12.0 with gcc 9.3.0

  * NetCDF-C 4.7.4 with gcc 9.3.0

  * NetCDF-Fortran 4.5.3 with gcc 9.3.0

  * JasPer 1.900.29 with gcc 9.3.0

  * libpng 1.6.37 with gcc 9.3.0

  * jpeg 9e with gcc 9.3.0

Installation
------------

This entry covers the entire process performed for the installation and
configuration of all WRF 4.2 dependencies on a cluster with an GCC compiler. **FOLLOW THE ORDER**

Distributed Memory Installation
-------------------------------
This is the installation for the distributed memory option that WRF has, please follow it exactly as it is.

   .. code-block:: bash

      module load gcc/9.3.0
      module load curl/7.77.0_gcc-9.3.0
      module load mpich/3.4.2_gcc-9.3.0


Create directory for libraries
------------------------------
To install the libraries you must do it all in one place.

   .. code-block:: bash

      mkdir wrf_install_gcc
      mkdir wrf_lib_gcc

Download libraries
------------------

   .. code-block:: bash

      cd wrf_install_gcc
      wget https://www.zlib.net/fossils/zlib-1.2.11.tar.gz
      tar -zxvf zlib-1.2.11.tar.gz
      wget https://onboardcloud.dl.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.gz
      tar -zxvf libpng-1.6.37.tar.gz
      wget https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_0/source/hdf5-1.12.0.tar.gz
      tar -zxvf hdf5-1.12.0.tar.gz
      wget https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.7.4.tar.gz
      tar -zxvf v4.7.4.tar.gz
      https://github.com/Unidata/netcdf-fortran/archive/refs/tags/v4.5.3.tar.gz
      tar -zxvf v4.5.3.tar.gz
      wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.29.tar.gz
      tar -zxvf jasper-1.900.29.tar.gz
      wget https://www.ijg.org/files/jpegsrc.v9e.tar.gz
      tar -zxvf jpegsrc.v9e.tar.gz

Build zlib
----------

   .. code-block:: bash

      cd zlib-1.2.11
      ./configure --prefix=/home/blopezp/wrf_lib_gcc
      make
      make install

Exports libraries
-----------------

   .. code-block:: bash

      export LD_LIBRARY_PATH=/home/blopezp/wrf_lib_gcc/lib:$LD_LIBRARY_PATH
      export LDFLAGS=-L/home/blopezp/wrf_lib_gcc/lib
      export CPPFLAGS=-I/home/blopezp/wrf_lib_gcc/include
      export LD_RUN_PATH=/home/blopezp/wrf_lib_gcc/lib:$LD_RUN_PATH
      export PATH=/home/blopezp/wrf_lib_gcc/bin:$PATH


Build libpng
------------

   .. code-block:: bash

      cd libpng-1.6.37
      ./configure --prefix=/home/blopezp/wrf_lib_gcc
      make
      make install


Build Jpeg
----------

   .. code-block:: bash

      ./configure --prefix=/home/wrf/wrf_libs_intel/
      make
      make install


Build HDF5
----------

   .. code-block:: bash

      cd hdf5-1.12.0
      ./configure --prefix=/home/blopezp/wrf_lib_gcc --with-zlib=/home/blopezp/wrf_lib_gcc/ --enable-fortran
      make
      make install


Build NetCDF-C
--------------

   .. code-block:: bash

      cd netcdf-c-4.7.4
      export HDF5=/home/blopezp/wrf_lib_gcc
      ./configure --prefix=/home/blopezp/wrf_lib_gcc
      make
      make install

Build NetCDF-Fortran
--------------------

   .. code-block:: bash

      cd netcdf-fortran-4.5.3
      ./configure --prefix=/home/blopezp/wrf_lib_gcc
      make
      make install

Build JasPer
------------

   .. code-block:: bash

      cd jasper-1.900.29
      ./configure --prefix=/home/wrf/wrf_libs_intel/
      make
      make install

.. warning::
    If there is a compilation error then following fix maybe implemented (Thanks to Lena Marie Müller):

       .. code-block:: bash

          sed -i 's/char *optstr/const char *optstr/g' src/libjasper/jpg/jpg_dummy.c


Distributed Memory Installation
-------------------------------
This is the installation for the distributed memory option that WRF has, please follow it exactly as it is.

#. Download the source code.

   .. code-block::

      mkdir WRF
      cd WRF
      wget https://github.com/wrf-model/WRF/archive/refs/tags/v4.2.tar.gz


#. Export the necessary modules

   .. code-block:: bash

      module load gcc/9.3.0 curl/7.77.0_gcc-9.3.0 mpich/3.4.2_gcc-9.3.0
      export LD_LIBRARY_PATH=/home/blopezp/wrf_lib_gcc/lib:$LD_LIBRARY_PATH
      export LDFLAGS=-L/home/blopezp/wrf_lib_gcc/lib
      export CPPFLAGS=-I/home/blopezp/wrf_lib_gcc/include
      export LD_RUN_PATH=/home/blopezp/wrf_lib_gcc/lib:$LD_RUN_PATH
      export NETCDF=/home/blopezp/wrf_lib_gcc
      export HDF5=/home/blopezp/wrf_lib_gcc
      export JASPERLIB=/home/blopezp/wrf_lib_gcc/lib
      export JASPERINC=/home/blopezp/wrf_lib_gcc/include
      export PATH=/home/blopezp/wrf_lib_gcc/bin:$PATH


#. Execute the configuration script, you will be asked two questions, choose ``34`` for the fist one (Enables distributed-memory processing with the GCC compiler), and ``1`` for the second one.

   .. code-block:: bash

      ./configure

#. Remove the "time" command from the following line in the configure.wrf file.


   .. code-block:: bash

      FC = time $(DM_FC)

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


Compile WPS 4.2 Serial
######################

The WRF Preprocessing System (WPS) [1]_ is a set of three programs whose collective
role is to prepare input to the real.exe program for real-data simulations.

#. Download the latest version of WSP

   .. code-block:: bash

      wget https://github.com/wrf-model/WPS/archive/refs/tags/v4.2.tar.gz
      tar -zxvf 4.2.tar.gz
      cd WPS-4.2

#. Load the correspondent modules and execute the configuration script, use the option ``1``.

   .. code-block:: bash

      export WRF_DIR=/home/blopezp/wrf_install_gcc/WRF-4.2
      ./configure

#. Edit the configuration file :bash:`configure.wps`

    In the section ``WRF_LIB =`` add after the following parameter ``-lnetcdf`` these parameters  ``-liomp5 -lpthread``

#. Compile it.

   .. code-block:: bash

      ./compile | tee wps-compilation.log




References
----------

.. [1] Mesoscale & Microscale Meteorology Laboratory. (n.d.). Chapter 3: WRF Preprocessing System. [online] Available at: http://www2.mmm.ucar.edu/wrf/users/docs/user_guide/users_guide_chap3.html [Accessed 28 Aug. 2019].
