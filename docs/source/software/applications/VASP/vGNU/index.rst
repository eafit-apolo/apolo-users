.. _v5.4.4gnuindex:

.. contents:: Table of Contents

****************
VASP/5.4.4 GNU
****************

- **Installation date:** 27/07/2017
- **URL:** https://www.vasp.at/
- **Apolo version:** Apolo II
- **License:**  VASP is not public-domain or share-ware, and will be distributed only after a license contract has been signed. Please visit VASP homepage to know more details on obtaining the license.


Dependencies
-------------

- FFTW 3.3.7
- OpenBLAS 0.2.20 (with BLAS y LAPACK)
- ScaLapack 2.0.2
- OpenMPI 1.10.7

Installation
-------------

After solving the aforementioned dependencies, you can proceed with the installation.

1. Download the binaries

.. code-block:: bash

    module load openmpi/1.10.7_gcc-5.5.0
    module load fftw/3.3.7_gcc-5.5.0
    module load openblas/0.2.20_gcc-5.5.0
    module load scalapack/2.0.2_gcc-5.5.0
    tar -zxvf vasp.5.4.4.tar.gz
    cd vasp.5.4.4

2. Compilation (makefile), modify makefile.include

.. code-block:: bash

    cp arch/makefile.include.linux_gnu ./makefile.include

It should look like the following:

.. code-block:: bash

     ...
     CPP        = gcc -E -P $*$(FUFFIX) >$*$(SUFFIX) $(CPP_OPTIONS)
     ...
     OFLAG      = -O3 -march=native
     ...
     LIBDIR     =
     BLAS       = -L/share/apps/openblas/0.2.20/gcc-5.5.0/lib -lopenblas
     LAPACK     =
     BLACS      =
     SCALAPACK  = -L/share/apps/scalapack/2.0.2/gcc-5.5.0/lib -lscalapack
     ...
     FFTW      ?= /share/apps/fftw/3.3.7/gcc-5.5.0
     ...
     MPI_INC    = share/apps/openmpi/1.10.7/gcc-5.5.0/include

And

.. code-block:: bash

    # Precompiler options
    CPP_OPTIONS= -DHOST=\"LinuxGNU\" \
                 -DMPI -DMPI_BLOCK=8000 \
                 -Duse_collective \
                 -DscaLAPACK \
                 -DCACHE_SIZE=4000 \
                 -Davoidalloc \
                 -Duse_bse_te \
                 -Dtbdyn \
                 -Duse_shmem

    CPP        = gcc -E -P $*$(FUFFIX) >$*$(SUFFIX) $(CPP_OPTIONS)

    FC         = mpif90
    FCL        = mpif90

    FREE       = -ffree-form -ffree-line-length-none

    FFLAGS     =
    OFLAG      = -O3 -march=native
    OFLAG_IN   = $(OFLAG)
    DEBUG      = -O0

    LIBDIR     =
    BLAS       = -L/share/apps/openblas/0.2.20/gcc-5.5.0/lib -lopenblas
    LAPACK     =
    BLACS      =
    SCALAPACK  = -L/share/apps/scalapack/2.0.2/gcc-5.5.0/lib -lscalapack

    LLIBS      = $(SCALAPACK) $(LAPACK) $(BLAS)

    FFTW       ?= /share/apps/fftw/3.3.7/gcc-5.5.0
    LLIBS      += -L$(FFTW)/lib -lfftw3
    INCS       = -I$(FFTW)/include

    OBJECTS    = fftmpiw.o fftmpi_map.o  fftw3d.o  fft3dlib.o

    OBJECTS_O1 += fftw3d.o fftmpi.o fftmpiw.o
    OBJECTS_O2 += fft3dlib.o

    # For what used to be vasp.5.lib
    CPP_LIB    = $(CPP)
    FC_LIB     = $(FC)
    CC_LIB     = gcc
    CFLAGS_LIB = -O
    FFLAGS_LIB = -O1
    FREE_LIB   = $(FREE)

    OBJECTS_LIB= linpack_double.o getshmem.o

    # For the parser library
    CXX_PARS   = g++

    LIBS       += parser
    LLIBS      += -Lparser -lparser -lstdc++

    # Normally no need to change this
    SRCDIR     = ../../src
    BINDIR     = ../../bin

    #================================================
    # GPU Stuff

    CPP_GPU    = -DCUDA_GPU -DRPROMU_CPROJ_OVERLAP -DCUFFT_MIN=28 -UscaLAPACK # -DUSE_PINNED_MEMORY

    OBJECTS_GPU= fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d_gpu.o fftmpiw_gpu.o

    CC         = gcc
    CXX        = g++
    CFLAGS     = -fPIC -DADD_ -openmp -DMAGMA_WITH_MKL -DMAGMA_SETAFFINITY -DGPUSHMEM=300 -DHAVE_CUBLAS

    CUDA_ROOT  ?= /usr/local/cuda
    NVCC       := $(CUDA_ROOT)/bin/nvcc
    CUDA_LIB   := -L$(CUDA_ROOT)/lib64 -lnvToolsExt -lcudart -lcuda -lcufft -lcublas

    GENCODE_ARCH    := -gencode=arch=compute_30,code=\"sm_30,compute_30\" \
                       -gencode=arch=compute_35,code=\"sm_35,compute_35\" \
                       -gencode=arch=compute_60,code=\"sm_60,compute_60\"

    MPI_INC    = /share/apps/openmpi/1.10.7/gcc-5.5.0/include

3. Compilation

.. code-block:: bash

    make all 2>&1 | tee vasp-make.log

Module
-------

.. code-block:: bash

    #%Module1.0####################################################################
    ##
    ## module load vasp/5.4.4_gcc-5.5.0
    ##
    ## /share/apps/modules/vasp/5.4.4_gcc-5.5.0
    ## Written by Andrés Felipe Zapata Palacio
    ##

    proc ModulesHelp {} {
         global version modroot
         puts stderr "Sets the environment for using vasp 5.4.4\
                      \nin the shared directory \
                      \n/share/apps/vasp/5.4.4/gcc-5.5.0/\
                      \nbuilded with gcc-5.5.0"
    }

    module-whatis "(Name________) vasp"
    module-whatis "(Version_____) 5.4.4"
    module-whatis "(Compilers___) gcc-5.5.0"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) fftw-3.3.7, openblas-0.2.20, openmpi-1.10.7, scaLapack-2.0.2"

    # for Tcl script use only
    set         topdir        /share/apps/vasp/5.4.4/gcc-5.5.0/
    set         version       5.4.4
    set         sys           x86_64-redhat-linux

    conflict vasp
    module load openmpi/1.10.7_gcc-5.5.0
    module load fftw/3.3.7_gcc-5.5.0
    module load openblas/0.2.20_gcc-5.5.0
    module load scalapack/2.0.2_gcc-5.5.0

    prepend-path    PATH                    $topdir/bin

Usage mode
------------

.. code-block:: bash

    module load vasp/5.4.4_gcc-5.5.0


References
-----------

- http://www.ivofilot.nl/posts/view/28/How+to+build+VASP+5.3.5+using+the+GNU+compiler+on+Linux+Ubuntu+14.04+LTS

Author
--------

- Andrés Felipe Zapata Palacio
