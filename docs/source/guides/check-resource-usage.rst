.. _check-resource-usage:

Check your resource usage
=========================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

This guide shows how to see your jobs in the queue, and how to find out how
long your jobs take and how much memory they need. Run the commands on the
cluster.

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

How long your job takes
-----------------------

To request the right ``--time``, measure how long your job really runs: put
``time`` in front of the command in your job script.

.. code-block:: bash

   ##### JOB COMMANDS #####
   time srun <program> <arguments>

When the job ends, the ``.err`` file contains lines like these:

.. code-block:: text

   real    12m30.512s
   user    0m0.041s
   sys     0m0.032s

The ``real`` line is how long the command took. If it is much shorter than
the ``--time`` you requested, request less next time: smaller requests
usually wait less in the queue. Ignore the ``user`` and ``sys`` lines here.

How much memory your job needs
------------------------------

If your job needs more memory than it requested, Slurm stops it and says so
in the ``.err`` file. See :ref:`job-out-of-memory` to recognize the message
and fix it.
