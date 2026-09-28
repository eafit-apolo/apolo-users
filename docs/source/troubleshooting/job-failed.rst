.. _job-failed:

My job failed: what now?
========================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

This page helps you find out why a Slurm job did not work and how to fix it.
Start with the two diagnostic steps, then go to the problem that matches what
you see.

.. contents:: On this page
   :local:
   :depth: 1

Step 1: Ask Slurm how the job ended
-----------------------------------

.. code-block:: bash

   sacct -j <jobid> --format=JobID,JobName,State,ExitCode,Elapsed,Timelimit,ReqMem,MaxRSS

If you do not remember the job ID, list your jobs of today with
``sacct -X -u $USER``.

Look at the ``State`` column of the first line:

.. list-table::
   :header-rows: 1
   :widths: 25 75

   * - State
     - Go to
   * - ``TIMEOUT``
     - `The job ran out of time`_
   * - ``OUT_OF_MEMORY``
     - `The job ran out of memory`_
   * - ``FAILED``
     - Step 2, then `The job failed with an error`_
   * - ``CANCELLED``
     - `The job was cancelled`_
   * - ``NODE_FAIL``
     - `A node failed`_
   * - ``COMPLETED``, but the results are wrong or missing
     - Step 2: the job script ended normally, but a command inside it may
       have failed.
   * - The job never starts (``PD`` in ``squeue``)
     - `The job stays pending`_

Step 2: Read the job's output files
-----------------------------------

The job's messages are in the files set by ``--output`` and ``--error`` in
your script, in the directory from which you submitted it. With the
recommended settings they are :file:`{jobname}-{jobid}.out` and
:file:`{jobname}-{jobid}.err`.

.. code-block:: bash

   tail -n 30 <jobname>-<jobid>.err
   tail -n 30 <jobname>-<jobid>.out

The first error message is usually the one that matters; later ones are often
consequences of it.

.. _job-timeout:

The job ran out of time
-----------------------

Symptom
~~~~~~~

``State`` is ``TIMEOUT``, and the ``.err`` file ends with a line like:

.. code-block:: text

   slurmstepd: error: *** JOB 123456 ON <node> CANCELLED AT 2026-09-28T10:00:00 DUE TO TIME LIMIT ***

Cause
~~~~~

The job reached the ``--time`` limit, and Slurm stopped it.

Solution
~~~~~~~~

- Request more time: ``#SBATCH --time=D-HH:MM:SS``. Check the format:
  ``--time=1:00`` is one **minute**.
- If the program can save checkpoints and restart from them, use that, so a
  long run can span several jobs.
- The maximum time allowed depends on the partition; ``sinfo -s`` shows it.

.. _job-out-of-memory:

The job ran out of memory
-------------------------

Symptom
~~~~~~~

``State`` is ``OUT_OF_MEMORY``, and the ``.err`` file contains a line like:

.. code-block:: text

   slurmstepd: error: Detected 1 oom_kill event in StepId=123456.batch. Some of your processes may have been killed by the cgroup out-of-memory handler.

Cause
~~~~~

The job used more memory than it requested, and the system stopped it.

Solution
~~~~~~~~

- Compare ``MaxRSS`` (the most memory used) with ``ReqMem`` (what you
  requested) in the ``sacct`` output, and request more with
  ``#SBATCH --mem=<size>``, for example ``--mem=16G``.
- If the job needs more memory than a regular node has, use the ``bigmem``
  partition.

The job failed with an error
----------------------------

Symptom
~~~~~~~

``State`` is ``FAILED`` and ``ExitCode`` is not ``0:0``. Look for one of
these messages in the ``.err`` file:

- ``command not found``: the program is not available in the job.
- ``Lmod has detected the following error: The following module(s) are
  unknown``: a ``module load`` line names a module that does not exist.
- ``error while loading shared libraries``: the program cannot find a library
  it needs.
- ``No such file or directory``: a path in the script is wrong.

Solution
~~~~~~~~

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

``State`` is ``CANCELLED``. You, an administrator, or Slurm cancelled it. If
it was not you, the ``.err`` file may say why; otherwise ask the Apolo staff,
with the job ID.

A node failed
-------------

``State`` is ``NODE_FAIL``: the node where the job ran stopped working. It
is not a problem with your job. Submit it again, and if it happens again,
report it to the Apolo staff with the job ID.

.. _job-pending:

The job stays pending
---------------------

Symptom
~~~~~~~

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
  specified``: the partition does not exist on this cluster. For example,
  Apolo 3 has no ``debug`` partition. See the partitions of
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
