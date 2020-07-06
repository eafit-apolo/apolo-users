.. _v5.4.4intelindex:

.. contents:: Table of Contents

******************
VASP/5.4.4 INTEL
******************

- **Installation date:** 27/07/2017
- **URL:** https://www.vasp.at/
- **Apolo version:** Apolo II
- **License:**  VASP is not public-domain or share-ware, and will be distributed only after a license contract has been signed. Please visit VASP homepage to know more details on obtaining the license.


Dependencies
-------------

- Intel Parallel Studio XE Cluster Edition >= 2017-U1

Installation
-------------

After solving the aforementioned dependencies, you can proceed with the installation.

1. Download the binaries

.. code-block:: bash

    tar -zxvf vasp.5.4.4.tar.gz
    cd vasp.5.4.4

2. Compilation (makefile)

.. code-block:: bash

    cp arch/makefile.include.linux_intel ./makefile.include

It should look like the following:

.. code-block:: bash

    # Precompiler options
    CPP_OPTIONS= -DHOST=\"LinuxIFC\"\
                 -DMPI -DMPI_BLOCK=64000 \
                 -DIFC -DPGF90 -DNGZhalf -DMKL_ILP64 \
             -Duse_collective \
                 -DscaLAPACK \
                 -DCACHE_SIZE=32000 \
                 -Davoidalloc \
                 -Duse_bse_te \
                 -Dtbdyn \
                 -Duse_shmem

    CPP        = fpp -f_com=no -free -w0  $*$(FUFFIX) $*$(SUFFIX) $(CPP_OPTIONS)

    FC         = mpiifort
    FCL        = mpiifort -mkl=cluster -lstdc++

    FREE       = -free -names lowerc

    ase

    FFLAGS     = -FR -names lowercase -assume byterecl -I$(MKLROOT)/include/fftw -w
    OFLAG      = -O3 -xCORE-AVX2
    OFLAG_IN   = $(OFLAG)
    DEBUG      = -O0

    MKL_PATH   = $(MKLROOT)/lib/intel64
    BLAS       = -mkl=cluster
    LAPACK     =
    BLACS      =
    SCALAPACK  =

    OBJECTS    = fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d.o

    INCS       =-I$(MKLROOT)/include/fftw

    LLIBS      = $(SCALAPACK) $(LAPACK) $(BLAS)


    OBJECTS_O1 += fftw3d.o fftmpi.o fftmpiw.o
    OBJECTS_O2 += fft3dlib.o

    # For what used to be vasp.5.lib
    CPP_LIB    = $(CPP)
    FC_LIB     = $(FC)
    CC_LIB     = icc
    CFLAGS_LIB = -O
    FFLAGS_LIB = -O1
    FREE_LIB   = $(FREE)

    OBJECTS_LIB= linpack_double.o getshmem.o

    # For the parser library
    CXX_PARS   = icpc

    LIBS       += parser
    LLIBS      += -Lparser -lparser -lstdc++

    # Normally no need to change this
    SRCDIR     = ../../src
    BINDIR     = ../../bin

    #================================================
    # GPU Stuff

    CPP_GPU    = -DCUDA_GPU -DRPROMU_CPROJ_OVERLAP -DUSE_PINNED_MEMORY -DCUFFT_MIN=28 -UscaLAPACK

    OBJECTS_GPU = fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d_gpu.o fftmpiw_gpu.o

    CC         = icc
    CXX        = icpc
    CFLAGS     = -fPIC -DADD_ -Wall -openmp -DMAGMA_WITH_MKL -DMAGMA_SETAFFINITY -DGPUSHMEM=300 -DHAVE_CUBLAS

    CUDA_ROOT  ?= /usr/local/cuda/
    NVCC       := $(CUDA_ROOT)/bin/nvcc -ccbin=icc
    CUDA_LIB   := -L$(CUDA_ROOT)/lib64 -lnvToolsExt -lcudart -lcuda -lcufft -lcublas

    GENCODE_ARCH    := -gencode=arch=compute_30,code=\"sm_30,compute_30\" \
                       -gencode=arch=compute_35,code=\"sm_35,compute_35\" \
                       -gencode=arch=compute_60,code=\"sm_60,compute_60\"

    MPI_INC    = $(I_MPI_ROOT)/include64/

3. Compilation

.. code-block:: bash

    module load intel/2017_update-1 mkl/2017_update-1 impi/2017_update-1
    make all 2>&1 | tee vasp-make.log

Module
-------

.. code-block:: bash

    #%Module1.0####################################################################
    ##
    ## module load vasp/5.4.4_intel_17.0.1
    ##
    ## /share/apps/modules/vasp/5.4.4_intel_17.0.1
    ## Written by Mateo Gómez-Zuluaga
    ##

    proc ModulesHelp {} {
         global version modroot
         puts stderr "Sets the environment for using VASP 5.4.4\
              \nin the shared directory /share/apps/vasp/5.4.4/intel_17.0.1\
              \nbuilded with Intel Parallel Studio XE Cluster Edition 2017 Update 1."
    }

    module-whatis "(Name________) vasp"
    module-whatis "(Version_____) 5.4.4"
    module-whatis "(Compilers___) intel_17.0.1"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) mkl"

    # for Tcl script use only
    set         topdir        /share/apps/vasp/5.4.4/intel_17.0.1
    set         version       5.4.4
    set         sys           x86_64-redhat-linux

    conflict vasp

    module load intel/2017_update-1
    module load impi/2017_update-1
    module load mkl/2017_update-1

    prepend-path	PATH			$topdir/bin


Usage mode
------------

.. code-block:: bash

    module load trinity/2.4.0_intel-2017_update-1


References
-----------

- README
- https://software.intel.com/en-us/articles/building-vasp-with-intel-mkl-and-intel-compilers
- http://cms.mpi.univie.ac.at/wiki/index.php/Installing_VASP#For_vasp.5.4.1.24Jun15
- http://cms.mpi.univie.ac.at/wiki/index.php/Installing_VASP

Author
-------

- Mateo Gómez Zuluaga
