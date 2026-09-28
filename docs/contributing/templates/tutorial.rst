.. ------------------------------------------------------------------------
   TUTORIAL TEMPLATE

   Use to teach a user to accomplish something end to end (run their first
   MPI job, use a GPU, set up a Conda environment). Audience: someone
   learning; explain why as well as how.

   How to use:
   1. Copy this file to its destination, named in kebab-case
      (for example: first-gpu-job.rst) and add it to a toctree.
   2. Replace every [bracketed text], <placeholder> and YYYY-MM-DD.
   3. In the job script, replace <partition> with a partition that exists
      on the cluster in "Applies to", and keep --time as D-HH:MM:SS.
   4. Run the tutorial yourself, start to finish, before publishing.
   5. Delete these comment blocks.
   ------------------------------------------------------------------------

.. _tutorial-replace-me:

[Outcome-focused title, e.g. Run your first GPU job]
====================================================

:Authors: [Full name]
:Maintainer: [Full name]
:Last reviewed: YYYY-MM-DD
:Applies to: [Apolo II | Apolo 3]

[One to three sentences: what the reader will build or run, and why it is
useful.]

.. contents:: On this page
   :local:
   :depth: 1

What you will learn
-------------------

- [Skill or concept 1]
- [Skill or concept 2]

Estimated time: [N] minutes.

Before you start
----------------

You need:

- An active Apolo account and a working connection to the cluster.
- [Other requirement, e.g. basic familiarity with the Linux shell]

Step 1: [Prepare the input]
---------------------------

[Explain what this step does and why.]

.. code-block:: bash

   mkdir -p ~/[tutorial-directory]
   cd ~/[tutorial-directory]

Step 2: [Write the job script]
------------------------------

Create a file named :file:`[job-name].sh` with this content:

.. code-block:: bash
   :caption: [job-name].sh

   #!/bin/bash
   #SBATCH --job-name=[job-name]           # Job name
   #SBATCH --partition=<partition>         # Partition (queue)
   #SBATCH --nodes=1                       # Number of nodes
   #SBATCH --ntasks=1                      # Number of tasks (MPI processes)
   #SBATCH --cpus-per-task=1               # Threads per task
   #SBATCH --mem=4G                        # Memory per node
   #SBATCH --time=0-00:10:00               # Walltime limit (D-HH:MM:SS)
   #SBATCH --output=%x-%j.out              # Standard output (%x job name, %j job ID)
   #SBATCH --error=%x-%j.err               # Standard error
   #SBATCH --mail-type=END,FAIL            # When to send email
   #SBATCH --mail-user=<email>             # Where to send email

   ##### ENVIRONMENT #####
   module purge
   module load [module/version]

   ##### JOB COMMANDS #####
   srun [program] [arguments]

Replace ``<email>`` with your email address. [Explain any directive that
matters for this tutorial.]

Step 3: Submit the job
----------------------

.. code-block:: console

   $ sbatch [job-name].sh
   Submitted batch job 123456

Check its state while it waits and runs:

.. code-block:: bash

   squeue -u $USER

Check your results
------------------

When the job finishes, its output is in :file:`[job-name]-{jobid}.out`:

.. code-block:: text

   [Expected output]

[Explain how the reader can tell the result is correct.]

Next steps
----------

- [What to try next, with :ref: links to related pages]

.. seealso::

   [External documentation, as an anonymous link:
   `Upstream docs <https://example.org>`__]
