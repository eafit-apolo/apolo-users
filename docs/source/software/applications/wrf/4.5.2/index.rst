.. _wrf-4.5.2-index:

.. role:: bash(code)
   :language: bash

WRF-Chem 4.5.2 (Apolo 3)
========================

.. contents:: Table of Contents

Basic Information
-----------------

- **Deploy date:** 03/2026
- **Official Website:** https://www.mmm.ucar.edu/weather-research-and-forecasting-model
- **Installation path:** ``/opt/ohpc/pub/apps/WRF/wrf-chem/v4.5.2``
- **Installed on:** Apolo 3

Module
------

The production module for this version is:

.. code-block:: bash

   module use /opt/ohpc/pub/moduledeps/gnu14-openmpi5
   module load wrf-chem/4.5.2

Module dependencies configured in Apolo 3:

.. code-block:: bash

   gnu14/14.2.0
   openmpi5/5.0.7
   phdf5/1.14.6
   netcdf/4.9.3
   netcdf-fortran/4.6.2
   zlib/1.2.11
   flex/2.6.4
   bison/3.8.2

Environment variables exported by the module:

.. code-block:: bash

   WRF_DIR=/opt/ohpc/pub/apps/WRF/wrf-chem/v4.5.2
   WRF_CHEM=1
   WRF_KPP=1

High-level Build Process
------------------------

This section summarizes the process used to build and deploy WRF-Chem 4.5.2 on Apolo 3.

1. Load compiler and MPI toolchain:

   .. code-block:: bash

      module load gnu14/14.2.0
      module load openmpi5/5.0.7

2. Configure NetCDF and GRIB-related environment variables (NetCDF-C, NetCDF-Fortran, JasPer/libpng stack).
3. Build or validate required dependencies (zlib, libpng, jasper, flex, bison).
4. Configure WRF-Chem with GNU/OpenMPI and chemistry options:

   .. code-block:: bash

      export WRF_CHEM=1
      export WRF_KPP=1
      ./configure

5. Compile the model (typically ``em_real`` case) and validate generated binaries.
6. Deploy application files to:

   - ``/opt/ohpc/pub/apps/WRF/wrf-chem/v4.5.2``

7. Publish the module file under:

   - ``/opt/ohpc/pub/moduledeps/gnu14-openmpi5/wrf-chem/4.5.2``

Mode of Use
-----------

1. Load the module:

   .. code-block:: bash

      module load wrf-chem/4.5.2

2. Go to a working directory and prepare your simulation files.
3. Ensure your ``namelist.input`` is consistent with your WPS-generated ``met_em`` files.
4. Run the standard WRF-Chem workflow:

   .. code-block:: bash

      ./real.exe
      ./wrf.exe

5. For production runs, submit through Slurm according to Apolo 3 policies.

Quick Validation
----------------

After loading the module, validate the environment with:

.. code-block:: bash

   echo $WRF_DIR
   which mpirun
   ls $WRF_DIR/main/{real.exe,wrf.exe}

References
----------

- WRF Users Page: https://www2.mmm.ucar.edu/wrf/users/
- Build notes used in this deployment: https://forum.mmm.ucar.edu/threads/full-wrf-and-wps-installation-example-gnu.12385/
- WPS detailes compilation process: https://etrp.wmo.int/pluginfile.php/87007/mod_resource/content/4/WRF-Chem%20Training%20Manual.final.Oct3.2024.pdf

Authors
-------

- Julian Valencia
