.. _muscle-3.8.1551-index:


MUSCLE 3.8.1551
===============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.drive5.com/muscle/
- **License:** Open source
- **Installed on:** Apolo II and Cronos
- **Installation date:** 20/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * g++ >= 4.9.4



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/muscle/gcc
        http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_src.tar.gz
        tar -zxvf muscle3.8.31_src.tar.gz


#. Do the following changes in the Makefile inside the unpacked directory:

    .. code-block:: bash

        cd muscle3.8.31/src/
        emacs mk
        ...
        # mateo
        g++ $ENV_GCC_OPTS -c -O3 -march=native -mfpmath=sse -D_FILE_OFFSET_BITS=64 -DNDEBUG=1 $CPPName.cpp -o $CPPName.o  >> muscle.make.stdout.txt 2>> muscle.make.stderr.txt
        ...

#. Compilation:

    .. code-block:: bash

        module load gcc/4.9.4
        make

#. Install MUSCLE:

    .. code-block:: bash

        sudo mkdir -p /share/apps/muscle/gcc/4.9.4/bin
        sudo cp  muscle /share/apps/muscle/gcc/4.9.4/bin



Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module muscle/3.8.31_gcc-4.9.4
        ##
        ## /share/apps/modules/muscle/3.8.31_gcc-4.9.4     Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tmuscle/3.8.31_gcc-4.9.4 - sets the Environment for MUSCLE 3.8.31 in \
            \n\tthe share directory /share/apps/muscle/3.8.31/gcc/4.9.4\n"
        }

        module-whatis "\n\n\tSets the environment for using MUSCLE 3.8.31 \
                    \n\tbuilded with GNU GCC 4.9.4\n"

        # for Tcl script use only
        set       topdir     /share/apps/muscle/3.8.31/gcc/4.9.4
        set       version    3.8.31
        set       sys        x86_64-redhat-linux

        module load gcc/4.9.4

        prepend-path PATH    $topdir/bin


Use
---

Slurm template
~~~~~~~~~~~~~~

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --ntasks-per-node=32
        #SBATCH --time=1:00:00
        #SBATCH --job-name=muscle
        #SBATCH -o result_%N_%j.out
        #SBATCH -e result_%N_%j.err

        export SBATCH_EXPORT=NONE
        export OMP_NUM_THREADS=1

        module load muscle/3.8.31

        muscle xxx



Resources
---------
 * http://www.drive5.com/muscle/


Author
------
    * Mateo Gómez Zuluaga
