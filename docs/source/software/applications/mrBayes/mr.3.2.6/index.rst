.. _mrbayes:

.. contents:: Table of Contents

*************
MrBayes 3.2.6
*************

- **Installation date:** 08/02/2017
- **URL:** http://mrbayes.sourceforge.net/index.php
- **Apolo version:** Apolo II
- **License:** GNU GENERAL PUBLIC LICENSE Version 3

Dependencies
-------------

- Beagle (CUDA or CPU version)
- Intel compiler (C y C++)
- Intel MPI (C y C++)

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    wget https://downloads.sourceforge.net/project/mrbayes/mrbayes/3.2.6/mrbayes-3.2.6.tar.gz?r=http%3A%2F%2Fmrbayes.sourceforge.net%2Fdownload.php&ts=1486584181&use_mirror=superb-dca2
    tar -zxvf mrbayes-3.2.6.tar.gz

#. Makefile config

.. code-block:: bash

    cd mrbayes-3.2.6
    module load beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1
    module load impi/2017_update-1
    ./configure --prefix=/share/apps/mrbayes/3.2.6/cuda/7.0/intel_impi/2017_update-1 --enable-mpi --enable-sse --with-beagle=/share/apps/beagle-lib/2.1.2/cuda/7.0/intel/2017_update-1 2>&1 | tee mrbayes-conf.log
    make 2>&1 | tee mrbayes-make.log

then

.. code-block:: bash

    sudo mkdir -p /share/apps/mrbayes/3.2.6/cuda/7.0/intel_impi/2017_update-1
    make install 2>&1 | tee mrbayes-make-install.log

#. CUDA SUPPORT

.. code-block:: bash

    cd /home/mgomezzul/apps/garli/intel
    wget https://downloads.sourceforge.net/project/mrbayes/mrbayes/3.2.6/mrbayes-3.2.6.tar.gz?r=http%3A%2F%2Fmrbayes.sourceforge.net%2Fdownload.php&ts=1486584181&use_mirror=superb-dca2
    tar -zxvf mrbayes-3.2.6.tar.gz

#. edit makefile

.. code-block:: bash

    cd mrbayes-3.2.6
    module load beagle-lib/2.1.2_intel-2017_update-1
    module load impi/2017_update-1
    ./configure --prefix=/share/apps/mrbayes/3.2.6/intel_impi/2017_update-1 --enable-mpi --enable-sse --with-beagle=/share/apps/beagle-lib/2.1.2/intel/2017_update-1 2>&1 | tee mrbayes-conf.log
    make 2>&1 | tee mrbayes-make.log


Module
---------

**CUDA**

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module mrbayes/3.2.6_cuda-7.0_intel-2017_update-1
    ##
    ## /share/apps/modules/mrbayes/3.2.6_cuda-7.0_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tzlib/1.2.11 - sets the Environment for MrBayes 3.2.6 in \
        \n\tthe share directory /share/apps/mrbayes/3.2.6/cuda/7.0/intel/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using MrBayes 3.2.6 \
                   \n\tbuilded with Intel Parallel Studio XE 2017 and CUDA 7.0\n"

    # for Tcl script use only
    set       topdir     /share/apps/mrbayes/3.2.6/cuda/7.0/intel_impi/2017_update-1
    set       version    3.2.6
    set       sys        x86_64-redhat-linux

    module load beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1
    module load impi/2017_update-1

    prepend-path PATH    $topdir/bin


**CPU**

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module mrbayes/3.2.6_intel-2017_update-1
    ##
    ## /share/apps/modules/mrbayes/3.2.6_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tmrbayes/3.2.6_intel-2017_update-1 - sets the Environment for MrBayes in \
        \n\tthe share directory /share/apps/mrbayes/3.2.6/intel/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using MrBayes 3.2.6 \
                   \n\tbuilded with Intel Parallel Studio XE 2017\n"

    # for Tcl script use only
    set       topdir     /share/apps/mrbayes/3.2.6/cuda/7.0/intel_impi/2017_update-1
    set       version    3.2.6
    set       sys        x86_64-redhat-linux

    module load beagle-lib/2.1.2_intel-2017_update-1
    module load impi/2017_update-1

    prepend-path PATH    $topdir/bin

usage mode
-----------

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

    module load mrbayes/3.2.6_cuda-7.0_intel_impi-2017_update-1

    mb concat_prot_corrected.nexus


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

    module load garli/2.01_intel_impi-2017_update-1

    srun -n $SLURM_NTASKS mb concat_prot_corrected.nexus

References
------------

- manual

Author
------

- Mateo Gómez Zuluaga
