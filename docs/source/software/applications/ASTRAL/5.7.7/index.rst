.. _beast-5.7.7-index:

ASTRAL 5.7.7
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Repository:** https://github.com/smirarab/ASTRAL
- **License:**  GNU LESSER GENERAL PUBLIC LICENSE Version 2.1
- **Installed on:** Apolo-II
- **Installation date:** 16/07/2021

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)

- **Dependencies:**
    - Java JDK - 9.0.4

Installation
------------

#. Download the desired version of the software (repository)

	.. code-block:: bash

		$ mdkir Astral
		$ cd Astral
		$ git clone https://github.com/smirarab/ASTRAL.git

#. Run make.sh to build the project.

	.. code-block:: bash

		$ cd ASTRAL
		$ module load java/jdk-9.0.4
		$ ./make.sh

#. Check for proper installation

	.. code-block:: bash

		$ java -jar astral.5.7.7.jar

#. Then copy the directory to the path /share/apps/astral

	.. code-block:: bash

		$ cd ..
		$ mv ASTRAL/ 5.7.7
		sudo cp -r 5.7.7 /share/apps/astral

Module
------

	.. code-block:: bash

		#%Module1.0#####################################################################
		##
		## module astral/5.7.7_java/jdk-9.0.4
		##
		## /share/apps/modules/astral/5.7.7 Written by Bryan López Parra
		##

		proc ModulesHelp { } {
		    puts stderr "\tastral/5.7.7_java/jdk-9.0.4 - sets the Environment for ASTRAL \
		    \n\tin the share directory /share/apps/astral/5.7.7\n"
		}

		module-whatis "\n\n\tSets the environment for using astral\n"

		# for Tcl script use only

		set     topdir  /share/apps/astral/5.7.7
		set     version 5.7.7
		set     sys     linux-86_64

		conflict astral

		module load java/jdk-9.0.4

		prepend-path    PATH    $topdir
		prepend-path    LIBRARY_PATH    $topdir/lib

Use
---

	.. code-block:: bash

		module load astral/5.7.7_java-jdk-9.0.4

SLURM template
--------------

	.. code-block:: bash

		#!/bin/sh
		#SBATCH --partition=longjobs
		#SBATCH --nodes=1
		#SBATCH --ntasks-per-node=2
		#SBATCH --time=05:00
		#SBATCH --job-name=astral_test
		#SBATCH -o result_%N_%j.out
		#SBATCH -e result_%N_%j.err
		#SBATCH --mail-type=ALL
		#SBATCH --mail-user=blopezp@eafit.edu.co

		module load astral/5.7.7_java-jdk-9.0.4

		astral.5.7.7.jar -i song_mammals.424.gene.tre -o song_mammals.tre 2> songmamals.log

.. note::

	if the results are not sent to 2> songmamals.log, the results will be stored in the error file even if they are good.

Authors
=======

Bryan López Parra <blopezp@eafit.edu.co>
