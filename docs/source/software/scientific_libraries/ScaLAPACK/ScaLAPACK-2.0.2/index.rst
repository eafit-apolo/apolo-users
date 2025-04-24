.. _ScaLAPACK-2.0.2:

ScaLAPACK 2.0.2
===============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 13/02/2018
- **Official Website:** http://www.netlib.org/scalapack/
- **Supercomputer:** Cronos
- **License:** Modified BSD License

Dependencies
------------

- OpenBLAS 0.2.20 (Includes BLAS and openBLAS)
- BLACS (Included in ScaLAPACK)

Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module purge
        $ module load openblas/0.2.20_gcc-5.5.0

2. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/mgomezzul/apps/mpc/src/
        $ wget http://www.netlib.org/scalapack/scalapack.tgz
        $ tar -xvf scalapack.tgz

3. After unzipping **ScaLAPACK**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd scalapack-2.0.2
        $ cp SLmake.inc.example SLmake.inc

We edit the following variables to specify the BLAS and LAPACK paths, in our case both are included in the openBLAS directory:

    .. code-block:: bash

        BLASLIB       = -L/share/apps/openblas/0.2.20/gcc-5.5.0/lib -lopenblas
        LAPACKLIB     =
        LIBS          = $(LAPACKLIB) $(BLASLIB)

The file should look like this:

    .. code-block:: bash

        ############################################################################
        #
        #  Program:         ScaLAPACK
        #
        #  Module:          SLmake.inc
        #
        #  Purpose:         Top-level Definitions
        #
        #  Creation date:   February 15, 2000
        #
        #  Modified:        October 13, 2011
        #
        #  Send bug reports, comments or suggestions to scalapack@cs.utk.edu
        #
        ############################################################################
        #
        #  C preprocessor definitions:  set CDEFS to one of the following:
        #
        #     -DNoChange (fortran subprogram names are lower case without any suffix)
        #     -DUpCase   (fortran subprogram names are upper case without any suffix)
        #     -DAdd_     (fortran subprogram names are lower case with "_" appended)

        CDEFS         = -DAdd_

        #
        #  The fortran and C compilers, loaders, and their flags
        #

        FC            = mpif90
        CC            = mpicc
        NOOPT         = -O0
        FCFLAGS       = -O3
        CCFLAGS       = -O3
        FCLOADER      = $(FC)
        CCLOADER      = $(CC)
        FCLOADFLAGS   = $(FCFLAGS)
        CCLOADFLAGS   = $(CCFLAGS)

        #
        #  The archiver and the flag(s) to use when building archive (library)
        #  Also the ranlib routine.  If your system has no ranlib, set RANLIB = echo
        #

        ARCH          = ar
        ARCHFLAGS     = cr
        RANLIB        = ranlib

        #
        #  The name of the ScaLAPACK library to be created
        #

        SCALAPACKLIB  = libscalapack.a

        #
        #  BLAS, LAPACK (and possibly other) libraries needed for linking test programs
        #

        BLASLIB       = -L/share/apps/openblas/0.2.20/gcc-5.5.0/lib -lopenblas
        LAPACKLIB     =
        LIBS          = $(LAPACKLIB) $(BLASLIB)

4. We proceed to compile the library

    .. code-block:: bash

        make all 2>&1 | tee scalapack-make.log

5. Once the **libscalapack.a** library is generated in the current directory create the directory in which it will be located and copy it there

    .. code-block:: bash

        $ sudo mkdir -p /share/apps/scalapack/2.0.2/gcc-5.5.0/lib
        $ sudo chown -R mgomezzul.apolo /share/apps/scalapack/2.0.2/gcc-5.5.0/lib
        $ cp libscalapack.a /share/apps/scalapack/2.0.2/gcc-5.5.0/lib
        $ sudo chown -R root.root /share/apps/scalapack/2.0.2/gcc-5.5.0/lib

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load scalapack/2.0.2_gcc-5.5.0
        ##
        ## /share/apps/modules/scalapack/2.0.2_gcc-5.5.0
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using ScaLAPACK 2.0.2\
                        \nin the shared directory /share/apps/scalapack/2.0.2/gcc-5.5.0\
                        \nbuilded with gcc-5.5.0, openmpi-1.10.7 and openBLAS-0.2.20."
        }

        module-whatis "(Name________) scalapack"
        module-whatis "(Version_____) 2.0.2"
        module-whatis "(Compilers___) gcc-5.5.0_openmpi-1.10.7"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) openBLAS-0.2.20"

        # for Tcl script use only
        set         topdir        /share/apps/scalapack/2.0.2/gcc-5.5.0
        set         version       2.0.2
        set         sys           x86_64-redhat-linux

        conflict scalapack
        module load openmpi/1.10.7_gcc-5.5.0
        module load openblas/0.2.20_gcc-5.5.0

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib


Mode of use
-----------

    .. code-block:: bash

        $ module load scalapack/2.0.2_gcc-5.5.0

References
----------

.. [1] http://www.netlib.org/scalapack/scalapack.tgz
