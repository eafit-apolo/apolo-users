.. role:: bash(code)
    :language: bash
 
.. sidebar:: Contents
 
   .. contents::
      :depth: 2
      :local:
 
 
WRF 4.7.1 Installation
====================
 
Requirements
------------------------
 
- **OS base:** Rocky Linux (x86_64) :math:`\boldsymbol{\ge}` 8.5
- **Compiler:** GCC 11.2.0
- **Requirements:**
 
  * gcc 11.22.0
 
  * curl 7.77.0
 
  * openmpi 4.1.2
 
  * compiler 2022.0.2
 
  * zlib 1.2.12
 
  * hdf5 1.12.0
 
  * NetCDF-C 4.7.4
 
  * NetCDF-Fortran 4.5.3
 
  * JasPer 1.900.29
 
  * libpng 1.6.37
 
  * jpeg 9e
 
Installation
------------
 
Dowloading source code
-------------------------------
   .. code-block:: bash
        git clone --recurse-submodules https://github.com/wrf-model/WRF
 
Module loading
-------------------------------
 
   .. code-block:: bash
 
      module load compiler/2022.0.2
      module load openmpi/4.1.2_gcc-11.2.0
      module load gcc/11.2.0
      module load curl
 
 
Create directory for libraries
------------------------------
To install the libraries you must do it all in one place.
 
   .. code-block:: bash
 
      export DIR=$PWD
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
      wget https://github.com/Unidata/netcdf-fortran/archive/refs/tags/v4.5.3.tar.gz
      tar -zxvf v4.5.3.tar.gz
      wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.29.tar.gz
      tar -zxvf jasper-1.900.29.tar.gz
      wget https://www.ijg.org/files/jpegsrc.v9e.tar.gz
      tar -zxvf jpegsrc.v9e.tar.gz
      rm -rf *.tar.gz
 
Build zlib
----------
 
   .. code-block:: bash
 
      cd zlib-1.2.11
      ./configure --prefix=$DIR/wrf_lib_gcc
      make
      make install
 
Exports libraries
-----------------
 
   .. code-block:: bash
 
      export LD_LIBRARY_PATH=$DIR/wrf_lib_gcc/lib:$LD_LIBRARY_PATH
      export LDFLAGS=-L$DIR/wrf_lib_gcc/lib
      export CPPFLAGS=-I$DIR/wrf_lib_gcc/include
      export LD_RUN_PATH=$DIR/wrf_lib_gcc/lib:$LD_RUN_PATH
      export PATH=$DIR/wrf_lib_gcc/bin:$PATH
 
 
Build libpng
------------
 
   .. code-block:: bash
 
      cd ..
      cd libpng-1.6.37
      ./configure --prefix=$DIR/wrf_lib_gcc
      make
      make install
 
 
Build Jpeg
----------
 
   .. code-block:: bash
 
      cd ..
      cd jpeg-9e/
      ./configure --prefi=$DIR/wrf_libs_intel/
      make
      make install
 
 
Build HDF5
----------
 
   .. code-block:: bash
 
      cd ..
      cd hdf5-1.12.0
      ./configure --prefix=$DIR/wrf_lib_gcc --with-zlib=$DIR/wrf_lib_gcc/ --enable-fortran
      make
      make install
 
 
Build NetCDF-C
--------------
 
   .. code-block:: bash
 
      cd ..
      cd netcdf-c-4.7.4
      export HDF5=$DIR/wrf_lib_gcc
      ./configure --prefix=$DIR/wrf_lib_gcc
      make
      make install
 
Build NetCDF-Fortran
--------------------
 
   .. code-block:: bash
 
      cd ..
      cd netcdf-fortran-4.5.3
      ./configure --prefix=$DIR/wrf_lib_gcc
      make
      make install
 
Build JasPer
------------
 
   .. code-block:: bash
 
      cd ..
      sed -i 's/char \*optstr/const char *optstr/g' src/libjasper/jpg/jpg_dummy.c
      cd jasper-1.900.29
      ./configure --prefix=$DIR/wrf_lib_gcc
      make
      make install
 
Distributed Memory Installation
-------------------------------
Restart the environment you can do this by simply exiting and reentering the terminal
 
#. Export the necessary modules and variables, set the $DIR variable again exactly as you did.
 
   .. code-block:: bash
 
      module load compiler/2022.0.2
      module load openmpi/4.1.2_gcc-11.2.0
      module load gcc/11.2.0
      module load curl
 
      export LD_LIBRARY_PATH=$DIR/wrf_lib_gcc/lib:$LD_LIBRARY_PATH
      export LDFLAGS=-L$DIR/wrf_lib_gcc/lib
      export CPPFLAGS=-I$DIR/wrf_lib_gcc/include
      export LD_RUN_PATH=$DIR/wrf_lib_gcc/lib:$LD_RUN_PATH
      export NETCDF=$DIR/wrf_lib_gcc
      export HDF5=$DIR/wrf_lib_gcc
      export JASPERLIB=$DIR/wrf_lib_gcc/lib
      export JASPERINC=$DIR/wrf_lib_gcc/include
      export PATH=$DIR/wrf_lib_gcc/bin:$PATH
 
 
#. Execute the configuration script inside the WRF folder, you will be asked two questions, choose ``34`` for the fist one (Enables distributed-memory processing with the GCC compiler), and ``1`` for the second one.
 
   .. code-block:: bash
 
      ./configure
 
#. Remove the "time" command from the following line in the configure.wrf file.
 
 
   .. code-block:: bash
      
      FC = time $(DM_FC)
 
      #You must leave it like this, save and exit
      FC = $(DM_FC)
 
#. Compile WRF, with the case you need, we recommend the case to be ``em_real``.
 
    .. code-block:: bash
 
       ./compile <case> >& compile.log &
 
       tail -f compile.log #to see the progress
 
    If the compilation was succesfull you should see the following executables in :bash:`main/`:
 
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
 
References
----------
 
.. [1] Mesoscale & Microscale Meteorology Laboratory. (n.d.). Chapter 3: WRF Preprocessing System. [online] Available at: http://www2.mmm.ucar.edu/wrf/users/docs/user_guide/users_guide_chap3.html [Accessed 28 Aug. 2019].
   [2] https://apolo-docs.readthedocs.io/en/latest/software/applications/wrf/4.2/installation.html
   [3] https://www2.mmm.ucar.edu/wrf/users/wrf_users_guide/build/html/compiling.html
root@c2dafa11db05:/app/apolo-users/docs/source/software/applications/wrf/4.7.1# 

