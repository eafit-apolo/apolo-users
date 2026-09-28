.. TEMPLATE: one installed version of a program.
   Copy to: docs/source/software/<category>/<program>/<version>/index.rst
   Everything below is an example: replace it with your program, delete
   the sections you don't need, then delete this comment.

.. _minimap2-2.28:

Minimap2 2.28
=============

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo 3

How to use Minimap2 2.28 on Apolo 3, and how it was installed.

Basic information
-----------------

- **Installation date:** 2026-09-28
- **Installed on:** Apolo 3
- **Installation path:** :file:`/opt/ohpc/pub/apps/minimap2/2.28`

Usage
-----

.. code-block:: bash

   module load minimap2/2.28

Example job
~~~~~~~~~~~

.. Keep this layout. Use a partition that exists on the cluster above,
   write --time as D-HH:MM:SS, and never put a real email address.

.. code-block:: bash
   :caption: minimap2-job.sh

   #!/bin/bash
   #SBATCH --job-name=minimap2-test        # Job name
   #SBATCH --partition=longjobs            # Partition
   #SBATCH --nodes=1                       # Nodes
   #SBATCH --ntasks=1                      # Tasks (processes)
   #SBATCH --cpus-per-task=8               # Cores per task
   #SBATCH --mem=16G                       # Memory per node
   #SBATCH --time=0-01:00:00               # Time limit (D-HH:MM:SS)
   #SBATCH --output=%x-%j.out              # Output (%x = job name, %j = job ID)
   #SBATCH --error=%x-%j.err               # Errors

   ##### ENVIRONMENT #####
   module purge
   module load minimap2/2.28

   ##### JOB COMMANDS #####
   srun minimap2 -t "$SLURM_CPUS_PER_TASK" -a reference.fa reads.fq > aln.sam

Submit it with ``sbatch minimap2-job.sh``.

Installation
------------

#. Download and compile it:

   .. code-block:: bash

      wget https://github.com/lh3/minimap2/releases/download/v2.28/minimap2-2.28.tar.bz2
      tar -xjf minimap2-2.28.tar.bz2
      cd minimap2-2.28
      make

#. Copy the program to the installation path:

   .. code-block:: bash

      mkdir -p /opt/ohpc/pub/apps/minimap2/2.28/bin
      cp minimap2 /opt/ohpc/pub/apps/minimap2/2.28/bin/

#. Create the module file :file:`/opt/ohpc/pub/modulefiles/minimap2/2.28.lua`:

   .. code-block:: lua

      prepend_path("PATH", "/opt/ohpc/pub/apps/minimap2/2.28/bin")

References
----------

- `Minimap2 documentation <https://lh3.github.io/minimap2/minimap2.html>`_
