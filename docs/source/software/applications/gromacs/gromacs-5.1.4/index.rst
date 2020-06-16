.. _gromacs-5.1.4-index:

.. role:: bash(code)
   :language: bash

GROMACS 5.1.4
==============

- **Installation Date:** 02/22/2017
-  **URL:** http://www.gromacs.org/
- - **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **License:** GNU Lesser General Public License (LGPL), version 2.1.

.. contents:: Table of Contents

Dependencies
------------

- GNU GCC >= 5.4.0
- OpenMPI >= 1.8.8 (Do not include version with PMI2)
- Python> = 2.7.X (Check that it does not include MKL or BLAS libraries)
- CUDA> = 8.0 (Must include SDK)
- cmake

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
        $ mkdir build
        $ cd build

#. compile it

   .. code-block:: bash

        $ cmake .. -DGMX_GPU=ON -DCUDA_TOOLKIT_ROOT_DIR=/share/apps/cuda/8.0 -DGMX_MPI=ON
            -DCMAKE_INSTALL_PREFIX=/share/apps/gromacs/5.1.4/gcc/5.4.0/cuda/8.0
            -DGMX_EXTERNAL_BLAS=/share/apps/openblas/0.2.19/gcc/5.4.0/lib
            -DGMX_BUILD_OWN_FFTW=ON -DGMX_EXTERNAL_BOOST=ON
            -DBoost_INCLUDE_DIR="/share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0/include"
            -DBoost_LIBRARY_DIRS="/share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0/lib"
            -DBoost_DIR="/share/apps/boost/1.63.0/gcc/5.4.0_openmpi-1.8.8-x86_64_cuda-8.0/"
            -DNVML_INCLUDE_DIR=/share/apps/cuda/8.0/include 2>&1 | tee gromacs-cmake.log
        $ cmake .. CC=mpicc CXX=mpicxx cmake .. -DGMX_GPU=ON -DGPU_DEPLOYMENT_KIT_ROOT_DIR=/share/apps/cuda/8.0
            -DGMX_MPI=ON -DCMAKE_INSTALL_PREFIX=/share/apps/gromacs/5.1.4/gcc-5.4.0_cuda-8.0
            -DGMX_BUILD_OWN_FFTW=ON -DGMX_PREFER_STATIC_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DGMX_BUILD_UNITTESTS=ON
            -DREGRESSIONTEST_DOWNLOAD=ON 2>&1 | tee gromacs-cmake.log
        $ make 2>&1 | tee gromacs-make.log
        $ make check 2>&1 | tee gromacs-check.log
        $ make install 2>&1 | tee gromacs-make-install.log


References
----------

- Gromacs instructions. Retrieved July 10, 2019, from http://www.gromacs.org/Documentation/Installation_Instructions_5.0
- Gromacs github. Retrieved July 10, 2019, from https://github.com/gromacs/gromacs/blob/master/cmake/FindNVML.cmake
- Lindqvist. Retrieved July 10, 2019, from http://verahill.blogspot.com.co/2013/04/396-compiling-gromacs-46-with-openblas.html
- Compiling GROMACS on Cluster. Retrieved July 10, 2019, from https://ringo.ams.stonybrook.edu/index.php/Compiling_GROMACS_on_Cluster
- Lindqvist. Retrieved July 10, 2019, from http://verahill.blogspot.com/2012/03/building-gromacs-with-fftw3-and-openmpi.html
- How to compile gromacs. Retrieved July 10, 2019, from https://mini.ourphysics.org/wiki/index.php/How_to_compile_Gromacs
- Github issue. Retrieved July 10, 2019, from https://github.com/linux-sunxi/linux-sunxi/issues/62
- Nvidia gromacs. Retrieved July 10, 2019, from https://ngc.nvidia.com/catalog/containers/hpc:gromacs
- Running VASP on Nvidia GPUs. Retrieved July 10, 2019, from https://www.nsc.liu.se/~pla/
- Gromacs (GPU). Retrieved July 10, 2019, from http://www.hpcadvisorycouncil.com/pdf/GROMACS_GPU.pdf

Authors
-------

- Mateo Gómez Zuluaga
