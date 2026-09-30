.. _job-failed:

My job failed: what now?
========================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

This page helps you find out why a Slurm job did not work and how to fix it.
The answer is almost always in the job's output files.

.. contents:: On this page
   :local:
   :depth: 1

Step 1: Read the job's output files
-----------------------------------

The job's messages are in the files set by ``--output`` and ``--error`` in
your script, in the directory from which you submitted it. With the
recommended settings they are :file:`{jobname}-{jobid}.out` and
:file:`{jobname}-{jobid}.err`. To list the most recent ones first:

.. code-block:: bash

   ls -t *.err | head

Then read the end of both files:

.. code-block:: bash

   tail -n 30 <jobname>-<jobid>.err
   tail -n 30 <jobname>-<jobid>.out

The first error message is usually the one that matters; later ones are often
consequences of it.

Step 2: Find your problem
-------------------------

.. list-table::
   :header-rows: 1
   :widths: 55 45

   * - What you see
     - Go to
   * - The ``.err`` file ends with ``... DUE TO TIME LIMIT ***``
     - `The job ran out of time`_
   * - The ``.err`` file mentions ``oom_kill`` or ``out-of-memory``
     - `The job ran out of memory`_
   * - The ``.err`` file shows ``command not found``, ``module(s) are
       unknown`` or ``No such file or directory``
     - `The job failed with an error`_
   * - The ``.err`` file ends with ``CANCELLED AT ...`` but not ``DUE TO
       TIME LIMIT``
     - `The job was cancelled`_
   * - The output stops suddenly, with no error message
     - `The output stops with no error`_
   * - The job never starts: it stays as ``PD`` in ``squeue -u $USER``
     - `The job stays pending`_
   * - ``sbatch`` prints an error instead of a job ID
     - `The job is rejected when you submit it`_

.. _job-timeout:

The job ran out of time
-----------------------

The ``.err`` file ends with a line like:

.. code-block:: text

   slurmstepd: error: *** JOB 123456 ON <node> CANCELLED AT 2026-09-28T10:00:00 DUE TO TIME LIMIT ***

**Cause:** the job reached the ``--time`` limit, and Slurm stopped it.

**Solution:**

- Request more time: ``#SBATCH --time=D-HH:MM:SS``. Check the format:
  ``--time=1:00`` is one **minute**.
- If the program can save checkpoints and restart from them, use that, so a
  long run can span several jobs.
- The maximum time allowed depends on the partition; ``sinfo -s`` shows it.

.. _job-out-of-memory:

The job ran out of memory
-------------------------

The ``.err`` file contains a line like:

.. code-block:: text

   slurmstepd: error: Detected 1 oom_kill event in StepId=123456.batch. Some of your processes may have been killed by the cgroup out-of-memory handler.

**Cause:** the job used more memory than it requested, and the system
stopped it.

**Solution:**

- Request more memory with ``#SBATCH --mem=<size>``. For example, if you
  requested ``--mem=8G``, try ``--mem=16G``.
- If the job needs more memory than a regular node has, use the ``bigmem``
  partition.

The job failed with an error
----------------------------

The ``.err`` file shows one of these messages:

- ``command not found``: the program is not available in the job.
- ``Lmod has detected the following error: The following module(s) are
  unknown``: a ``module load`` line names a module that does not exist.
- ``error while loading shared libraries``: the program cannot find a library
  it needs.
- ``No such file or directory``: a path in the script is wrong.

**Solution:**

- **Module and program errors:** load the modules in the ``ENVIRONMENT``
  block of the script, with their versions. Check the exact names with
  ``module spider <program>`` (see :ref:`use-scientific-software`). Load the
  same modules the program was compiled with.
- **Path errors:** relative paths are relative to the directory where you
  ran ``sbatch``. Use absolute paths, or ``cd`` to the right directory at the
  start of the job commands.
- **The program's own errors:** they come from your input or the program
  itself. Run a smaller case to reproduce them quickly, and check the
  program's documentation or its page in :ref:`software`.

The job was cancelled
---------------------

The ``.err`` file ends with a line like:

.. code-block:: text

   slurmstepd: error: *** JOB 123456 ON <node> CANCELLED AT 2026-09-28T10:00:00 ***

The job was cancelled with ``scancel``, by you or by an administrator. If it
was not you, ask the Apolo staff why, with the job ID.

The output stops with no error
------------------------------

The job is no longer in ``squeue``, but its output files end suddenly, with
no error message. The node where it ran may have failed, which is not a
problem with your job. Submit it again, and if it happens again, report it to
the Apolo staff with the job ID.

.. _job-pending:

The job stays pending
---------------------

The job stays in state ``PD`` in ``squeue -u $USER``. The
``NODELIST(REASON)`` column says why:

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Reason
     - Meaning and what to do
   * - ``Priority``
     - Other jobs are ahead of yours. Wait.
   * - ``Resources``
     - Your job is next, waiting for the nodes it needs to free up. Wait.
   * - ``QOSMaxCpuPerUserLimit``, ``QOSMaxJobsPerUserLimit`` or another
       ``...Limit``
     - You reached a limit on how much you can run at once. The job starts
       when your other jobs finish.
   * - ``PartitionTimeLimit``
     - The ``--time`` you requested is longer than the partition allows. It
       will never start: cancel it with ``scancel <jobid>`` and submit it
       with less time, or to another partition.
   * - ``ReqNodeNotAvail``
     - The nodes it needs are unavailable, for example during maintenance.

To see when Slurm expects it to start: ``squeue -u $USER --start``.

.. _job-rejected:

The job is rejected when you submit it
--------------------------------------

``sbatch`` refuses the job and prints an error instead of a job ID:

- ``sbatch: error: Batch job submission failed: Invalid partition name
  specified``: the partition does not exist on this cluster. See the
  partitions of
  :ref:`Apolo II <about_apolo-ii>` and :ref:`apolo-3`.
- ``sbatch: error: Batch script contains DOS line breaks (\r\n)``: the script
  was written on Windows. Convert it on the cluster with
  ``sed -i 's/\r$//' <script>`` (or ``dos2unix <script>``, if it is
  installed).

Still stuck?
------------

Write to apolo@eafit.edu.co, or open an issue as described in
:ref:`report-a-bug`. Include:

- the job ID and the cluster,
- the job script,
- the last lines of the ``.err`` and ``.out`` files.

See also
--------

- :ref:`frequent-problems`
- :ref:`faq-slurm`
- :ref:`testing-slurm`: test a job script before running the real job.
