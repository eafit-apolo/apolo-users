.. _muscle-5.3-index:


MUSCLE 5.3
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://drive5.com/muscle/
- **Source repository:** https://github.com/rcedgar/muscle
- **License:** Open source (GPLv3)

.. note:: MUSCLE 5 changed both the command line interface and the alignment
          algorithm with respect to :ref:`MUSCLE 3.8.1551 <muscle-3.8.1551-index>`.
          Scripts written for version 3 will not run unmodified on version 5.

Tested on (Requirements)
------------------------

* **Compiler:** GNU GCC :math:`\boldsymbol{\ge}` 8.5.0
* **Dependencies:**
    * A C++ toolchain with OpenMP support (optional, enables multithreading)

Installation
------------

#. Create a build directory in your home directory and download the source code:

    .. code-block:: bash

        $ mkdir -p ~/build_muscle && cd ~/build_muscle
        $ wget https://github.com/rcedgar/muscle/archive/refs/tags/v5.3.tar.gz
        $ tar -xzvf v5.3.tar.gz

#. Load the compiler through the module system:

    .. code-block:: bash

        $ module load gcc/8.5.0

#. Compile the source code:

    .. code-block:: bash

        $ cd muscle-5.3/src
        $ make

   The resulting ``muscle`` binary is written to the ``muscle-5.3/bin``
   directory.

#. Install the binary into the target prefix:

    .. code-block:: bash

        $ mkdir -p ~/apps/muscle/5.3/bin
        $ cp ../bin/muscle ~/apps/muscle/5.3/bin

Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module muscle/5.3_gcc-8.5.0
        ##

        proc ModulesHelp { } {
            puts stderr "\tmuscle/5.3_gcc-8.5.0 - sets the Environment for MUSCLE 5.3\n"
        }

        module-whatis "\n\n\tSets the environment for using MUSCLE 5.3 \
                    \n\tbuilded with GNU GCC 8.5.0\n"

        # for Tcl script use only
        set       topdir     /share/apps/muscle/5.3/gcc/8.5.0
        set       version    5.3
        set       sys        x86_64-redhat-linux

        module load gcc/8.5.0

        prepend-path PATH    $topdir/bin

Use
---

A basic alignment reads an unaligned FASTA file and writes the aligned result:

    .. code-block:: bash

        $ muscle -align input.fasta -output aligned.fasta

Slurm template
~~~~~~~~~~~~~~

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --ntasks-per-node=32
        #SBATCH --time=1:00:00
        #SBATCH --job-name=muscle
        #SBATCH -o result_%N_%j.out
        #SBATCH -e result_%N_%j.err

        export SBATCH_EXPORT=NONE

        module load muscle/5.3

        muscle -align input.fasta -output aligned.fasta

Troubleshooting
---------------

Compiler too old
~~~~~~~~~~~~~~~~

**ISSUE:** Compilation fails with errors about unsupported C++ standard
features.

**SOLUTION:** MUSCLE 5 requires a modern C++ toolchain. Cluster users cannot
install compilers themselves, so load a newer one through the module system
instead of building against the system default:

    .. code-block:: bash

        $ module avail gcc
        $ module load gcc/8.5.0

Resources
---------
 * https://drive5.com/muscle/
 * https://github.com/rcedgar/muscle
