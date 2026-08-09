.. _gromacs-2026.1-index:

.. role:: bash(code)
   :language: bash

GROMACS 2026.1
==============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://manual.gromacs.org/documentation/
- **License:** GNU Lesser General Public License (LGPL), version 2.1.
- **Apolo version:** Apolo III


Dependencies
------------

- Intel >= 2024.0.0
- Mkl >= 2025.2
- Cuda >= 12.5
- Ucx >= 1.18.0
- Cmake >= 4.0.0

Use the that environment variable for compile Gromacs

   .. code-block:: bash

        $ export CUDAHOSTCXX=/usr/bin/g+++

Installation
------------

The following procedure present the way to compile **GROMACS 2026.1**
for parallel computing using the GROMACS built-in thread-MPI and CUDA. [1]_

#. Download the latest version of GROMACS

   .. code-block:: bash

        $ wget http://ftp.gromacs.org/pub/gromacs/gromacs-2026.1.tar.gz
        $ tar -xzf gromacs-2026.1.tar.gz

#. Inside the folder, on the top create a :file:`build` directory where the installation binaries will be put by cmake.

   .. code-block:: bash

        $ cd gromacs-2021.1
        $ mkdir build
        $ cd build

#. Load the necessary swap and modules for the building.

   .. code-block:: bash

        $ module swap genu14 intel/2024.0.0

        $ module load cmake/4.0.0 \
                      cuda/12.5 \
                      mkl/2025.2 \
                      ucx/1.20.0

#. Execute the cmake command with the desired directives.

   .. code-block:: bash
        $ cmake ..  -DCMAKE_C_COMPILER=icx -DCMAKE_CXX_COMPILER=icpx -DGMX_GPU=CUDA \
                    -DCUDA_TOOLKIT_ROOT_DIR=/opt/ohpc/pub/apps/cuda \
                    -DGMX_FFT_LIBRARY=mkl -DCMAKE_PREFIX_PATH=$MKLROOT -DGMX_MPI=ON \
                    -DCMAKE_INSTALL_PREFIX=$HOME/gromacs-2026.1-intel


#. Execute the make commands sequence.

   .. code-block:: bash

        $ make -j <N>
        $ make check
        $ make -j <N> install

   .. warning:: Some tests may fail, but the installation can continue depending on the number of failed tests.


Create module
-------------

.. code-block:: bash


        -- gromacs-2026.1


        whatis(--[[
            Name:        GROMACS
            Version:     2026.1
            Compilado:   GNU 12.2.0, CUDA 12.5
        ]])

        help([[

        Gromacs is a free, open-source, high-performance software
        suite used for molecular dynamics simulations

        ]])

        -- Variables internas
        local base    = "/opt/ohpc/pub/apps/gromacs-2026.1-intel"
        local version = "2026.1"

        -- Swap
        unload("gnu14")
        load("intel/2024.0.0")
        load("openmpi5/5.0.7")
        load("cuda/12.5")

        -- Rutas
        prepend_path("PATH",             base .. "/bin")
        prepend_path("LD_LIBRARY_PATH",  base .. "/lib64")
        prepend_path("LIBRARY_PATH",     base .. "/lib64")
        prepend_path("LD_RUN_PATH",      base .. "/lib64")
        prepend_path("C_INCLUDE_PATH",   base .. "/include")
        prepend_path("CXX_INCLUDE_PATH", base .. "/include")
        prepend_path("CPLUS_INCLUDE_PATH", base .. "/include")
        prepend_path("PKG_CONFIG_PATH",  base .. "/lib64/pkgconfig")
        prepend_path("MANPATH",          base .. "/share/man/man1")

        -- Variables propias de GROMACS
        setenv("GMXDATA",  base .. "/share/gromacs")
        setenv("GMXBIN",   base .. "/bin")
        setenv("GMXMAN",   base .. "/share/man/man1")
        setenv("GMXLDLIB", base .. "/lib64")
        setenv("GMX_FORCE_GPU_AWARE_MPI", "1")


Load the module

Usage
-----

This section describes a way to submit jobs with the resource manager SLURM.

#. Load the necessary environment.

   .. code-block:: bash

      # Apolo
      $ module load gromacs/v2026.1-intel


References
----------

- https://manual-gromacs-org.translate.goog/current/install-guide/index.html?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=tc

Authors
-------

- David Julian Oviedo Betancur <djoviedob@eafit.edu.co>
