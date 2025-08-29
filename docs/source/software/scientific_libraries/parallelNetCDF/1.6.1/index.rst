.. _parallelNetCDF-1.6.1-index:

ParallelNetCDF 1.6.1
====================

.. contents:: Table of Contents


Basic information
-----------------

- **Official Website:** http://cucis.ece.northwestern.edu/projects/PnetCDF/
- **License:** Copyright (c) 2003 Northwertern University and Argonne National Laboratory. All rights reserved.
- **Installed on:** Apolo II and Cronos
- **Installation date:** 13/02/2018

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GNU GCC >= 5.5.0
    * MPICH2 >= 3.2.1

Installation
------------

#. Load required modules.

   .. code-block:: bash

     module purge
     module load gcc/5.5.0
     module load mpich2/3.2.1_gcc-5.5.0

#. Configure the following environment variables that specify the compilers to use:

    .. code-block:: bash

        $ export F77=mpif90
        $ export CFLAGS='-O2 -fPIC'
        $ export CXXFLAGS='-O2 -fPIC'
        $ export FFLAGS='-fPIC'
        $ export FCFLAGS='-fPIC'
        $ export FLDFLAGS='-fPIC'
        $ export F90LDFLAGS='-fPIC'
        $ export LDFLAGS='-fPIC'

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/pnetcdf/src/
        wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-1.6.1.tar.gz
        tar -xvf parallel-netcdf-1.6.1.tar.gz

#. After unpacking Parallel NetCDF, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd parallel-netcdf-1.6.1

        ./configure --prefix=/share/apps/pnetcdf/1.6.1/gcc-5.5.0_mpich2-3.2.1 --build=x86_64-redhat-linux --enable-fortran --enable-largefile --with-mpi=/share/apps/mpich2/3.2.1/gcc-5.5.0 2&1 | tee pnetcdf-conf.log
        make -j 10 2>&1 | tee pnetcdf-make.log
        make check 2>&1 | tee pnetcdf-make-check.log
        sudo mkdir -p /share/apps/pnetcdf/1.6.1/gcc-5.5.0_mpich2-3.2.1
        sudo chown -R mgomezzul.apolo /share/apps/pnetcdf/1.6.1/gcc-5.5.0_mpich2-3.2.1
        make install 2>&1 | tee pnetcdf-make-install.log
        sudo chown -R root.root /share/apps/pnetcdf/1.6.1/gcc-5.5.0_mpich2-3.2.1

#. Generate the module with the following environment variable:

    .. code-block:: bash

         setenv          PNET                    $topdir
         sudo moduleGenerator


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load pnetcdf/1.6.1_gcc-5.5.0_mpich2-3.2.1
        ##
        ## /share/apps/modules/pnetcdf/1.6.1_gcc-5.5.0_mpich2-3.2.1
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using pnetcdf-1.6.1\
                        \nin the shared directory \
                        \n/share/apps/pnetcdf/1.6.1/gcc-5.5.0_mpich2-3.2.1\
                        \nbuilded with gcc-5.5.0 and mpich2-3.2.1."
        }

        module-whatis "(Name________) pnetcdf"
        module-whatis "(Version_____) 1.6.1"
        module-whatis "(Compilers___) gcc-5.5.0_mpich2-3.2.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/pnetcdf/1.6.1/gcc-5.5.0_mpich2-3.2.1
        set         version       1.6.1
        set         sys           x86_64-redhat-linux

        conflict pnetcdf
        module load mpich2/3.2.1_gcc-5.5.0

        setenv          PNET                    $topdir

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

Use
---
    .. code-block:: bash

        module load pnetcdf/1.6.1_gcc-5.5.0_mpich2-3.2.1

Resources
---------

 * http://cucis.ece.northwestern.edu/projects/PnetCDF/download.html


Author
------
 * Andrés Felipe Zapata Palacio
