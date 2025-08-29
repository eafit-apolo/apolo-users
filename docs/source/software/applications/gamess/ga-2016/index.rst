.. _ga-16:

************
GAMESS 2016
************

- **Installation date:** 13/03/2017
- **URL:** http://www.msg.ameslab.gov/GAMESS/
- **Apolo version:** Apolo II
- **License:** ACADEMIC LICENSE

.. contents:: Table of Contents

Dependencies
--------------

- Intel Parallel Studio XE Cluster Edition 2017 (Update 1)
- Intel Fortran and C compilers
- Intel MKL
- Intel MPI

Installation
------------

#. First download the tar from the main page, then:

.. code-block:: bash

    $ tar -zxvf gamess-current.tar.gz
    $ cd gamess/

#. Gamess configuration

.. code-block:: bash

    $ ./config

#. The above command is interactive, so it will ask several questions in the following

.. code-block:: bash

    Enter
    linux64
    /share/apps/gamess/2016-r1/intel_impi_mkl/2017_update-1
    /share/apps/gamess/2016-r1/intel_impi_mkl/2017_update-1
    00
    ifort
    17
    Enter
    mkl
    /share/apps/intel/ps_xe/2017_update-1/mkl
    proceed
     Enter
     Enter
    mpi
    impi
    /share/apps/intel/ps_xe/2017_update-1/impi/2017.1.132
    no


Module
---------

.. code-block:: bash

   #%Module1.0#####################################################################
    ##
    ## module load 2016-r1_intel_mkl_impi-2017_update-1
    ##
    ## /share/apps/modules/gamess/2016-r1_intel_mkl_impi-2017_update-1
    ##
    ## Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tgamess/2016-r1_intel_mkl_impi-2017_update-1 - sets the Environment for GAMESS 2016-R1 in \
        \n\tthe shared directory /share/apps/gamess/2016-r1/intel_impi_mkl/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for GAMESS 2016-R1 \
                  \n\tbuilded with Intel Parallel Studio XE Cluster Edition \n"

    # for Tcl script use only
    set       topdir     /share/apps/gamess/2016-r1/intel_impi_mkl/2017_update-1
    set       version    2016-r1
    set       sys        x86_64-redhat-linux

    conflict gamess

    module load intel/2017_update-1
    module load mkl/2017_update-1
    module load impi/2017_update-1

    prepend-path    PATH			$topdir


Use mode
----------

.. code-block:: bash

    #!/bin/sh
    #SBATCH --partition=bigmem
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=2
    #SBATCH --time=20:00
    #SBATCH --job-name=gamess
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err

    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load intel/2017_update-1 impi/2017_update-1 mkl/2017_update-1

    # Execution line
    rungms c2h6O2 00 $SLURM_NTASKS $SLURM_NTASKS_PER_NODE

References
------------
- https://software.intel.com/en-us/articles/building-gamess-with-intel-compilers-intel-mkl-and-intel-mpi-on-linux
- https://linuxcluster.wordpress.com/2010/05/18/building-the-gamess-with-intel%C2%AE-compilers-intel%C2%AE-mkl-and-openmpi-on-linux/
- https://www.webmo.net/support/gamess_linux.html
- http://myweb.liu.edu/~nmatsuna/gamess/tests

Author
------

- Mateo Gómez Zuluaga
