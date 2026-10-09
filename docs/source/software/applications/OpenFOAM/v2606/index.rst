.. _openfoam-v2606:

OpenFOAM v2606
==============

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-10-08
:Applies to: Apolo II

How to use OpenFOAM v2606 on Apolo II.

.. note::

   This is the **ESI-OpenCFD** distribution of OpenFOAM (openfoam.com,
   versions named ``vYYMM``, for example ``v2606``). It is **not** the
   OpenFOAM Foundation release (openfoam.org, versions named ``12``, ``13``,
   …). Most case files are compatible, but some solvers, utilities and
   dictionary keywords differ between the two.

Basic information
-----------------

- **Installation date:** 2026-10-08
- **Installed on:** Apolo II
- **Installation path:** :file:`/opt/ohpc/pub/apps/openfoam/v2606`
- **Website:** `openfoam.com <https://www.openfoam.com>`_
- **License:** GNU GPL v3

Dependencies
------------

- Apptainer 1.5.2 (loaded automatically by the module).
- Open MPI 4.1 (included with OpenFOAM; you do not need to load any MPI
  module).

Usage
-----

Load the module:

.. code-block:: bash

   module load openfoam/v2606

Available commands
~~~~~~~~~~~~~~~~~~

Loading the module adds all the OpenFOAM applications to your ``PATH``. You
run them directly by their name, like any other Linux command. The most
common ones are:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Purpose
     - Commands
   * - Create a mesh
     - ``blockMesh``, ``snappyHexMesh``, ``extrudeMesh``
   * - Check or modify a mesh
     - ``checkMesh``, ``renumberMesh``, ``topoSet``
   * - Solvers
     - ``icoFoam``, ``simpleFoam``, ``pimpleFoam``, ``interFoam``,
       ``rhoSimpleFoam``, …
   * - Prepare a case
     - ``setFields``, ``mapFields``, ``foamDictionary``
   * - Split and join a case for parallel runs
     - ``decomposePar``, ``reconstructPar``
   * - Post-processing
     - ``postProcess``, ``foamToVTK``
   * - Run a solver in parallel
     - ``openfoam mpirun`` (see `Running in parallel`_)

See the full list of available commands (more than 300):

.. code-block:: bash

   ls /opt/ohpc/pub/apps/openfoam/v2606/bin

See the options of any command with ``-help``:

.. code-block:: bash

   simpleFoam -help

Running in parallel
~~~~~~~~~~~~~~~~~~~

Parallel runs use the MPI version included with OpenFOAM. To use it, write
``openfoam`` before ``mpirun``:

.. code-block:: bash

   openfoam mpirun -np 4 simpleFoam -parallel

.. warning::

   A plain ``mpirun`` does not work with this installation. Always write
   ``openfoam mpirun``.

Tutorials
~~~~~~~~~

The module also defines the variable ``$FOAM_TUTORIALS``, the directory that
contains the official OpenFOAM tutorials. List them with:

.. code-block:: bash

   ls $FOAM_TUTORIALS

Important notes
~~~~~~~~~~~~~~~

- **One node per job.** A parallel run can use up to 32 cores (one
  ``longjobs`` node).
- **Keep your cases inside your home directory**
  (:file:`/home/{username}`). Other locations may not be visible to
  OpenFOAM. If you need them, contact the Apolo staff.
- **Do not run simulations on the login node.** Always submit them as jobs
  with ``sbatch``.

Example job: pitzDaily in parallel
----------------------------------

This example runs the ``pitzDaily`` tutorial in parallel with 4 processes.
The same steps work for your own cases.

At the end you will have this directory:

.. code-block:: text

   pitzDaily-test/
   ├── job.sh            ← Slurm job: requested resources and steps to run
   ├── bin/              ← scripts with the OpenFOAM commands
   │   ├── mesh.sh
   │   ├── solve.sh
   │   └── reconstruct.sh
   ├── logs/             ← job output (.out) and errors (.err)
   └── pitzDaily/        ← the OpenFOAM case (0/, constant/, system/)

