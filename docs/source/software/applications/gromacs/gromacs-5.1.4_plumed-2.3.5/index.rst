.. _gromacs-5.1.4.plumed-index:

.. role:: bash(code)
   :language: bash

GROMACS 5.1.4 PLUMED 2.3.5
===========================

- **Installation Date:** 14/06/2018
-  **URL:** http://www.gromacs.org/
- - **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **License:** GNU Lesser General Public License (LGPL), version 2.1.

.. contents:: Table of Contents

Dependencies
------------

- GNU GCC >= 5.4.0
- Mpich2 >= 3.2
- Python >= 2.7.15 (Miniconda)
- OpenBLAS >= 0.2.19
- CUDA >= 9.0 (have to include SDK)
- Plumed >= 2.3.5
- Boost >= 1.67.0

Installation
------------

After resolving the aforementioned dependencies, you can proceed with the installation of GROMACS.

#. Download the latest version of GROMACS

   .. code-block:: bash

      $ wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-5.1.4.tar.gz
      $ tar -zxvf gromacs-5.1.4.tar.gz

#. After unpacking GROMACS, we continue with the following configuration and compilation steps:

    .. note:: You have to load all the apps in the dependencies, or add them to the PATH, we are assuming that all is done

   .. code-block:: bash

        $ cd gromacs-5.4.1
        $ plumed patch -p --shared #select the fifth option
        $ mkdir build
        $ cd build

#. compile it

   .. code-block:: bash

        $ CC=mpicc CXX=mpicxx FC=mpif90 cmake .. -DGMX_GPU=ON -DCUDA_TOOLKIT_ROOT_DIR=/share/apps/cuda/9.0
            -DGMX_MPI=ON -DCMAKE_INSTALL_PREFIX=/share/apps/gromacs/5.1.4/gcc-5.4.0_plumed-2.3.5
            -DGMX_EXTERNAL_BLAS="/share/apps/openblas/0.2.19/gcc/5.4.0/lib/libopenblas.so"
            -DGMX_BUILD_OWN_FFTW=ON -DGMX_EXTERNAL_BOOST=ON
            -DBoost_INCLUDE_DIR="/share/apps/boost/1.67.0/gcc-5.4.0_mpich2-3.2/include"
            -DBoost_LIBRARY_DIRS="/share/apps/boost/1.67.0/gcc-5.4.0_mpich2-3.2/lib"
            -DBoost_DIR="/share/apps/boost/1.67.0/gcc-5.4.0_mpich2-3.2" -DNVML_INCLUDE_DIR=/share/apps/cuda/9.0/include
            -DCMAKE_BUILD_TYPE=Release -DGMX_BUILD_UNITTESTS=ON  -DREGRESSIONTEST_DOWNLOAD=ON  2>&1 | tee gromacs-cmake.log
        $ make 2>&1 | tee gromacs-make.log
        $ make check 2>&1 | tee gromacs-check.log
        $ make install 2>&1 | tee gromacs-make-install.log

Use mode
-------------
To run Gromacs + Plumed it is necessary to have the following files:
- plumed.dat
- md_1B2S_AA27K.tpr

**Definition of input files**

.. code-block:: bash

    # set up two variables for Phi and Psi dihedral angles
    phi: TORSION ATOMS=5,7,9,15
    psi: TORSION ATOMS=7,9,15,17
    #
    # Activate metadynamics in phi and psi
    # depositing a Gaussian every 500 time steps,
    # with height equal to 1.2 kJoule/mol,
    # and width 0.35 rad for both CVs.
    #
    metad: METAD ARG=phi,psi PACE=500 HEIGHT=1.2 SIGMA=0.35,0.35 FILE=HILLS
    # monitor the two variables and the metadynamics bias potential
    PRINT STRIDE=10 ARG=phi,psi,metad.bias FILE=COLVAR

References
----------

- Gromacs instructions. Retrieved July 10, 2019, from http://www.gromacs.org/Documentation/Installation_Instructions_5.0
- Gromacs github. Retrieved July 10, 2019, from https://github.com/gromacs/gromacs/blob/master/cmake/FindNVML.cmake
- Lindqvist. Retrieved July 10, 2019, from http://verahill.blogspot.com.co/2013/04/396-compiling-gromacs-46-with-openblas.html
- Compiling GROMACS on Cluster. Retrieved July 10, 2019, from https://ringo.ams.stonybrook.edu/index.php/Compiling_GROMACS_on_Cluster
- Lindqvist.Retrieved July 10, 2019, from http://verahill.blogspot.com/2012/03/building-gromacs-with-fftw3-and-openmpi.html
- How to compile gromacs. Retrieved July 10, 2019, from https://mini.ourphysics.org/wiki/index.php/How_to_compile_Gromacs
- Github issue. Retrieved July 10, 2019, from https://github.com/linux-sunxi/linux-sunxi/issues/62
- Nvidia gromacs. Retrieved July 10, 2019, from https://ngc.nvidia.com/catalog/containers/hpc:gromacs
- Running VASP on Nvidia GPUs. Retrieved July 10, 2019, from https://www.nsc.liu.se/~pla/
- Gromacs (GPU). Retrieved July 10, 2019, from http://www.hpcadvisorycouncil.com/pdf/GROMACS_GPU.pdf

Authors
-------

- Mateo Gómez Zuluaga
