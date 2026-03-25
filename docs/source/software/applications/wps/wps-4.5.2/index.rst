.. _wps-4.5.2-index:

.. role:: bash(code)
   :language: bash

WPS 4.5.2 (Apolo 3)
===================

.. contents:: Table of Contents

Basic Information
-----------------

- **Deploy date:** 03/2026
- **Official Website:** https://www2.mmm.ucar.edu/wrf/users/
- **Installation path:** ``/opt/ohpc/pub/apps/WRF/wps/v4.5``
- **Installed on:** Apolo 3

Module
------

The production module for this version is:

.. code-block:: bash

   module load wps/4.5

Main module dependencies configured in Apolo 3:

.. code-block:: bash

   gnu14/14.2.0
   jasper/1.900.1
   libpng/1.2.50
   netcdf/4.9.3
   wrf-chem/4.5.2
   phdf5/1.14.6

Environment variables exported by the module:

.. code-block:: bash

   WPS_DIR=/opt/ohpc/pub/apps/WRF/wps/v4.5/

The module also prepends to ``PATH``:

- ``/opt/ohpc/pub/apps/WRF/wps/v4.5/``
- ``/opt/ohpc/pub/apps/WRF/scripts/wps4.5-wrf-chem4.5.2``

High-level Build Process
------------------------

This section summarizes the process used to build and deploy WPS 4.5.2 on Apolo 3.

1. Load the GNU toolchain and required dependencies.
2. Export WPS build variables pointing to WRF, NetCDF and JasPer paths.
3. Run ``./configure`` and select the GNU + distributed memory option.
4. Adjust ``configure.wps`` for Apolo 3 compiler flags when required.
5. Run ``./compile`` and validate generated binaries:

   - ``geogrid.exe``
   - ``ungrib.exe``
   - ``metgrid.exe``

6. Deploy application files to:

   - ``/opt/ohpc/pub/apps/WRF/wps/v4.5``

7. Publish the module file under:

   - ``/opt/ohpc/pub/moduledeps/gnu14-openmpi5/wps/4.5``

Mode of Use
-----------

Recommended workflow:

1. Load modules:

   .. code-block:: bash

      module use /opt/ohpc/pub/moduledeps/gnu14-openmpi5
      module load wrf-chem/4.5.2
      module load wps/4.5

2. Initialize a ready-to-run working directory with the provided helper script:

   .. code-block:: bash

      init_wrf_enviroment.sh

   This script creates:

   - ``./wrf_sim_YYYYmmdd_HHMMSS/WPS``
   - ``./wrf_sim_YYYYmmdd_HHMMSS/WRF_Chem``

   and copies/links baseline files for WPS and WRF-Chem.

3. Edit ``namelist.wps`` and run preprocessing steps:

   .. code-block:: bash

      ./geogrid.exe
      ./link_grib.csh /path/to/grib/files
      ln -sf ungrib/Variable_Tables/Vtable.<dataset> Vtable
      ./ungrib.exe
      ./metgrid.exe

4. Continue in the ``WRF_Chem`` directory with ``real.exe`` and ``wrf.exe``.

Quick Validation
----------------

After loading modules:

.. code-block:: bash

   echo $WPS_DIR
   which geogrid.exe
   which init_wrf_enviroment.sh

References
----------

- WRF/WPS official documentation: https://www2.mmm.ucar.edu/wrf/users/docs/user_guide_v4/
- WRF source downloads: https://www2.mmm.ucar.edu/wrf/users/download/get_sources.html
- WRF detailes compilation process: https://etrp.wmo.int/pluginfile.php/87007/mod_resource/content/4/WRF-Chem%20Training%20Manual.final.Oct3.2024.pdf

Authors
-------

- Julian Valencia
