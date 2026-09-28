.. _run-your-first-job:

Run your first Slurm job
========================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

On Apolo you do not run programs directly on the machine you log in to.
Instead, you write a **job script** that says what to run and which resources
it needs, and give it to **Slurm**, the scheduler, which runs it on a compute
node as soon as those resources are free. In this tutorial you write, submit
and check a small job, which takes about 10 minutes.

.. contents:: On this page
   :local:
   :depth: 1

What you will learn
-------------------

- How a Slurm job script is organized.
- How to submit a job and follow its state.
- Where to find its output, and how to tell whether it succeeded.

Before you start
----------------

- You can :ref:`log in to Apolo <connect-to-apolo>` (Apolo II or Apolo 3;
  this tutorial works on both).
- You know how to create a text file in a Linux terminal, for example with
  ``nano``.

Step 1: Create a working directory
----------------------------------

Log in to the cluster and create a directory for the tutorial:

.. code-block:: bash

   mkdir -p ~/first-job
   cd ~/first-job

Step 2: Write the job script
----------------------------

Open a new file named :file:`first-job.sh`:

.. code-block:: bash

   nano first-job.sh

and write this content in it:

.. code-block:: bash
   :caption: first-job.sh

   #!/bin/bash
   #SBATCH --job-name=first-job            # Job name
   #SBATCH --partition=longjobs            # Partition (queue)
   #SBATCH --nodes=1                       # Number of nodes
   #SBATCH --ntasks=1                      # Number of tasks (processes)
   #SBATCH --cpus-per-task=1               # Cores per task
   #SBATCH --mem=1G                        # Memory per node
   #SBATCH --time=0-00:05:00               # Time limit (D-HH:MM:SS)
   #SBATCH --output=%x-%j.out              # Standard output (%x = job name, %j = job ID)
   #SBATCH --error=%x-%j.err               # Standard error

   ##### ENVIRONMENT #####
   module purge

   ##### JOB COMMANDS #####
   echo "Job $SLURM_JOB_ID started on $(hostname) at $(date)"
   sleep 30
   echo "Job finished at $(date)"

Save it (in ``nano``: :kbd:`Ctrl+O`, :kbd:`Enter`, then :kbd:`Ctrl+X` to
exit).

The script has three parts:

- The first line, ``#!/bin/bash``, says the script runs with Bash.
- The ``#SBATCH`` lines are the resources you request. Slurm reads them; Bash
  treats them as comments. This job asks for one core and 1 GB of memory for
  at most 5 minutes, in the ``longjobs`` partition, which exists on both
  clusters. The partitions of each cluster are listed in
  :ref:`Apolo II <about_apolo-ii>` and :ref:`apolo-3`.
- The rest is what runs on the compute node: first the environment (here,
  ``module purge`` makes sure no module is loaded), then the commands.

.. important::

   ``--time`` is a hard limit: when it runs out, Slurm stops the job, finished
   or not. Always use the ``D-HH:MM:SS`` format. ``--time=5`` means 5 minutes,
   and ``--time=1:00`` means 1 minute, not 1 hour.

Step 3: Submit the job
----------------------

.. code-block:: console

   $ sbatch first-job.sh
   Submitted batch job 123456

The number is the **job ID**, which identifies your job. Yours will be
different; write it down.

Step 4: Follow its state
------------------------

.. code-block:: bash

   squeue -u $USER

The ``ST`` (state) column shows where your job is:

.. list-table::
   :header-rows: 1
   :widths: 15 85

   * - State
     - Meaning
   * - ``PD``
     - Pending: waiting for resources. The ``NODELIST(REASON)`` column says
       why.
   * - ``R``
     - Running.
   * - ``CG``
     - Completing: finishing and cleaning up.

When the job finishes it disappears from ``squeue``. Run the command again
after a minute or so.

Step 5: Check the results
-------------------------

The job wrote its output to :file:`first-job-{jobid}.out`, in the directory
from which you submitted it:

.. code-block:: console

   $ cat first-job-123456.out
   Job 123456 started on <node-name> at <date>
   Job finished at <date>

The :file:`first-job-{jobid}.err` file holds error messages:

.. code-block:: bash

   cat first-job-123456.err

The job succeeded if the ``.out`` file ends with ``Job finished at`` and the
``.err`` file is empty. If not, see :ref:`job-failed`.

Next steps
----------

- Run a real program: :ref:`use-scientific-software`.
- Copy your input data to the cluster: :ref:`transfer-files`.
- See how many resources your jobs really used, to request the right amount
  next time: :ref:`check-resource-usage`.
- Learn about parallel jobs (OpenMP, MPI) and job arrays: :ref:`submit`.
