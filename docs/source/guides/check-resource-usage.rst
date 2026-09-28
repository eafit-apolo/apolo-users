.. _check-resource-usage:

Check your resource usage
=========================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

This guide shows how to see your jobs in the queue, how many resources your
finished jobs really used, how many core-hours you have consumed, and how
much disk space your files take. Run all the commands on the cluster.

Before you start
----------------

- You can :ref:`log in to Apolo <connect-to-apolo>`.

Your jobs right now
-------------------

.. code-block:: bash

   squeue -u $USER

It lists your pending (``PD``) and running (``R``) jobs, with the time they
have been running and the nodes they use. To see when Slurm expects your
pending jobs to start:

.. code-block:: bash

   squeue -u $USER --start

What a finished job used
------------------------

``sacct`` shows what each job actually consumed. Compare it with what you
requested, to request the right amount next time: smaller requests usually
wait less in the queue.

.. code-block:: bash

   sacct -j <jobid> --format=JobID,JobName,State,Elapsed,Timelimit,AllocCPUS,TotalCPU,ReqMem,MaxRSS

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Field
     - What it tells you
   * - ``Elapsed`` / ``Timelimit``
     - How long the job ran, and the limit you requested. If ``Elapsed`` is
       much shorter, request less time.
   * - ``AllocCPUS`` / ``TotalCPU``
     - Cores allocated, and the processor time they really used. If
       ``TotalCPU`` is much less than ``Elapsed`` × ``AllocCPUS``, most cores
       were idle: request fewer, or check that your program runs in parallel.
   * - ``ReqMem`` / ``MaxRSS``
     - Memory requested, and the most memory the job used. ``MaxRSS`` is
       reported on the job's steps (the ``.batch`` line and the ``srun``
       steps), not on the first line.

Your jobs in a period
---------------------

To list all your jobs since a date, one line per job:

.. code-block:: bash

   sacct -X -u $USER -S 2026-09-01 --format=JobID,JobName,Partition,State,Elapsed,AllocCPUS

Without ``-S``, ``sacct`` only shows the jobs of today. Add ``-E <date>`` to
set an end date too.

Core-hours consumed
-------------------

Apolo measures computing in **core-hours**: one hour of one processor core.
Slurm counts a job's core-hours as the cores allocated to it multiplied by
the time it ran: a job that runs 2 hours on 8 cores counts 16 core-hours,
whether or not the program kept all the cores busy. To add up your
core-hours since a date:

.. code-block:: bash

   sacct -X -n -u $USER -S 2026-09-01 --format=CPUTimeRAW \
     | awk '{ s += $1 } END { printf "%.1f core-hours\n", s / 3600 }'

``CPUTimeRAW`` is the allocated cores multiplied by the run time, in seconds.
Change the date to the period you want.

.. _check-disk-usage:

Disk space
----------

To see how much space your home directory uses:

.. code-block:: bash

   du -sh ~

To see which directories take the most space, largest last:

.. code-block:: bash

   du -h --max-depth=1 ~ | sort -h

Delete or copy to your computer (see :ref:`transfer-files`) the files you no
longer need on the cluster.

See also
--------

- :ref:`info-jobs`: more ways to query jobs with ``squeue``, ``sacct`` and
  ``scontrol``.
- :ref:`job-failed`, if a job did not finish as expected.
