.. _poly:

*****
POLY
*****

- **Installation date:** 19/09/2016
- **URL:** http://www.ccp5.ac.uk/DL_POLY_CLASSIC/
- **Apolo version:** Apolo I
- **License:** BSD licence

.. contents:: Table of Contents

Dependencies
--------------

- GNU GCC - gcc, gfortran >= 4.8.4
- MPI - openMPI (mpif90) >= 1.6.5

Installation
------------

#. First download the tar from the main page from https://gitlab.com/DL_POLY_Classic/dl_poly, then:

   .. code-block:: bash

      $ cd /home/mgomezzul/apps/dl_poly_classic/dl_class
      $ wget https://gitlab.com/DL_POLY_Classic/dl_poly/-/archive/RELEASE-1-10/dl_poly-RELEASE-1-10.tar.gz
      $ tar -zxvf dl_poly-RELEASE-1-10.tar.gz

#. configure the makefile

   .. code-block:: bash

      $ cd dl_class
      $ cp build/MakePAR
      $ cd source
      $ module load openmpi/1.6.5_gcc-4.8.4
      $ make gfortran

   .. note::

      This process was made with version 1.9, but these resources were removed so URLs refers to version 1.10, somethings could change in that version

Module
---------

   .. code-block:: bash

       #%Module1.0#####################################################################
       ##
       ## modules dl_class/1.9_openmpi-1.6.5_gcc-4.8.4
       ##
       ## /share/apps/modules/dl_class/1.9_openmpi-1.6.5_gcc-4.8.4
       ## Written by Mateo Gomez-Zuluaga
       ##

       proc ModulesHelp { } {
           puts stderr "\tdl_classic/1.9_openmpi-1.6.5_gcc-4.8.4 - sets the
           \n\tEnvironment for DL_POLY Classic in the share directory
           \n\t/share/apps/dl_class/1.9/openmpi-1.6.5/gcc-4.8.4\n"
       }

       module-whatis "\n\n\tSets the environment for using DL_POLY Classic 1.9 \
                      \n\tbuilded with openMPI 1.6.5 and GCC 4.8.4 version\n"

       # for Tcl script use only
       set       topdir     /share/apps/dl_class/1.9/openmpi-1.6.5/gcc-4.8.4
       set       version    1.9
       set       sys        x86_64-redhat-linux

       module load openmpi/1.6.5_gcc-4.8.4

       prepend-path    PATH $topdir/bin


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

Usage mode
-----------

   .. code-block:: bash

      $ module load dl_class/1.9_openmpi-1.6.5_gcc-4.8.4

References
------------

- Mail from the people of the University of Cartagena
- Manual within the software package

Author
------

- Mateo Gómez Zuluaga
