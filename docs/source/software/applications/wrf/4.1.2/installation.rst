.. _wrf-4.1.2-installation:

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents

   .. contents::
      :depth: 2
      :local:

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- **Compiler:** Intel Parallel Studio XE Compiler Cluster Edition :math:`\boldsymbol{\ge}` 17.0.1.
- **Requirements:**

  * NetCDF :math:`\boldsymbol{\ge}` 4.1.3

  * MPICH :math:`\boldsymbol{\ge}` 3.0.4

  * zlib :math:`\boldsymbol{\ge}` 1.2.7

  * JasPer :math:`\boldsymbol{\ge}` 1.900.1

Build process
-------------

#. Get the source code

   .. code-block:: bash

      wget  https://github.com/wrf-model/WRF/archive/v4.1.2.tar.gz
      tar vf v4.1.2.tar.gz
      cd WRF-4.1.2

#. Edit the architecture configuration in :bash:`arch/Config.pl`

   .. code-block:: bash

      $I_really_want_to_output_grib2_from_WRF = "FALSE" ;

   To:

   .. code-block:: bash

      $I_really_want_to_output_grib2_from_WRF = "TRUE" ;

#. Load the modules and execute the configuration script.

   .. code-block:: bash

      module load netcdf perl hdf5 mpich2 jasper
      ./configure
      checking for perl5... no
      checking for perl... found /usr/bin/perl (perl)
      Will use NETCDF in dir: /usr/bin/netcdf
      HDF5 not set in environment. Will configure WRF for use without.
      PHDF5 not set in environment. Will configure WRF for use without.
      Will use 'time' to report timing information
      $JASPERLIB or $JASPERINC not found in environment, configuring to build without grib2 I/O...
      ------------------------------------------------------------------------
      Please select from among the following Linux x86_64 options:
  
      1. (serial)   2. (smpar)   3. (dmpar)   4. (dm+sm)   PGI (pgf90/gcc)
      5. (serial)   6. (smpar)   7. (dmpar)   8. (dm+sm)   PGI (pgf90/pgcc): SGI MPT
      9. (serial)  10. (smpar)  11. (dmpar)  12. (dm+sm)   PGI (pgf90/gcc): PGI accelerator
      13. (serial)  14. (smpar)  15. (dmpar)  16. (dm+sm)   INTEL (ifort/icc)
      17. (dm+sm)   INTEL (ifort/icc): Xeon Phi (MIC architecture)
      18. (serial)  19. (smpar)  20. (dmpar)  21. (dm+sm)   INTEL (ifort/icc): Xeon (SNB with AVX mods)
      22. (serial)  23. (smpar)  24. (dmpar)  25. (dm+sm)   INTEL (ifort/icc): SGI MPT
      26. (serial)  27. (smpar)  28. (dmpar)  29. (dm+sm)   INTEL (ifort/icc): IBM POE
      30. (serial)               31. (dmpar)                PATHSCALE (pathf90/pathcc)
      32. (serial)  33. (smpar)  34. (dmpar)  35. (dm+sm)   GNU (gfortran/gcc)
      36. (serial)  37. (smpar)  38. (dmpar)  39. (dm+sm)   IBM (xlf90_r/cc_r)
      40. (serial)  41. (smpar)  42. (dmpar)  43. (dm+sm)   PGI (ftn/gcc): Cray XC CLE
      44. (serial)  45. (smpar)  46. (dmpar)  47. (dm+sm)   CRAY CCE (ftn/cc): Cray XE and XC
      48. (serial)  49. (smpar)  50. (dmpar)  51. (dm+sm)   INTEL (ftn/icc): Cray XC
      52. (serial)  53. (smpar)  54. (dmpar)  55. (dm+sm)   PGI (pgf90/pgcc)
      56. (serial)  57. (smpar)  58. (dmpar)  59. (dm+sm)   PGI (pgf90/gcc): -f90=pgf90
      60. (serial)  61. (smpar)  62. (dmpar)  63. (dm+sm)   PGI (pgf90/pgcc): -f90=pgf90
      64. (serial)  65. (smpar)  66. (dmpar)  67. (dm+sm)   INTEL (ifort/icc): HSW/BDW
      68. (serial)  69. (smpar)  70. (dmpar)  71. (dm+sm)   INTEL (ifort/icc): KNL MIC
  
      Enter selection [1-71] : 21
      ------------------------------------------------------------------------
      Compile for nesting? (1=basic, 2=preset moves, 3=vortex following) [default 1]: 1
  
      Configuration successful!
      ------------------------------------------------------------------------
      testing for MPI_Comm_f2c and MPI_Comm_c2f
      MPI_Comm_f2c and MPI_Comm_c2f are supported
      testing for fseeko and fseeko64
      fseeko64 is supported
      ------------------------------------------------------------------------
    
   The configuration file is configuration.wrf.

#. Compile WRF, with the case you need.

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

Compile WSP
###########

The WRF Preprocessing System (WPS) [1]_ is a set of three programs whose collective 
role is to prepare input to the real.exe program for real-data simulations.

#. Download the latest version of WSP

   .. code-block:: bash

      wget https://github.com/wrf-model/WPS/archive/v4.1.tar.gz
      tar vf 4.1.tar.gz
      cd WPS-4.1

#. Load the correspondent modules and execute the configuration script.

   .. code-block:: bash

      module load jasper
      ./configure

#. Edit the configuration file :bash:`configure.wps`

   .. code-block:: bash

      WRF_DIR = path/to/wps

      // Depends on your compiler version you should remove -f90=ifort from the following line
      DM_FC = mpif90 -f90=ifort

#. Compile it.

   .. code-block:: bash

      ./compile | tee wps-compilation.log

Modulefile
----------

.. literalinclude:: src/4.1.2_intel-17.0.1
      :language: bash
      :caption: :download:`4.1.2_intel-17.0.1 <src/4.1.2_intel-17.0.1>`

.. [1] Mesoscale & Microscale Meteorology Laboratory. (n.d.). Chapter 3: WRF Preprocessing System. [online] Available at: http://www2.mmm.ucar.edu/wrf/users/docs/user_guide/users_guide_chap3.html [Accessed 28 Aug. 2019].