Step 1. Create the working directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Go to your home directory:

   .. code-block:: bash

      cd ~

#. Create the job directory and enter it:

   .. code-block:: bash

      mkdir pitzDaily-test

   .. code-block:: bash

      cd pitzDaily-test

#. Create the ``bin`` and ``logs`` directories:

   .. code-block:: bash

      mkdir bin

   .. code-block:: bash

      mkdir logs

.. important::

   The ``logs`` directory must exist **before** you submit the job. Slurm
   does not create it, and if it is missing the job fails without leaving
   any message.

Step 2. Copy the case
~~~~~~~~~~~~~~~~~~~~~

#. Load the module:

   .. code-block:: bash

      module load openfoam/v2606

#. Copy the ``pitzDaily`` tutorial into the current directory (the ``.`` at
   the end means "here"):

   .. code-block:: bash

      cp -r $FOAM_TUTORIALS/incompressible/simpleFoam/pitzDaily .

#. Check that the case was copied. You should see the directories ``0``,
   ``constant`` and ``system``:

   .. code-block:: console

      $ ls pitzDaily
      0  constant  system

Step 3. Tell OpenFOAM how many processes to use
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To run in parallel, OpenFOAM splits the mesh into parts, one per process. The
number of parts is set in the file :file:`system/decomposeParDict`, which
this tutorial does not include.

#. Create it:

   .. code-block:: bash

      nano pitzDaily/system/decomposeParDict

#. Paste this content, then save and exit (``Ctrl+O``, ``Enter``,
   ``Ctrl+X``):

   .. code-block:: text
      :caption: pitzDaily/system/decomposeParDict

      FoamFile
      {
          version     2.0;
          format      ascii;
          class       dictionary;
          object      decomposeParDict;
      }

      numberOfSubdomains 4;

      method          scotch;

- ``numberOfSubdomains 4;`` splits the mesh into 4 parts. **This number must
  be the same as** ``--ntasks`` **in** :file:`job.sh`.
- ``method scotch;`` lets OpenFOAM decide automatically how to split the
  mesh.

Step 4. Create the scripts in ``bin/``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Each script runs one stage of the simulation.

#. Create :file:`bin/mesh.sh`, which creates the mesh and splits it into
   parts:

   .. code-block:: bash

      nano bin/mesh.sh

   .. code-block:: bash
      :caption: bin/mesh.sh

      #!/bin/bash

      # Create the mesh
      blockMesh -case pitzDaily

      # Split the mesh into parts (one per process)
      decomposePar -force -case pitzDaily

#. Create :file:`bin/solve.sh`, which runs the solver in parallel:

   .. code-block:: bash

      nano bin/solve.sh

   .. code-block:: bash
      :caption: bin/solve.sh

      #!/bin/bash

      # Run the solver with as many processes as requested in job.sh (--ntasks)
      openfoam mpirun -np "$SLURM_NTASKS" simpleFoam -parallel -case pitzDaily

#. Create :file:`bin/reconstruct.sh`, which joins the results of all the
   parts:

   .. code-block:: bash

      nano bin/reconstruct.sh

   .. code-block:: bash
      :caption: bin/reconstruct.sh

      #!/bin/bash

      # Join the results of the last time step
      reconstructPar -latestTime -case pitzDaily

#. Make the scripts executable:

   .. code-block:: bash

      chmod +x bin/mesh.sh bin/solve.sh bin/reconstruct.sh

In the scripts:

- ``-case pitzDaily`` tells each command which case directory to work on.
- ``$SLURM_NTASKS`` is filled in automatically by Slurm with the value of
  ``--ntasks``.

Step 5. Create the Slurm job
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create the job script:

   .. code-block:: bash

      nano job.sh

