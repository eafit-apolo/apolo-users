.. _garli.2.01:

***********
Garli 2.01
***********

- **Installation date:** 06/02/2017
- **URL:** http://phylo.bio.ku.edu/slides/GarliDemo/garliExercise.Evolution2014.html
- **Apolo version:** Apolo II
- **License:** GNU GENERAL PUBLIC LICENSE Version 3

.. contents:: Table of Contents

Dependencies
-------------

- Ncl
- Intel compiler (C y C++)
- Intel MPI (C y C++)

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/garli/garli-2.01.tar.gz
    tar -zxvf garli-2.01.tar.gz


#. compilation config and editing the makefile

.. code-block:: bash

    cd garli-2.01
    module load ncl/2.1.18_intel-2017_update-1
    module load impi/2017_update-1
    ./configure --prefix=/share/apps/garli/2.0.1/intel_impi/2017_update-1  --build=x86_64-redhat-linux --enable-mpi --with-ncl=/share/apps/ncl/2.1.18/intel/2017_update-1 2>&1 | tee garli-conf.log
    make 2>&1 | tee garli-make.log
    make install 2>&1 | tee garli-make-install.log

Module
---------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module garli/2.01_intel_impi-2017_update-1
    ##
    ## /share/apps/modules/garli/2.01_intel_impi-2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tgarli/2.01_intel_impi-2017_update-1 - sets the Environment for Garli in \
        \n\tthe share directory /share/apps/garli/2.0.1/intel_impi/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using Garli 2.01 \
                   \n\tbuilded with Intel Parallel Studio XE 2017\n"

    # for Tcl script use only
    set       topdir     /share/apps/garli/2.0.1/intel_impi/2017_update-1
    set       version    2.0.1
    set       sys        x86_64-redhat-linux

    module load ncl/2.1.18_intel-2017_update-1
    module load impi/2017_update-1

    prepend-path PATH    $topdir/bin

Slurm template
----------------

.. code-block:: bash

    #!/bin/bash
    #SBATCH --partition=bigmem
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=24
    #SBATCH --time=1:00:00
    #SBATCH --job-name=garli_example
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err

    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load garli/2.01_intel_impi-2017_update-1

    srun Garli $SLURM_NTASKS garli.conf

References
------------

- manual

Author
------

- Mateo Gómez Zuluaga
