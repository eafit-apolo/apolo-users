.. _elmer-8.2:

***
8.2
***

- **Installation date:** 06/03/2017
- **URL:** https://www.csc.fi/web/elmer
- **Apolo version:** Apolo II
- **License:** LGPL license

.. contents:: Table of contents

Pre requirements
----------------

- Intel Parell Studio XE Cluster Edition 2017 - Update 1 (Compilers, MPI, Math Libraries)
- Hypre >= 2.10.1
- Cmake >= 3.7.1

Installation
------------

1. Download the latest version of the software (Github) (https://github.com/ElmerCSC/elmerfem):

.. code-block:: bash

    cd /home/mgomezzul/apps/elmer/src/intel
    mkdir elmer
    cd elmer
    git clone git://www.github.com/ElmerCSC/elmerfem+
    mkdir build
    cd build

2. To continue with the installation we must continue with the following configuration and compilation steps using **cmake**:

.. code-block:: bash

    sudo mkdir -p /share/apps/elmer/8.2/intel_impi/2017_update-1
    sudo chown -R $USER.apolo /share/apps/elmer/8.2/intel_impi/2017_update-1
    cmake .. -DCMAKE_INSTALL_PREFIX=/share/apps/elmer/8.2/intel_impi/2017_update-1 -DWITH_MPI:BOOL=TRUE  -DWITH_ELMERGUI:BOOL=FALSE -DWITH_OpenMP:BOOL=TRUE -DCMAKE_BUILD_TYPE=Release -DMPI_TEST_MAXPROC=16 -DWITH_ElmerIce:BOOL=TRUE -DWITH_Hypre:BOOL=TRUE -DWITH_MKL:BOOL=TRUE  -DHypre_LIBRARIES=/share/apps/hypre/2.10.1/intel_impi/2017_update-1/lib/libHYPRE.so  -DHypre_INCLUDE_DIR=/share/apps/hypre/2.10.1/intel_impi/2017_update-1/include 2>&1 | tee elmer-cmake.log
    make 2>&1 | tee elmer-make.log
    make install 2>&1 | tee elmer-make-install.log
    sudo chown -R root.root /share/apps/elmer/8.2/intel_impi/2017_update-1

Module
------

.. code-block:: tcl

    #%Module1.0#####################################################################
    ##
    ## modules load elmer/8.2_intel_impi_mkl-2017_update-1
    ##
    ## /share/apps/modules/elmer/8.2_intel_impi_mkl-2017_update-1  Written by Mateo Gomez-Zulauga
    ##

    proc ModulesHelp { } {2
            puts stderr "\tSets the environment for Elmer 8.2 in the following \
                        \n\tdirectory /share/apps/elmer/8.2/intel_impi/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using Elmer 8.2 \
                \n\tbuilded with Intel Parallel Studio XE Cluster Edition 2017 Update 1\n"


    # for Tcl script use only
    set   	topdir     /share/apps/elmer/8.2/intel_impi/2017_update-1/
    set 	version	   8.2
    set     sys        x86_64-redhat-linux

    conflict elmer
    module load hypre/2.10.1_intel_impi_2017_update-1

    prepend-path PATH		$topdir/bin

    prepend-path LD_LIBRARY_PATH    $topdir/lib
    prepend-path LIBRARY_PATH       $topdir/lib
    prepend-path LD_RUN_PATH        $topdir/lib

    prepend-path C_INCLUDE_PATH     $topdir/include
    prepend-path CXX_INCLUDE_PATH   $topdir/include
    prepend-path CPLUS_INCLUDE_PATH $topdir/include

    setenv	     ELMER_HOME     	$topdir
    setenv	     ELMER_LIB    	$topdir/lib


Mode of Use
-----------

Load the necessary environment through the **module**:

.. code-block:: bash

    module load elmer/8.2_intel_impi_mkl-2017_update-1

Slurm template
--------------

.. code-block:: bash

    #!/bin/sh
    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=32
    #SBATCH --time=1-00
    #SBATCH --job-name=elmer_test
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err
    #SBATCH --mail-type=END,FAIL
    #SBATCH --mail-user=dtobone@eafit.edu.co


    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load elmer/8.2_intel_impi_mkl-2017_update-1

    ElmerGrid 2 2 mesh -metis $SLURM_NTASKS 4
    srun ElmerSolver_mpi

References
----------

- https://www.csc.fi/web/elmer/sources-and-compilation
- http://www.elmerfem.org/elmerwiki/index.php?title=Compilation_of_Elmer_on_Linux_using_Cmake
- http://www.elmerfem.org/elmerwiki/index.php
- https://github.com/ElmerCSC/elmerfem/releases
- http://www.elmerfem.org/forum/viewtopic.php

Author
------

- Mateo Gómez Zuluaga
