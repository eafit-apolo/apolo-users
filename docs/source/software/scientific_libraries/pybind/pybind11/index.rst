.. _pybind11:

Pybind11
========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/pybind/pybind11
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)


Installation
------------

1. Download the latest version of pybind11

    .. code-block:: bash

         $ git clone https://github.com/pybind/pybind11.git

2. Inside the folder, on the top create a :file:`build` directory where the installation binaries will be put by cmake.

    .. code-block:: bash

         $ cd pybind11
         $ mkdir build
         $ cd build

3. Load the necessary modules for the building.

    .. code-block:: bash

         $ module load python/3.6.5_miniconda-4.5.1
         $ module load cmake/3.7.1
         $ module load gcc/5.4.0

4. Execute the cmake command with the desired directives.

    .. code-block:: bash

         $ cmake .. -DCMAKE_INSTALL_PREFIX=<Path> -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++


5. Execute the make commands sequence.

    .. code-block:: bash

         $ make -j <N>
         $ make check
         $ make -j <N> install


Authors
-------

- Santiago Hidalgo Ocampo <shidalgoo1@eafit.edu.co>