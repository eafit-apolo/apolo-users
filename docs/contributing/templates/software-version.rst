.. ------------------------------------------------------------------------
   SOFTWARE VERSION TEMPLATE

   Documents one installed version of a program: how users load and run
   it, and how staff built it so it can be rebuilt or upgraded.

   How to use:
   1. Copy this file to
         docs/source/software/<category>/<program>/<version>/index.rst
      where <version> is exactly the upstream version (2.9.6, 2022.01a).
      If the program has no overview page yet, create it first from
      software-overview.rst.
   2. Add "<version>/index" to the toctree of the program's index.rst.
   3. Change the label below to "<program>-<version>", e.g. flye-2.9.6.
   4. Replace every [bracketed text], <placeholder> and YYYY-MM-DD.
      Every command must have been run on the cluster.
   5. Delete these comment blocks and any optional section you do not use.
   ------------------------------------------------------------------------

.. _program-version-replace-me:

[Program name] [version]
========================

:Authors: [Full name]
:Maintainer: [Full name]
:Last reviewed: YYYY-MM-DD
:Applies to: [Apolo II | Apolo 3]

[One sentence: what this page covers, e.g. How to use Flye 2.9.6 on Apolo 3
and how it was installed.]

.. contents:: On this page
   :local:
   :depth: 1

Basic information
-----------------

- **Installation date:** YYYY-MM-DD
- **Installed on:** [Apolo II | Apolo 3]
- **Installation path:** :file:`[/path/to/installation]`
- **Official website:** `[Program name] <https://example.org>`_
- **License:** [License name]

Usage
-----

Load the module:

.. code-block:: bash

   module load [program]/[version]

.. If the module needs "module use <path>" first, as some Apolo 3 modules
   do, add that line above.

[Explain how to run the program in one or two sentences.]

Running example
~~~~~~~~~~~~~~~

.. A complete Slurm job that runs a small, real case. Keep this layout;
   remove the #SBATCH lines that do not apply. Use a partition that exists
   on the cluster in "Applies to", --time as D-HH:MM:SS, and never a real
   email address.

.. code-block:: bash
   :caption: [program]-job.sh

   #!/bin/bash
   #SBATCH --job-name=[program]-test       # Job name
   #SBATCH --partition=<partition>         # Partition (queue)
   #SBATCH --nodes=1                       # Number of nodes
   #SBATCH --ntasks=1                      # Number of tasks (MPI processes)
   #SBATCH --cpus-per-task=4               # Threads per task
   #SBATCH --mem=8G                        # Memory per node
   #SBATCH --time=0-00:30:00               # Time limit (D-HH:MM:SS)
   #SBATCH --output=%x-%j.out              # Standard output (%x = job name, %j = job ID)
   #SBATCH --error=%x-%j.err               # Standard error
   #SBATCH --mail-type=END,FAIL            # When to send email
   #SBATCH --mail-user=<email>             # Where to send email

   ##### ENVIRONMENT #####
   module purge
   module load [program]/[version]

   ##### JOB COMMANDS #####
   srun [program] [arguments]

Submit it with:

.. code-block:: bash

   sbatch [program]-job.sh

Installation
------------

.. For staff and for anyone rebuilding the program. Write the steps so that
   someone else can repeat them exactly.

Requirements
~~~~~~~~~~~~

- [Compiler and version, e.g. gcc/11.2.0]
- [Libraries and versions]

Build
~~~~~

#. Load the build dependencies:

   .. code-block:: bash

      module purge
      module load [compiler/version] [library/version]

#. Download and unpack the source:

   .. code-block:: bash

      [commands]

#. Configure, compile and install:

   .. code-block:: bash

      [commands]

Module
~~~~~~

.. The modulefile that was installed, and its path. Use "lua" for Lmod
   .lua files and "tcl" for Tcl modulefiles.

.. code-block:: lua
   :caption: [/path/to/modulefiles/program/version.lua]

   [modulefile contents]

Troubleshooting
---------------

.. Optional. Known problems as "symptom, cause, fix". If there are many,
   move them to a troubleshooting.rst next to this file (template:
   troubleshooting.rst) and link it here.

- **[Symptom or exact error message].** [Cause and fix.]

References
----------

- `[Official installation guide] <https://example.org>`_
