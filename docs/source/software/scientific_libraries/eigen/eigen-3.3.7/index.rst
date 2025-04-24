.. _eigen-3.3.7:

Eigen 3.3.7
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://eigen.tuxfamily.org/index.php?title=Main_Page#License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)

Dependencies
------------

Eigen [1]_ doesn't have any dependencies other than the C++ standard library. Eigen
uses the CMake build system, but only to build the documentation and unit-tests,
and to automate installation. If you just want to use Eigen, you can use the header
files right away. There is no binary library to link to, and no configured header
file. Eigen is a pure template library defined in the headers.


Installation
------------

1. Download the latest version of Eigen and unzip the file

    .. code-block:: bash

         $ wget https://gitlab.com/libeigen/eigen/-/archive/3.3.7/eigen-3.3.7.tar.gz
         $ tar -xzvf eigen-3.3.7.tar.gz

2. Inside the folder, on the top create a :file:`build` directory where the installation binaries will be put by cmake.

    .. code-block:: bash

         $ cd eigen-3.3.7
         $ mkdir build
         $ cd build

3. Load the necessary modules for the building.

    .. code-block:: bash

         $ module load cmake/3.7.1
         $ module load intel/19.0.4
         $ module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64

4. Execute the cmake command with the desired directives.

    .. code-block:: bash

         $  cmake ..  -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=/share/apps/eigen/3.3.7/intel-19.0.4

5. Execute the make commands sequence.

    .. code-block:: bash

         $ make -j <N>
         $ make check
         $ make -j <N> install

.. warning:: Some tests may fail, but the installation can continue depending on the number of failed tests.


Module
------

     .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modulefile /share/apps/eigen/3.3.7/intel-19.0.4/
        ##

        proc ModulesHelp { } {
            global version modroot
                puts stderr "\t Eigen 3.3.7"
        }

        module-whatis "\n\n\tSets the environment for using Eigen 3.3.7 \n"


        set     topdir		/share/apps/eigen/3.3.7/intel-19.0.4/
        set     version		3.3.7
        set     sys		x86_64-redhat-linux

        module load intel/19.0.4
        module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64

        setenv		EIGEN_HOME		$topdir

        prepend-path 	C_INCLUDE_PATH		$topdir/include/eigen3
        prepend-path 	CXX_INCLUDE_PATH	$topdir/include/eigen3
        prepend-path 	CPLUS_INCLUDE_PATH	$topdir/include/eigen3

        prepend-path 	MANPATH			$topdir/share


References
----------

.. [1] http://eigen.tuxfamily.org/index.php?title=Main_Page#Credits

Authors
-------

- Santiago Hidalgo Ocampo <shidalgoo1@eafit.edu.co>
