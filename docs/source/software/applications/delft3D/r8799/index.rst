.. _r8799:

*****
r7799
*****

- **Installation date:** 29/05/2018
- **URL:** https://oss.deltares.nl/web/delft3d
- **Apolo version:** Apolo II and Cronos
- **License:**  GNU GENERAL PUBLIC LICENSE 3.0

.. contents:: Table of Contents

Dependencies
-------------

- Intel Parallel Studio XE 2017 Update 1 Cluster Editon >= 17.0.1
- mpich2 >= 3.2
- NetCDF-C >= 4.5.0
- NetCDF Fortran
- hdf5 >= 1.8.19
- zlib >= 1.2.11
- szip >= 2.1
- libtool >= 2.4.6
- autconf >= 2.69

Installation
------------
Load the needed modules or add the to the path

1. Download the repository

.. code-block:: bash

    $ cd cd /home/mgomezzul/apps/delft3d/intel
    $ svn checkout https://svn.oss.deltares.nl/repos/delft3d/tags/8799 delft3d_8850


2. For installation, the following steps must be done:

.. code-block:: bash

    $ cd delft3d_8850/src
    $ ./build.sh -intel18 -64bit -c "--build=x86_64-redhat-linux"

Module
------

.. code-block:: bash

        #%Module1.0####################################################################
    ##
    ## module load delft3d/8799_intel-18.0.2
    ##
    ## /share/apps/modules/delft3d/8799_intel-18.0.2
    ##
    ## Written by Mateo Gómez-Zuluaga
    ##

    proc ModulesHelp {} {
         global version modroot
         puts stderr "Sets the environment for using Delft3D 8799\
              \nin the shared directory /share/apps/delft3d/8799/intel-18.0.2\
              \nbuilded with Intel Compiler 18.0.2, MPICH2-3.2.1, NetCDF 4.6.1, \
              \nNetCDF 4.4.4 and HDF5-1.8.20."
    }

    module-whatis "(Name________) delft3d"
    module-whatis "(Version_____) 8799"
    module-whatis "(Compilers___) intel-18.0.2"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) netcdf-4.6.1, netcdf-fortran-4.4.4, hdf5-1.8.20"

    # for Tcl script use only
    set         topdir        /share/apps/delft3d/8799/intel-18.0.2
    set         version       8799
    set         sys           x86_64-redhat-linux

    conflict delft3d
    module load netcdf/4.6.1_intel-18.0.2
    module load mpich2/3.2.1_intel-18.0.2

    setenv		D3D_HOME		$topdir
    setenv		ARCH			lnx64

    prepend-path	PATH			$topdir/bin

    prepend-path	LD_LIBRARY_PATH		$topdir/lib
    prepend-path	LIBRARY_PATH		$topdir/lib
    prepend-path	LD_RUN_PATH		$topdir/lib

    prepend-path    LD_LIBRARY_PATH         $topdir/lnx64/dimr/bin
    prepend-path    LIBRARY_PATH            $topdir/lnx64/dimr/bin
    prepend-path    LD_RUN_PATH             $topdir/lnx64/dimr/bin

    prepend-path	PATH			$topdir/lnx64/flow2d3d/bin
    prepend-path	LD_LIBRARY_PATH		$topdir/lnx64/flow2d3d/bin
    prepend-path	LIBRARY_PATH		$topdir/lnx64/flow2d3d/bin
    prepend-path	LD_RUN_PATH		$topdir/lnx64/flow2d3d/bin

    prepend-path	PATH			$topdir/lnx64/part/bin
    prepend-path	LD_LIBRARY_PATH		$topdir/lnx64/part/bin
    prepend-path	LIBRARY_PATH		$topdir/lnx64/part/bin
    prepend-path	LD_RUN_PATH		$topdir/lnx64/part/bin

    prepend-path	LD_LIBRARY_PATH		$topdir/lnx64/plugins/bin
    prepend-path	LIBRARY_PATH		$topdir/lnx64/plugins/bin
    prepend-path	LD_RUN_PATH		$topdir/lnx64/plugins/bin

    prepend-path	PATH			$topdir/lnx64/scripts

    prepend-path	LD_LIBRARY_PATH		$topdir/lnx64/shared
    prepend-path	LIBRARY_PATH		$topdir/lnx64/shared
    prepend-path	LD_RUN_PATH		$topdir/lnx64/shared

    prepend-path	PATH			$topdir/lnx64/swan/bin
    prepend-path	PATH			$topdir/lnx64/swan/scripts
    prepend-path	LD_LIBRARY_PATH		$topdir/lnx64/swan/bin
    prepend-path	LIBRARY_PATH		$topdir/lnx64/swan/bin
    prepend-path	LD_RUN_PATH		$topdir/lnx64/swan/bin

    prepend-path	PATH			$topdir/lnx64/waq/bin
    prepend-path	LD_LIBRARY_PATH		$topdir/lnx64/waq/bin
    prepend-path	LIBRARY_PATH		$topdir/lnx64/waq/bin
    prepend-path	LD_RUN_PATH		$topdir/lnx64/waq/bin

    prepend-path	PATH			$topdir/lnx64/wave/bin
    prepend-path	LD_LIBRARY_PATH		$topdir/lnx64/wave/bin
    prepend-path	LIBRARY_PATH		$topdir/lnx64/wave/bin
    prepend-path	LD_RUN_PATH		$topdir/lnx64/wave/bin


Use mode
---------

.. code-block:: bash

    #!/bin/bash

    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=16
    #SBATCH --time=4:00:00
    #SBATCH --job-name=delft3d_271
    #SBATCH -o test_%N_%j.out      # File to which STDOUT will be written
    #SBATCH -e test_%N_%j.err      # File to which STDERR will be written

    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=16
    export OMP_NUM_THREADS_SWAN=$SLURM_NTASKS
    #export NHOSTS=$SLURM_JOB_NUM_NODES
    #export NSLOTS=$SLURM_NTASKS

    module load delft3d/8799_intel-18.0.2

    # Specify the config file to be used here
    argfile=config_d_hydro.xml
    mdwfile=271.mdw

    # Run in parallel Flow
    mpirun -np 1 d_hydro.exe $argfile &

    # Run in combination Wave
    wave.exe $mdwfile 1


References
----------

- http://oss.deltares.nl/web/delft3d/source-code
- http://oss.deltares.nl/web/delft3d/faq

Author
------

- Mateo Gómez Zuluaga
