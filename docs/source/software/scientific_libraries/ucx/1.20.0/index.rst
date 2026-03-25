.. _1.20.0uxc-index:


UCX 1.20.0
===========

.. content:: Table of contents


Basic information
-----------------

- **Official Website:** https://openucx.org/
- **License:** BSD 3-Clause
- **Installed on:** Apolo II
- **Installation date:** 27/04/2026

Tested on (Requirements)
------------------------

* **OS base:** Rocky Linux (x86_64) :math:\boldsymbol{\ge} 8.5
* **Dependencies:**
    * Intel oneAPI (icx/icpx) :math:`\boldsymbol{\ge}` 2024.0.0
    * CUDA :math:`\boldsymbol{\ge}` 12.5
    * NVIDIA Mellanox OFED :math:`\boldsymbol{\ge}` 5.0



Prerequisites
-------------
- Intel oneAPI
- Cuda

Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module swap gnu14 intel/2024.0.0
        $ module load cuda/12.5
2. Download the desired version of the software

    .. code-block:: bash

        $ wget https://github.com/openucx/ucx/releases/download/v1.20.0/ucx-1.20.0.tar.gz
        $ tar -xzf ucx-1.20.0.tar.gz

3. Move to the decompressed directory

    .. code-block:: bash

        $ cd ucx-1.20.0/

4. Export the necessary variables and configure:

    .. code-block:: bash


        ./configure

        --prefix=/opt/ohpc/pub/mpi/ucx-cuda/1.20.0

        --libdir=/opt/ohpc/pub/mpi/ucx-cuda/1.20.0/lib

        --disable-optimizations

        --disable-logging

        --disable-debug

        --disable-assertions

        --disable-params-check

        --enable-cma

        --with-cuda=/opt/ohpc/pub/apps/cuda

        --without-gdrcopy

        --with-verbs

        --with-rdmacm

        --without-knem

        --without-rocm

        --without-xpmem

        --without-ugni

        --without-java

5. Compile and install:

    .. code-block:: bash

        $ make -j32
        $ make install


Module
------
    .. code-block:: tcl

        #%Module1.0#####################################################################

        proc ModulesHelp { } {

        puts stderr " "
        puts stderr "This module loads the UCX library."
        puts stderr "\nVersion 1.20.0\n"

        }
        module-whatis "Name: ucx"
        module-whatis "Version: 1.20.0"
        module-whatis "Category: runtime library"
        module-whatis "Description: UCX is a communication library implementing high-performance messaging"
        module-whatis "URL: http://www.openucx.org"

        set     version			    1.20.0

        prepend-path    PATH                /opt/ohpc/pub/mpi/ucx-ohpc/1.20.0/bin
        prepend-path	LD_LIBRARY_PATH	    /opt/ohpc/pub/mpi/ucx-ohpc/1.20.0/lib
        prepend-path    PKG_CONFIG_PATH     /opt/ohpc/pub/mpi/ucx-ohpc/1.20.0/lib/pkgconfig

        setenv          UCX_DIR        /opt/ohpc/pub/mpi/ucx-ohpc/1.20.0
        setenv          UCX_BIN        /opt/ohpc/pub/mpi/ucx-ohpc/1.20.0/bin
        setenv          UCX_LIB        /opt/ohpc/pub/mpi/ucx-ohpc/1.20.0/lib
        setenv          UCX_INC        /opt/ohpc/pub/mpi/ucx-ohpc/1.20.0/include
        setenv          UCX_WARN_UNUSED_ENV_VARS N

How to use
----------

    .. code-block:: bash

        $ module load ucx/1.20.0

:Authors:

- Juan José Duque
