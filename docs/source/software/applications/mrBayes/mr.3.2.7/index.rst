.. _mrbayes:

*************
MrBayes 3.2.7
*************

.. contents:: Table of Contents

- **Installation date:** 23/02/2021
- **URL:** http://mrbayes.sourceforge.net/index.php
- **Apolo version:** Apolo II
- **License:** GNU GENERAL PUBLIC LICENSE Version 3

Dependencies
-------------

- Beagle (CUDA or CPU version)
- Intel compiler (C y C++)
- Intel OPENMPI (C y C++)

Installation
------------

1. First download the tar from the main page

.. code-block:: bash

    mkdir mrbayes
    cd /home/blopezp/Desktop/mrbayes
    wget https://github.com/NBISweden/MrBayes/releases/download/v3.2.7/mrbayes-3.2.7.tar.gz
    tar -xzvf mrbayes-3.2.7.tar.gz
    cd mrbayes-3.2.7

2. Makefile config and CUDA support

.. code-block:: bash

    mkdir build
    cd build
    module load openmpi/3.1.5_intel-19.0.4
    module load beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1
    module load gcc/7.4.0
    ../configure --prefix=/share/apps/mrbayes/3.2.7/cuda/7.0/gcc/7.4.0 --with-mpi=/share/apps/openmpi/3.1.5/intel-19.0.4 --enable-sse --with-beagle=/share/apps/beagle-lib/2.1.2/cuda/7.0/intel2017_update-1 2>&1 | tee mrbayes-conf.log
    make 2>&1 | tee mrbayes-make.log
    sudo make install

3. Makefile config and CUDA no support

.. code-block:: bash

    module unload beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1
    module unload gcc/7.4.0

    module load openmpi/3.1.5_intel-19.0.4
    module load beagle-lib/2.1.2_intel-2017_update-1
    module load gcc/7.4.0
    ../configure --prefix=/share/apps/mrbayes/3.2.7/gcc/7.4.0 --with-mpi=/share/apps/openmpi/3.1.5/intel-19.0.4 --enable-sse --with-beagle=/share/apps/beagle-lib/2.1.2/intel/2017_update-1 2>&1 | tee mrbayes-conf.log
    make 2>&1 | tee mrbayes-make.log
    sudo make install

Module
---------

**CUDA**

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module mrbayes/3.2.7_cuda-7.0_gcc-7.4.0
    ##
    ## /share/apps/modules/mrbayes/3.2.7_cuda-7.0_gcc-7.4.0    Written by Bryan López Parra
    ##

    proc ModulesHelp { } {
	puts stderr "\tzlib/1.2.11 - sets the Environment for MrBayes 3.2.7 in \
	\n\tthe share directory /share/apps/mrbayes/3.2.7_cuda-7.0_gcc-7.4.0\n"
    }

    module-whatis "\n\n\tSets the environment for using MrBayes 3.2.7 \
		    \n\tbuilded with CUDA 7.0 AND gcc-7.4.0\n"

    # for Tcl script use only
    set       topdir     /share/apps/mrbayes/3.2.7_cuda-7.0_gcc-7.4.0
    set       version    3.2.7
    set       sys        x86_64-redhat-linux

    module load beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1
    module load openmpi/3.1.5_intel-19.0.4

    prepend-path PATH    $topdir/bin


**CPU**

.. code-block:: bash

	#%Module1.0#####################################################################
	##
	## module mrbayes/3.2.7_gcc-7.4.0
	##
	## /share/apps/modules/mrbayes/3.2.7_gcc-7.4.0    Written by Bryan López Parra
	##

	proc ModulesHelp { } {
	    puts stderr "\tmrbayes/3.2.7_gcc-7.4.0 - sets the Eviroment for MrBayes in \
	    \n\tthe share directory /share/apps/mrbayes/3.2.7_gcc-7.4.0\n"
	}

	module-whatis "\n\n\tSets the environment for using MrBayes 3.2.7 \
		       \n\tbuilded with gcc-7.4.0\n"

	# for Tcl script use only
	set       topdir     /share/apps/mrbayes/3.2.7_gcc-7.4.0
	set       version    3.2.7
	set       sys        x86_64-redhat-linux

	module load beagle-lib/2.1.2_intel-2017_update-1
	module load openmpi/3.1.5_intel-19.0.4

	prepend-path PATH    $topdir/bin


Slurm template
--------------

**CUDA**

.. code-block:: bash

	#!/bin/bash
	#SBATCH --partition=accel
	#SBATCH --nodes=1
	#SBATCH --ntasks-per-node=1
	#SBATCH --gres=gpu:2
	#SBATCH --time=1:00:00
	#SBATCH --job-name=mrbayes_gpu
	#SBATCH -o result_%N_%j.out
	#SBATCH -e result_%N_%j.err

	export SBATCH_EXPORT=NONE
	export OMP_NUM_THREADS=1

	module load mrbayes/3.2.7_cuda-7.0_gcc-7.4.0

	mpirun -np 1 mb primates-gtr-gamma.nex



**CPU**

.. code-block:: bash

	#!/bin/bash
	#SBATCH --partition=bigmem
	#SBATCH --nodes=1
	#SBATCH --ntasks-per-node=24
	#SBATCH --time=1:00:00
	#SBATCH --job-name=mrbayes_cpu
	#SBATCH -o result_%N_%j.out
	#SBATCH -e result_%N_%j.err

	export SBATCH_EXPORT=NONE
	export OMP_NUM_THREADS=1

	module load mrbayes/3.2.7_gcc-7.4.0

	mpirun -np $SLURM_NTASKS mb primates-gtr-gamma.nex


References
------------

- https://nbisweden.github.io/MrBayes/download.html


:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
