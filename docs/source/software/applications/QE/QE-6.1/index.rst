.. _QE-6.1:

***
6.1
***

.. contents:: Table of contents


- **Installation date:** 16/03/2017
- **URL:** http://www.quantum-espresso.org
- **Apolo version:** Apolo II
- **License:** GNU GENERAL PUBLIC LICENSE Version 2

Pre requirements
----------------

- Intel Parell Studio XE Cluster Edition 2017 - Update 1
- Intel Compilers Fortran and C
- Intel MPI (Fortran and C)
- Intel MKL

Installation
------------

1. Download the latest version of the software (Repository) (https://github.com/QEF/q-e):

.. code-block:: bash

    cd /home/mgomezzul/apps/qe/src/intel
    wget https://github.com/QEF/q-e/archive/qe-6.1.0.tar.gz
    tar xf qe-6.1.tar.gz
    cd qe-6.1

2. To proceed with the configuration and compilation we must continue with the following steps:

.. code-block:: bash

    module load intel/2017_update-1 impi/2017_update-1 mkl/2017_update-1
    unset LD
    export CPP="$CC -E"
    export LD=$MPIF90

    ./configure --prefix=/share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1 --build=x86_64-redhat-linux --enable-openmp --enable-parallel --with-scalapack=yes FC=ifort F90=ifort F77=ifort CC=icc CXX=icpc CPP="icc -E" LD=mpiifort BLAS_LIBS="-lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -ldl" LAPACK_LIBS="" SCALAPACK_LIBS="-lmkl_scalapack_lp64 -lmkl_blacs_intelmpi_lp64" FFT_LIBS="-lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -ldl" 2>&1 | tee conf.log
    sudo mkdir -p /share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1
    sudo chown -R mgomezzul.apolo /share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1
    emacs make.inc
    ...
    DFLAGS         =  -D__INTEL -D__SCALAPACK -D__OPENMP -D__DFTI -D__MPI
    ...
    make all -j 8 2>&1 | tee qe-make.log
    make install 2>&1 | tee qe-make-install.log
    sudo chown -R root.root /share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1

3. Add the potential pseudos

.. code-block:: bash

    sudo mkdir -p /share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1/pseudos
    cd /share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1/pseudos
    # Verificar la última versión de los pseudos - http://www.quantum-espresso.org/pseudopotentials/
    wget http://www.quantum-espresso.org/wp-content/uploads/upf_files/upf_files.tar
    tar xf upf_files.tar
    rm upf_files.tar

Module
------

.. code-block:: tcl

    #%Module1.0#####################################################################
    ##
    ## modules qe/6.1_intel-17.0.1 Written by Mateo Gómez Zuluaga
    ##

    proc ModulesHelp { } {
            puts stderr "\tSets the environment for Quantum Espresso 6.1 in the \
                        \n\tfollowing shared directory \
                \n\t/share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1\n"
    }

    module-whatis "\n\n\tQuatum Espresso-6.1 is  an integrated suite of \
            \n\tOpen-Source computer codes for electronic-structure \
            \n\tcalculations and materials modeling at the nanoscale \
                \n\tbuilded with Intel Parallel Studio XE Cluster Edition \
            \n\t2017 Update 1 (Intel MPI and Intel MKL)\n"


    # for Tcl script use only
    set   	  topdir	/share/apps/qe/6.1/intel_17.0.1_impi_17.0.1_mkl_17.0.1
    set	  version	6.1
    set       sys		x86_64-redhat-linux
    set       user         	[exec bash -c "echo \$USER"]

    conflict qe

    module load intel/2017_update-1
    module load impi/2017_update-1
    module load mkl/2017_update-1

    prepend-path PATH		$topdir/bin
    setenv 	     BIN_DIR		$topdir/bin

    setenv       OMP_NUM_THREADS    1
    setenv	     ESPRESSO_PSEUDO	$topdir/pseudo
    setenv 	     PSEUDO_DIR		$topdir/pseudo
    setenv	     ESPRESSO_TMPDIR	/scratch-local/$user/qe
    setenv       TMP_DIR		/scratch-local/$user/qe
    setenv 	     NETWORK_PSEUDO	http://www.quantum-espresso.org/wp-content/uploads/upf_files/

Mode of use
-----------

Load the necessary environment through the **module**:

..code-block:: bash

    module load qe/6.1_intel-17.0.1

Slurm template
--------------

.. code-block:: bash

    #!/bin/sh
    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=32
    #SBATCH --time=1-00
    #SBATCH --job-name=qe_test
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err
    #SBATCH --mail-type=ALL
    #SBATCH --mail-user=jrendon8@eafit.edu.co


    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load qe/6.1_intel-17.0.1

    srun pw.x < test_1.in

Input file
----------

.. code-block:: text

    &CONTROL
    calculation = "scf", ! single point calculation (default, could be omitted)
    prefix = "CO", ! all auxiliary files will have filename beginning by prefix
    tprnfor = .true.
    /
    &SYSTEM
    ibrav = 0, ! Bravais lattice defined by user in CELL_PARAMETERS card
    celldm(1)= 1.88972687, ! define length unit as 1 AA= 1/0.529177 bohr
    ntyp = 2, ! number of atomic species (see later ATOMIC_SPECIES)
    nat = 2, ! number of atoms in the unit cell (see later ATOMIC_POSITIONS)
    ecutwfc = 24.D0,
    ecutrho = 144.D0,
    /
    &ELECTRONS
    conv_thr = 1.D-7, ! convergence threshold on total energy , in Rydberg
    /
    CELL_PARAMETERS cubic
    10.0  0.0  0.0
    0.0 10.0  0.0
    0.0  0.0 10.0
    ATOMIC_SPECIES
    O 1.00 O.pbe-rrkjus.UPF
    C 1.00 C.pbe-rrkjus.UPF
    ATOMIC_POSITIONS angstrom
    C 1.152 0.0 0.0
    O 0.000 0.0 0.0
    K_POINTS gamma

References
----------

- http://www.archer.ac.uk/documentation/software/espresso/compiling_5.0.3_mkl-phase1.php
- https://glennklockwood.blogspot.com.co/2014/02/quantum-espresso-compiling-and-choice.html
- https://proteusmaster.urcf.drexel.edu/urcfwiki/index.php/Compiling_Quantum_Espresso
- https://www.hpc.ntnu.no/ntnu-hpc-group/vilje/user-guide/software/quantum-espresso
- https://nishaagrawal.wordpress.com/2013/03/21/quantum-espresso-5-0-2qe-64-bit-installation-with-intel-compser-xe-2013-and-intel-mpi/
- https://software.intel.com/en-us/articles/quantum-espresso-for-intel-xeon-phi-coprocessor
- http://www.quantum-espresso.org/pseudopotentials/

Author
------

- Mateo Gómez Zuluaga