#. Paste this content, then save and exit:

   .. code-block:: bash
      :caption: job.sh

      #!/bin/bash
      #SBATCH --job-name=pitzDaily            # Job name
      #SBATCH --partition=longjobs            # Partition
      #SBATCH --nodes=1                       # Nodes (OpenFOAM uses a single node)
      #SBATCH --ntasks=4                      # Tasks (processes), same as numberOfSubdomains
      #SBATCH --time=0-00:30:00               # Time limit (D-HH:MM:SS)
      #SBATCH --output=logs/%x-%j.out         # Output (%x = job name, %j = job ID)
      #SBATCH --error=logs/%x-%j.err          # Errors

      ##### ENVIRONMENT #####
      module purge
      module load openfoam/v2606

      ##### JOB COMMANDS #####
      ./bin/mesh.sh
      ./bin/solve.sh
      ./bin/reconstruct.sh

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Line
     - Meaning
   * - ``--job-name``
     - Name shown in the job queue.
   * - ``--partition``
     - Group of nodes where the job runs.
   * - ``--nodes=1``
     - Use a single node (required for OpenFOAM).
   * - ``--ntasks=4``
     - Number of processes. Must match ``numberOfSubdomains``.
   * - ``--time``
     - Maximum run time (``days-hours:minutes:seconds``). The job is stopped
       when it is reached.
   * - ``--output``
     - File for the normal output. ``%x`` is replaced by the job name and
       ``%j`` by the job ID.
   * - ``--error``
     - File for the error messages.

Step 6. Submit the job
~~~~~~~~~~~~~~~~~~~~~~

Submit it **from the** :file:`pitzDaily-test` **directory**, because the
paths in :file:`job.sh` (``bin/…``, ``logs/…``, ``pitzDaily``) are relative
to the directory where you run ``sbatch``:

.. code-block:: console

   $ sbatch job.sh
   Submitted batch job 52360

Slurm answers with the job ID, ``52360`` in this example.

Step 7. Follow the job
~~~~~~~~~~~~~~~~~~~~~~

#. See whether the job is waiting (``PD``) or running (``R``). When it no
   longer appears, it has finished:

   .. code-block:: bash

      squeue --me

#. See the output while the job runs or after it finishes:

   .. code-block:: bash

      cat logs/pitzDaily-<jobid>.out

#. See the errors:

   .. code-block:: bash

      cat logs/pitzDaily-<jobid>.err

Replace ``<jobid>`` with the job ID that ``sbatch`` printed.

Step 8. Check the results
~~~~~~~~~~~~~~~~~~~~~~~~~

The run finished correctly if:

- The ``.out`` file ends with the word ``End``.
- The ``.out`` file contains the line ``nProcs : 4``, which confirms that the
  4 processes were used.
- The ``.err`` file is empty or only has warnings, and contains no
  ``FOAM FATAL ERROR``.
- A new numbered directory (the last time step, for example ``289``)
  appears inside :file:`pitzDaily`:

  .. code-block:: bash

     ls pitzDaily

You will also see ``processor0`` to ``processor3``: they contain the part of
the results computed by each process.

Running your own case
---------------------

#. Copy your case directory (with ``0/``, ``constant/`` and ``system/``) into
   the job directory.
#. In the three scripts in ``bin/``, replace ``pitzDaily`` with the name of
   your case directory.
#. In :file:`bin/solve.sh`, replace ``simpleFoam`` with the solver your case
   uses.
#. Use the same number in ``numberOfSubdomains``
   (:file:`system/decomposeParDict`) and in ``--ntasks`` (:file:`job.sh`).
   The maximum is 32.
#. Adjust ``--time`` to the time your simulation needs.

Post-processing
---------------

ParaView is not included. To view the results, copy the case directory to
your computer, create an empty file ending in ``.foam`` inside it, and open
that file with ParaView:

.. code-block:: bash

   touch pitzDaily/pitzDaily.foam

Troubleshooting
---------------

See :ref:`openfoam-v2606-troubleshooting`.

.. toctree::
   :hidden:

   troubleshooting

References
----------

- `OpenFOAM (ESI-OpenCFD) <https://www.openfoam.com>`_
- `OpenFOAM v2606 release notes <https://www.openfoam.com/news/main-news/openfoam-v2606>`_
- `OpenFOAM user guide and tutorials <https://www.openfoam.com/documentation/user-guide>`_
