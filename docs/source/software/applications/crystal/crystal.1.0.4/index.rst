.. _crystal49:

**************
Crystal 1.0.4
**************

- **Installation date:** 13/02/2017
- **URL:** http://www.crystalsolutions.eu/crystal.html
- **Apolo version:** Apolo II
- **License:** Academic license

.. contents:: Table of Contents

Dependencies
-------------

-Intel Parallel Studio XE 2017 Update 1

Installation
------------

#. First download the tar from the main page https://www.crystalsolutions.eu/order.html?uid=2156&oid=649

.. code-block:: bash

    mkdir CRYSTAL14
    cd CRYSTAL14
    tar -zxvf crystal14_v1_0_4_Linux-ifort_emt64_Pdistrib.tar.gz
    cd build/Xmakes


#. Edit the folowwing lines in Linux-ifort_XE_impi_emt64.inc

.. code-block:: bash

    cp Linux-ifort_XE_openmpi_emt64.inc Linux-ifort_XE_impi_emt64.inc
    emacs Linux-ifort_XE_impi_emt64.inc
    ...
    MPIBIN  = /share/apps/intel/ps_xe/2017_update-1/compilers_and_libraries_2017.1.132/linux/mpi/intel64/bin
    F90     = $(MPIBIN)/mpiifort
    ...
    PLD     = $(MPIBIN)/mpiifort
    F90FLAGS = -O3 -align -static-intel -cxxlib
    ...
    MKL=/export/apps/intel/ps_xe/2017_update-1/compilers_and_libraries_2017.1.132/linux/mkl/lib/intel64_lin

#. Edit the makefile

.. code-block:: bash

    cd ..
    emacs Makefile
    ...
    ARCH = Linux-ifort_XE_impi_emt64
    VERSION = v1.0.4

#. Compilation process

.. code-block:: bash

    module load impi/2017_update-1
    make all

Module
---------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## modules 1.0.4_intel_impi-2017_update-1
    ##
    ## /share/apps/modules/crystal14/1.0.4_intel_impi-2017_update-1  Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tcrystal14/v$version - sets the Environment for crystal14 in \
        \n\tthe share directory /share/apps/crystal14/bin/Linux-ifort_XE_impi_emt64/v1.0.4\n"
    }

    module-whatis "\n\n\tSets the environment for using crystal14 v1.0.4 builded with \
              \n\tIntel Parallel Studio XE 2017 Update 1 (ifort and mpiifort)\n"

    # for Tcl script use only
    set     topdir	     /share/apps/crystal14
    set     version	     1.0.4
    set     sys          x86_64-redhat-linux

    # Module use
    set   	user	     [exec bash -c "echo \$USER"]
    set 	CRY14_ROOT   $topdir
    set 	CRY14_BIN    bin
    set 	CRY14_ARCH   Linux-ifort_XE_impi_emt64
    set 	VERSION	     v1.0.4
    set 	CRY14_EXEDIR $CRY14_ROOT/$CRY14_BIN/$CRY14_ARCH
    set 	CRY14_UTILS  $CRY14_ROOT/utils14


    conflict crystal

    module load impi/2017_update-1

    setenv 	CRY14_ROOT   $topdir
    setenv 	CRY14_BIN    bin
    setenv 	CRY14_ARCH   Linux-ifort_XE_impi_emt64
    setenv 	VERSION	     v1.0.4
    setenv 	CRY14_SCRDIR /scratch-local/$user/crystal14
    setenv 	CRY14_EXEDIR $CRY14_ROOT/$CRY14_BIN/$CRY14_ARCH
    setenv 	CRY14_UTILS  $CRY14_ROOT/utils14
    setenv 	CRY14_TEST   $CRY14_ROOT/test_cases/inputs

    prepend-path PATH    $CRY14_EXEDIR/$VERSION
    prepend-path PATH    $CRY14_UTILS

Usage mode
----------------

.. code-block:: bash

    rocks run host "hostname; mkdir -p /scratch-local/mmarins/crystal14; chown mmarins.gema -R /scratch-local/mmarins/crystal14"
    module load crystal14/1.0.4_intel_impi-2017_update-1
    mkdir example_crystal
    cd example_crystal

Slurm template
---------------

.. code-block:: bash

    #!/bin/sh
    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=32
    #SBATCH --time=2:00:00
    #SBATCH --job-name=crystal14
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err
    #SBATCH --mail-type=END,FAIL
    #SBATCH --mail-user=mmarins@eafit.edu.co

    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load crystal14/1.0.4_intel_impi-2017_update-1

    # Store machine's names in nodes.par and machines.LINUX files
    NODES="nodes.par"
    MACHINES="machines.LINUX"
    srun hostname | sort > $NODES
    srun hostname | sort > $MACHINES

    INPUT_FILE='m_3a'

    # Execute the Pcrystal
    runmpi14  $SLURM_NTASKS $INPUT_FILE

    # Removes the nodes.par and machines.LINUX files
    rm nodes.par
    rm machines.LINUX

    # Delete temporal files
    TMP_DIRS=`srun hostname | sort -u`

    for i in ${TMP_DIRS[@]}; do
        rocks run host ${i} "rm -rf `cat temp_folder`"
    done


References
------------

- Documents on the zip
    - howtoinstall.txt
    - howtoinstall_from_objects.txt

Author
------

- Mateo Gómez Zuluaga
