.. _QE-6.2.1:

*****
6.2.1
*****

.. contents:: Table of contents


- **Installation date:** 30/05/2018
- **URL:** http://www.quantum-espresso.org
- **Apolo version:** Apolo II and Cronos
- **License:** GNU GENERAL PUBLIC LICENSE Version 2

Pre requirements
----------------

- Intel Parell Studio XE Cluster Edition 2018 - Update 2
- Intel Compilers (Fortran and C)
- Intel MPI (Fortran and C)
- Intel MKL

Installation
------------

1. Download the latest version of the software (`Git Repository <https://github.com/QEF/q-e/releases>`_):

.. code-block:: bash

    cd /home/$USER/apps/qe/src/intel
    wget https://github.com/QEF/q-e/archive/qe-6.2.1.tar.gz
    tar xf qe-6.2.1.tar.gz
    cd qe-6.2.1

2. To proceed with the configuration and compilation we must follow these steps:

.. code-block:: bash

    module load mkl/18.0.2 impi/18.0.2
    module load intel/18.0.2 # Sobreescribe las variables CC, CXX, FC, etc..
    unset LD
    export LD=$MPIF90
    export CPP="$CC -E"

3. After establishing the compilation environment we must do the following steps for configuration:

.. code-block:: bash

    sudo mkdir -p /share/apps/qe/6.2.1/intel-18.0.2
    sudo chown -R $USER.apolo /share/apps/qe/6.2.1/intel-18.0.2
    ../configure --prefix=/share/apps/qe/6.2.1/intel-18.0.2 --build=x86_64-redhat-linux --enable-openmp --enable-parallel --with-scalapack=intel 2>&1 | tee conf.log

4. Now we must edit the **make.inc** file and it should look like the one found here (`make.inc <https://gitlab.com/apolo/apolo-software/blob/master/cronos/qe/6.2.1/intel-18.0.2/make.inc>`_)

.. code-block:: bash

    emacs make.inc
    ...
    DFLAGS         =  -D__DFTI -D__MPI -D__SCALAPACK -D__INTEL -D__OPENM
    ...
    CPP            = "icc -E"
    ...
    CFLAGS         = -O3 -xHost -fno-alias -ansi-alias $(DFLAGS) $(IFLAGS)
    FFLAGS         = -O3 -xHost -fno-alias -ansi-alias -assume byterecl -g -traceback -qopenmp
    ...
    LD             = mpiifort
    ...
    # External Libraries (if any) : blas, lapack, fft, MPI
    BLAS_LIBS      =   -lmkl_intel_lp64  -lmkl_intel_thread -lmkl_core
    BLAS_LIBS_SWITCH = external

    # If you have nothing better, use the local copy via "--with-netlib" :
    # LAPACK_LIBS = /your/path/to/espresso/LAPACK/lapack.a
    # LAPACK_LIBS_SWITCH = internal
    # For IBM machines with essl (-D__ESSL): load essl BEFORE lapack!
    # remember that LAPACK_LIBS precedes BLAS_LIBS in loading order

    LAPACK_LIBS    =
    LAPACK_LIBS_SWITCH = external

    SCALAPACK_LIBS = -lmkl_scalapack_lp64 -lmkl_blacs_intelmpi_lp64
    ...

- **Note:** review in detail the make.inc present in GitLab.

5. After the modifications in the previous file we can continue with the compilation

.. code-block:: bash

    make all -j 8 2>&1 | tee qe-make.log
    make install 2>&1 | tee qe-make-install.log
    sudo chown -R root.root /share/apps/qe/6.2.1/intel-18.0.2

- **Note:** sometimes you have to run the **make -j 8** twice

6. Add the potential pseudo

- **Note:** Check if they are already present in any previous Quatum-Espresso installation

1. If they are already present in a previous installation.

.. code-block:: bash

    sudo ln -s /share/apps/qe/6.2.1/gcc-5.5.0/pseudo /share/apps/qe/6.2.1/intel-18.0.2/pseudo

2. If they are not present.

.. code-block:: bash

    sudo mkdir -p /share/apps/qe/6.2.1/intel-18.0.2/pseudo
    cd /share/apps/qe/6.2.1/intel-18.0.2/pseudo
    # Check the latest version of the pseudos - http://www.quantum-espresso.org/pseudopotentials/
    wget http://www.quantum-espresso.org/wp-content/uploads/upf_files/upf_files.tar
    tar xf upf_files.tar
    rm upf_files.tar

Module
------

.. code-block:: tcl

    #%Module1.0####################################################################
    ##
    ## module load qe/6.2.1_intel-18.0.2
    ##
    ## /share/apps/modules/qe/6.2.1_intel-18.0.2
    ## Written by Mateo Gómez-Zuluaga
    ##

    proc ModulesHelp {} {
        global version modroot
        puts stderr "Sets the environment for using qe 6.2.1\
            \nin the shared directory /share/apps/qe/6.2.1/intel-18.0.2\
            \nbuilded with Intel Parallel Studio XE Cluster Edittion 2018 Update 2."
    }

    module-whatis "(Name________) qe"
    module-whatis "(Version_____) 6.2.1"
    module-whatis "(Compilers___) intel-18.0.2"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) mkl-18.0.2"

    # for Tcl script use only
    set         topdir        /share/apps/qe/6.2.1/intel-18.0.2
    set         version       6.2.1
    set         sys           x86_64-redhat-linux
    set         user       	  [exec bash -c "echo \$USER"]

    conflict qe
    module load mkl/18.0.2
    module load impi/18.0.2

    setenv		OMP_NUM_THREADS		1
    setenv		ESPRESSO_PSEUDO		$topdir/pseudo
    setenv		PSEUDO_DIR		$topdir/pseudo
    setenv		ESPRESSO_TMPDIR		/scratch-local/$user/qe
    setenv		TMP_DIR			/scratch-local/$user/qe
    setenv		NETWORK_PSEUDO		http://www.quantum-espresso.org/wp-content/uploads/upf_files
    setenv 		BIN_DIR			$topdir/bin

    prepend-path	PATH			$topdir/bin

Mode of use
-----------

Load the necessary environment through the **module**:

.. code-block:: bash

    module load qe/6.2.1_intel-18.0.2

Slurm template
--------------

.. code-block:: bash

    #!/bin/sh
    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=16
    #SBATCH --time=1-00
    #SBATCH --job-name=qe_test
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err


    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load qe/6.2.1_intel-18.0.2

    srun --mpi=pmi2 pw.x < test_1.in

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
