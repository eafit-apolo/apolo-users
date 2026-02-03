.. _iqtree-3.0.1-index:

IQ-TREE 3.0.1
=============

.. contents:: Table of Contents
   :local:

Basic information
-----------------

- **Official Website:** https://iqtree.github.io/
- **Installed on:** Apolo II
- **Installation date:** 02/03/2026

Requirements
------------

- GCC >= 4.8
- CMake version >= 2.8.10
- Eigen3 library (for IQ-TREE version >= 1.6)

Installation
------------

#. Load the necessary modules:

   .. code-block:: bash

      module load gcc
      module load cmake
      module load eigen-3.4.0-gcc-8.5.0-e3ikjrw

#. Download the source code from GitHub:

   .. code-block:: bash

      git clone --recursive https://github.com/iqtree/iqtree3.git

#. Access the folder and create a build folder:

   .. code-block:: bash

      cd iqtree3
      mkdir build
      cd build

#. Save the build path in a variable:

   .. code-block:: bash

      INSTALL_DIR=$PWD

#. Execute the following cmake command:

   .. code-block:: bash

      cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR ..

#. If cmake is successful, finish installation by running the following commands in the build folder:

   .. code-block:: bash

      make -j
      make install

Usage mode
----------

.. code-block:: bash

   module load iqtree/3.0.1_gcc-11.2.0

Resources
---------

* https://iqtree.github.io/doc/Compilation-Guide

:Authors:

- Emanuell Torres López <etorresl@eafit.edu.co>
