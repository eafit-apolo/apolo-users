.. _about_apolo-ii:

Apolo II
========

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28

Apolo II is one of the two clusters of the Apolo Scientific Computing Center
in service, together with :ref:`apolo-3`. Your account gives you access to one
or both of them; if you are not sure which, ask the Apolo staff.

Connection
----------

- **Address:** ``apolo.eafit.edu.co``
- **Access:** SSH, only while connected to the Apolo VPN.

.. code-block:: bash

   ssh <username>@apolo.eafit.edu.co

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
   * - ``debug``
     - Short test runs, to check that a job script works before you submit
       the real job. See :ref:`testing-slurm`.
   * - ``bigmem``
     - Jobs that need a large amount of memory.
   * - ``accel``
     - Jobs that use GPUs. Request them with ``#SBATCH --gres=gpu:<count>``.
   * - ``learning``
     - Jobs of undergraduate students, for any work they do during their studies.

To see the partitions, their time limits and how many nodes are free right
now, run this on the cluster:

.. code-block:: bash

   sinfo -s
