.. _apolo-3:

Apolo 3
=======

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28

Apolo 3 is one of the two clusters of the Apolo Scientific Computing Center in
service, together with :ref:`Apolo II <about_apolo-ii>`. Your account gives
you access to one or both of them; if you are not sure which, ask the Apolo
staff.

Connection
----------

- **Address:** ``200.12.187.180``
- **Access:** SSH, only while connected to the Apolo VPN.

.. code-block:: bash

   ssh <username>@200.12.187.180

See :ref:`connect-to-apolo` for the full steps.

Partitions
----------

A partition is a group of nodes that Slurm uses to run a certain kind of job.
Choose one with ``#SBATCH --partition=<name>`` in your job script.

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Partition
     - Use it for
   * - ``longjobs``
     - General jobs.
   * - ``bigmem``
     - Jobs that need a large amount of memory.
   * - ``accel``
     - Jobs that use GPUs. Request them with ``#SBATCH --gres=gpu:<count>``.

Apolo 3 has no ``debug`` partition. To test a job script, submit it to
``longjobs`` with a small input and a short ``--time``.

To see the partitions, their time limits and how many nodes are free right
now, run this on the cluster:

.. code-block:: bash

   sinfo -s

Software modules
----------------

Apolo 3 organizes its modules in a hierarchy: some programs only become
visible after you load the compiler and MPI library they were built with. To
find a program and see which modules it needs first, use ``module spider``:

.. code-block:: bash

   module spider <program>

If a software page shows a ``module use <path>`` line before
``module load``, run it too. See :ref:`use-scientific-software`.
