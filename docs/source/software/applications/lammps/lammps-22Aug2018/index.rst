.. _lammps-22Aug2018-index:

LAMMPS - 22Aug2018
==================

Basic information
-----------------

- **Official Website:** https://lammps.sandia.gov/
- **License:** GNU GENERAL PUBLIC LICENSE (GPL)
- **Installed on:** :ref:`Cronos <about_cronos>`

Installation
------------

Make MODES
----------

make machine               # build LAMMPS executable lmp_machine
make mode=lib machine      # build LAMMPS static lib liblammps_machine.a
make mode=shlib machine    # build LAMMPS shared lib liblammps_machine.so

#. Load the necessary modules for compiling LAMMPS

   .. code-block:: bash
	  
	  $ module load impi
	  $ module load mkl

#. Download and compile the source code.

  .. code-block:: bash
	 
    $ git clone -b stable https://github.com/lammps/lammps.git
	$ git checkout stable_22Aug2018
    $ cd lammps/src
	$ make yes-all
	$ make no-lib
	$ make intel_cpu_intelmpi
	
	
    $ cmake -D CMAKE_INSTALL_PREFIX=/home/azapat47/apps/lammps/build/ -D LAMMPS_MACHINE=icc_openmpi ../cmake
    $ make -jN             #(N = available CPU cores) compile in parallel
    $ make install

	  -D CMAKE_INSTALL_PREFIX=path


============================ ========================================= ==========================================
Options                      Values                                    Notes
============================ ========================================= ==========================================
-D BUILD_EXE=value           yes (default) or no
-D BUILD_LIB=value           yes or no (default)
-D BUILD_SHARED_LIBS=value   yes or no (default)
-D BUILD_MPI=value           yes or no                                 default is yes if CMake finds MPI,else no
-D BUILD_OMP=value           yes or no (default)
-D LAMMPS_MACHINE=name       name = mpi, serial,                       no default value
-D PKG_NAME=value            yes or no (default)                       -D PKG_USER-INTEL=yes
============================ ========================================= ==========================================

#. Load the necessary modules for compiling LAMMPS

   .. code-block:: bash
	  
	  $ module load cmake
	  $ module load impi
	  $ module load mkl

#. Download and compile the source code.

  .. note:: cmake was chosen instead of traditional make because cmake let you decide where to install the software.
  .. code-block:: bash
	 
    $ git clone -b stable https://github.com/lammps/lammps.git
    $ cd lammps
    $ mkdir build
    $ cd build

  .. note:: Move to build directory in order to generate the temporal Cmake files there.

  $ cmake -D CMAKE_INSTALL_PREFIX=/home/azapat47/apps/lammps/build/ -D LAMMPS_MACHINE=icc_openmpi ../cmake
  $ make -jN             #(N = available CPU cores) compile in parallel
  $ make install

	  -D CMAKE_INSTALL_PREFIX=path
	  

Usage
-----

References
----------

- `Download source via Git - LAMMPS documentation
  <https://lammps.sandia.gov/doc/Install_git.html>`

Authors
-------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
