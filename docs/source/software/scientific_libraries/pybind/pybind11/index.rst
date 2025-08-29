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
         $ module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64


4. Execute the cmake command with the desired directives.

    .. code-block:: bash

         $ cmake .. -DCMAKE_INSTALL_PREFIX=/share/apps/pybind11/gcc-5.4.0/ -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++


5. Execute the make commands sequence.

    .. code-block:: bash

         $ make -j <N>
         $ make check
         $ make -j <N> install

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modulefile /share/apps/modules/pybind11/11_gcc-5.4.0
        ## Written by Juan Diego Ocampo and Santiago Hidalgo Ocampo
        ##

        proc ModulesHelp { } {
            global version modroot
                puts stderr "\t Pybind11"
        }

        module-whatis "\n\n\tSets the environment for using Pybind11 \n"

        module-whatis "(Name________) Pybind11"
        module-whatis "(Version_____) 11"
        module-whatis "(Compilers___) gcc-5.4.0"
        module-whatis "(System______) x86_64-redhat-linux"

        set     topdir		/share/apps/pybind11/gcc-5.4.0
        set     version		11
        set     sys		x86_64-redhat-linux

        module load gcc/5.4.0
        module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64

        setenv		PYBIND11_HOME		$topdir

        prepend-path 	C_INCLUDE_PATH		$topdir/include
        prepend-path 	CXX_INCLUDE_PATH	$topdir/include
        prepend-path 	CPLUS_INCLUDE_PATH	$topdir/include

Troubleshooting
---------------

.. seealso::

    If you have this problem : CMake Error at tests/CMakeLists.txt:217 (message):
    Running the tests requires pytest.
    You must run the following command with administrator privileges taking into account
    the version of python you are using:

        .. code-block:: bash

            $ pip install pytest

Authors
-------

- Santiago Hidalgo Ocampo <shidalgoo1@eafit.edu.co>
