.. _gromacs-3.0.0-index:

.. role:: bash(code)
   :language: bash

GROMACS-LS 4.5.5
================

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://manual.gromacs.org/documentation/
- **License:** GNU Lesser General Public License (LGPL), version 2.1.
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Compiler:** GCC 5.4.0
* **Math Library:** FFTW 3.3.5
* **Others:** LAPACK Version 3.5.0


Installation
------------

The following procedure present the way to compile **GROMAS-LS 4.5.5**
for local stress calculations from molecular simulations. [1]_


.. note:: For the building, the GCC compiler vesion 5.4.0 was used due to better compatibility with FFTW3 and LAPACK.

#. Load the necessary modules for the building.

   .. code-block:: bash

      $ module load cmake/3.7.1 \
                    gcc/5.4.0 \
                    fftw/3.3.5_gcc-5.4.0_openmpi-1.8.8-x86_64


#. Download the recommended version of LAPACK for GROMACS-LS

   .. code-block:: bash

      $ wget http://www.netlib.org/lapack/lapack-3.5.0.tgz
      $ tar -xvf lapack-3.5.0.tgz
      $ cd lapack-3.5.0
      $ mkdir build
      $ cd build
      $ cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/share/apps/lapack/3.5.0/gcc/5.4.0/
      $ make -j <N>
      $ make -j <N> install


   .. note:: Now that you have installed LAPACK, you may want to go to your home directory before continuing this tutorial.

#. Download the latest version of GROMACS-LS

   .. code-block:: bash

      $ wget https://www.mdstress.org/files/4314/6351/1328/gromacs-4.5.5-ls-5.0.tar.gz
      $ tar xfz gromacs-4.5.5-ls-5.0.tar.gz

#. Inside the folder, on the top create a :file:`build` directory where the installation binaries will be put by cmake.

   .. code-block:: bash

      $ cd gromacs-4.5.5-ls-5.0
      $ mkdir build
      $ cd build


#. Execute the following commands, that will export the environmental variables that GROMACS-LS needs for compilation.

   .. code-block:: bash

      $ export FFTW3_ROOT_DIR=/path/to/fftw3
      $ export CMAKE_PREFIX_PATH=/path/to/lapack

   .. note:: We just installed LAPACK, so in our case ``CMAKE_PREFIX_PATH`` should point to ``/share/apps/lapack/3.5.0/gcc/5.4.0/``



#. Execute the cmake command with the desired directives.

   .. code-block:: bash

      $ cmake .. -DCMAKE_INSTALL_PREFIX=/share/apps/gromacs-ls/4.5.5/gcc/5.4.0/


#. Execute the make commands sequence.

   .. code-block:: bash

        $ make -j <N>
        $ make -j <N> install


#. After the installation is completed you have to create the corresponding module for GROMACS-LS V4.5.5 and LAPACK V3.5.0.

   LAPACK modulefile

   .. code-block:: bash

      #%Module1.0#####################################################################
      ##
      ## modules lapack/3.5.0_gcc-5.4.0
      ##
      ## /share/apps/modules/lapack/3.5.0_gcc-5.4.0  Written by Tomás David Navarro y Juan Diego Ocampo
      ##

      proc ModulesHelp { } {
          puts stderr "\tLapack/3.5.0 - sets the Environment for LAPACK 3.5.0 in \
                       \n\tThe share directory /share/apps/lapack/3.5.0/gcc/5.4.0\n"
      }

      module-whatis "\n\n\tSets the environment for using LAPACK 3.5.0 (Linear \
                    \n\tAlgebra Library) builded with gcc 5.4.0\n"

      # for Tcl script use only
      set   topdir     /share/apps/lapack/3.5.0/gcc/5.4.0
      set   version    3.5.0
      set   sys        x86_64-redhat-linux

      module load gcc/5.4.0

      prepend-path 	LD_LIBRARY_PATH 	$topdir/lib
      prepend-path 	LIBRARY_PATH    	$topdir/lib
      prepend-path 	LD_RUN_PATH     	$topdir/lib
      setenv 	     	LAPACK 	     		$topdir/lib/liblapack.a


   GROMACS-LS modulefile

   .. code-block:: bash

      #%Module1.0#####################################################################
      ##
      ## modulefile /share/apps/modules/gromacs-ls/4.5.5_gcc-5.4.0
      ## Written by Juan Diego Ocampo
      ##

      proc ModulesHelp { } {
           global version modroot
                puts stderr "\t Gromacs-ls 4.5.5"
      }

      module-whatis "(Name________) Gromacs-ls"
      module-whatis "(Version_____) 4.5.5"
      module-whatis "(Compilers___) gcc-5.4.0"
      module-whatis "(System______) x86_64-redhat-linux"

      set     topdir		/share/apps/gromacs-ls/4.5.5/gcc/5.4.0/
      set     version		4.5.5
      set     sys		x86_64-redhat-linux

      module load fftw/3.3.5_gcc-5.4.0_openmpi-1.8.8-x86_64
      module load lapack/3.5.0_gcc-5.4.0

      prepend-path 	PATH			$topdir/bin

      prepend-path 	C_INCLUDE_PATH		$topdir/include
      prepend-path 	CXX_INCLUDE_PATH	$topdir/include
      prepend-path 	CPLUS_INCLUDE_PATH	$topdir/include

      prepend-path 	LD_LIBRARY_PATH		$topdir/lib
      prepend-path 	LIBRARY_PATH		$topdir/lib
      prepend-path 	LD_RUN_PATH		$topdir/lib

      prepend-path 	MANPATH                 $topdir/share/man



References
----------

.. [1] GROMACS-LS Documentation. (Na). Custom Version of GROMACS.
       Retrieved May 14, 2020, from https://www.mdstress.org/files/5914/4657/7530/Local_stress.pdf


Authors
-------

- Tomas David Navarro Munera <tdnavarrom@eafit.edu.co>
