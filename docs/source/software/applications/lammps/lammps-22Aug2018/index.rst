.. _lammps-22Aug2018-index:

.. role:: bash(code)
   :language: bash

LAMMPS - 22Aug2018
==================

Basic information
-----------------

- **Official Website:** https://lammps.sandia.gov/
- **License:** GNU GENERAL PUBLIC LICENSE (GPL)
- **Installed on:** :ref:`Cronos <about_cronos>`


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Compiler:** Intel MPI Library :math:`\boldsymbol{\ge}` 17.0.1
* **Math Library:** Intel MKL :math:`\boldsymbol{\ge}` 17.0.1
  
Installation
------------

The following procedure will compile LAMMPS as an executable, using the Intel MPI implementation
and MKL as the Linear Algebra Library. The compilation options are described in
:bash:`src/MAKE/OPTIONS/Makefile.intel_cpu_intelmpi`

#. Load the necessary modules for compiling LAMMPS

   .. code-block:: bash
	  
	  $ module load impi
	  $ module load mkl

#. Download and compile the source code. This procedure will compile LAMMPS
   using the Intel architecture options defined by default in
   :bash:`src/MAKE/OPTIONS/Makefile.intel_cpu_intelmpi`

   These make options (yes-all, no-lib) are used to reproduce the list of packages
   present in LAMMPS Ubuntu prebuild version. For more information read [2]_.

   .. code-block:: bash
 	 
    $ git clone -b stable_22Aug2018 https://github.com/lammps/lammps.git
    $ cd lammps/src
    $ make yes-all     # install all pkgs in src dir
    $ make no-lib      # remove all pkgs with libs 
    $ make intel_cpu_intelmpi
	
   .. note::  :bash:`icpc: command line warning #10006: ignoring unknown option '-qopt-zmm-usage=high'`
			
			This message appears when you compile LAMMPS using the intel_cpu_intelmpi architecture but
			the Intel processor doesn't have the AVX512 instruction set. If this is the case, just ignore
			the warning message. For more information about the flag :bash:`qopt-zmm-usage` read [3]_.

#. If you want to install LAMMPS in a specific directory, create the directories and copy
   the binary as follows:

   .. code-block:: bash

				   $ mkdir -p <INSTALL_DIR>/bin
				   $ cp lmp_intel_cpu_intelmpi <INSTALL_DIR>/bin/
				   $ cd <INSTALL_DIR>/bin/
				   $ ln -s lmp_intel_cpu_intelmpi lammps

   .. note:: For more information about the installation process, read the official page [1]_.

#. Finally, if the program will be used with Environment modules, create the respective module.

   
Alternative Installation modes
------------------------------
   
If you want to compile LAMMPS as a static library called :bash:`liblammps_machine.a`, then execute:

.. code-block:: bash
				
    make mode=lib <machine>

If you want to compile LAMMPS as a shared library called :bash:`liblammps_machine.so`, then execute:

.. code-block:: bash

	make mode=shlib <machine>

   
Modulefile
----------

**Apolo II**

.. literalinclude:: src/22Aug18_apolo
   :language: tcl
   :caption: :download:`Module file <src/22Aug18_apolo>`

**Cronos**

.. literalinclude:: src/22Aug18_cronos
   :language: tcl
   :caption: :download:`Module file <src/22Aug18_cronos>`

Test LAMMPS
-----------

After installing LAMMPS, run the benchmarks present in the repository.

.. code-block:: bash

				$ sbatch example.sh

The following code is an example for running LAMMPS using SLURM:

.. literalinclude:: src/lammps-bench.sh
	:language: bash
			 
References
----------

.. [1] `Download source via Git - LAMMPS documentation.
	   Retrieved January 17, 2019, from https://lammps.sandia.gov/doc/Install_git.html`

.. [2] `Download an executable for Linux, Pre-built Ubuntu Linux executables -LAMMPS documentation.
	   Retrieved January 17, 2019, from https://lammps.sandia.gov/doc/Install_linux.html#ubuntu`
	   
.. [3] `Intel® C++ Compiler 19.0 Developer Guide and Reference, qopt-zmm-usage, Qopt-zmm-usage.
	   Retrieved January 17, 2019, from
	   https://software.intel.com/en-us/cpp-compiler-developer-guide-and-reference-qopt-zmm-usage-qopt-zmm-usage`
  
Authors
-------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
