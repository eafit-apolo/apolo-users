.. _pteros-2.0:

Pteros 2.0
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://yesint.github.io/pteros/index.html
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    - Standard-conforming C and C++ compilers (tested with gcc= 5.4, g++= 5.4).
    - cmake 3.3.7 build system
    - `Eigen 3.3.7 <http://eigen.tuxfamily.org/index.php?title=Main_Page>`_
    - `Boost 1.62.0 <https://www.boost.org/>`_
    - `Pybind11 <https://github.com/pybind/pybind11>`_
    - Git for getting the source code

Installation
------------

1. Download the latest version of Pteros

    .. code-block:: bash

         $ git clone https://github.com/yesint/pteros.git pteros

2. Inside the folder, on the top create a :file:`build` directory where the installation binaries will be put by cmake.

    .. code-block:: bash

         $ cd pteros
         $ mkdir build
         $ cd build

3. Load the necessary modules for the building.

    .. code-block:: bash

         $ module load cmake/3.7.1
         $ module load gcc/5.4.0
         $ module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64
         $ module load eigen/3.3.7_intel-2017_update-1
         $ module load pybind11/11_gcc-5.4.0

4. Execute the cmake command with the desired directives.

    .. code-block:: bash

         $ cmake .. -DCMAKE_INSTALL_PREFIX=/share/apps/pteros/2.0/gcc-5.4.0/ -DEIGEN3_INCLUDE_DIR=/share/apps/eigen/3.3.7/intel-19.0.4/include/eigen3/ -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_BUILD_TYPE=Release -DBoost_NO_SYSTEM_PATHS=OFF -DWITH_OPENBABEL=OFF -DWITH_GROMACS=OFF -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE:FILEPATH=/share/apps/python/3.6_miniconda-4.5.1/bin/python -Dpybind11_DIR=/share/apps/pybind11/gcc-5.4.0/share/cmake/pybind11

5. Execute the make commands sequence.

    .. code-block:: bash

         $ make -j <N>
         $ make -j install

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modulefile /share/apps/modules/pteros/2.0_gcc-5.4.0
        ## Written by Juan Diego Ocampo and Santiago Hidalgo Ocampo
        ##

        proc ModulesHelp { } {
            global version modroot
                puts stderr "\t Pteros 2.0."
        }

        module-whatis "(Name________) Pteros"
        module-whatis "(Version_____) 2.0"
        module-whatis "(Compilers___) gcc-5.4.0"
        module-whatis "(System______) x86_64-redhat-linux"

        set     topdir		/share/apps/pteros/2.0/gcc-5.4.0
        set     version		2.0
        set     sys		x86_64-redhat-linux

        module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64
        module load python/3.6.5_miniconda-4.5.1
        module load eigen/3.3.7_intel-19.0.4
        module load pybind11/11_gcc-5.4.0

        prepend-path PATH			$topdir/bin
        prepend-path PYTHONPATH			$topdir/python

        prepend-path C_INCLUDE_PATH		$topdir/include
        prepend-path CXX_INCLUDE_PATH		$topdir/include
        prepend-path CPLUS_INCLUDE_PATH		$topdir/include

        prepend-path LD_LIBRARY_PATH		$topdir/lib
        prepend-path LIBRARY_PATH		$topdir/lib
        prepend-path LD_RUN_PATH		$topdir/lib
        prepend-path LD_LIBRARY_PATH		$topdir/lib64
        prepend-path LIBRARY_PATH		$topdir/lib64
        prepend-path LD_RUN_PATH		$topdir/lib64


Testing Installation
--------------------

Run the following command:

 .. code-block:: bash

         $ pteros_analysis.py --help all


.. seealso::

    To use pteros you must have the numpy library, so we suggest following the next steps:

        .. code-block:: bash

         $ conda create -n pteros # Create a virtual environment
         $ conda activate pteros
         $ conda install numpy

.. warning::

    Some commands may fail, however, the application may work with the features you need

Troubleshooting
---------------

.. seealso::

    If you have this problem: ModuleNotFoundError: No module named '_pteros', probably
    you must rename this file: <path to Pteros>/python/pteros/_pteros.cpython-37m-x86_64-linux-gnu.so
    to _pteros.so


Authors
-------

- Santiago Hidalgo Ocampo <shidalgoo1@eafit.edu.co>
