.. TEMPLATE: a tutorial teaches something from scratch, explaining why at
   each step. Copy to: docs/source/guides/<topic>.rst
   Everything below is an example: replace it with your topic, run it
   yourself end to end, then delete this comment.

.. _job-arrays-tutorial:

Run many similar jobs with a job array
======================================

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

A job array runs the same script many times, each time with a different
number. In this tutorial you process three input files with a single
``sbatch``. It takes about 10 minutes.

What you will learn
-------------------

- How to turn a job script into a job array.
- How each task knows which input to use.

Before you start
----------------

- You have already run a single Slurm job.

Step 1: Create the input files
------------------------------

.. code-block:: bash

   mkdir -p ~/array-tutorial && cd ~/array-tutorial
   for i in 1 2 3; do echo "data $i" > input-$i.txt; done

Step 2: Write the job script
----------------------------

``--array=1-3`` asks Slurm for three tasks. Each one reads its own number
from ``$SLURM_ARRAY_TASK_ID`` and uses it to pick its input file.

.. code-block:: bash
   :caption: array-job.sh

   #!/bin/bash
   #SBATCH --job-name=array-test           # Job name
   #SBATCH --partition=longjobs            # Partition
   #SBATCH --ntasks=1                      # Tasks (processes)
   #SBATCH --time=0-00:05:00               # Time limit (D-HH:MM:SS)
   #SBATCH --array=1-3                     # Tasks 1, 2 and 3
   #SBATCH --output=%x-%A-%a.out           # Output (%A = array ID, %a = task number)

   ##### JOB COMMANDS #####
   echo "Task $SLURM_ARRAY_TASK_ID read: $(cat input-$SLURM_ARRAY_TASK_ID.txt)"

Step 3: Submit it and check the results
---------------------------------------

.. code-block:: console

   $ sbatch array-job.sh
   Submitted batch job 123456
   $ cat array-test-123456-2.out
   Task 2 read: data 2

There is one output file per task.

Next steps
----------

- Use the task number to pick parameters instead of files.
