.. _frequent-problems:

Frequent problems
=================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28

Find the problem you have in the tables below and follow the link to its
solution. If it is not here, see `Still stuck?`_ at the end.

.. toctree::
   :hidden:

   job-failed

Access and VPN
--------------

.. list-table::
   :header-rows: 1
   :widths: 50 50

   * - Problem
     - Solution
   * - I do not have an account.
     - :ref:`request-an-account`
   * - The VPN client does not connect, or keeps "spinning" on macOS.
     - :ref:`VPN troubleshooting <vpn-troubleshooting>`
   * - ``ssh`` waits and ends with ``Connection timed out``.
     - The VPN is not connected. See :ref:`connect-to-apolo`.
   * - ``Permission denied, please try again.`` when logging in.
     - Check the username, the password and the cluster address.
       See :ref:`connect-to-apolo`.
   * - I do not know which cluster my account is on.
     - Ask the Apolo staff (see `Still stuck?`_).

Jobs
----

.. list-table::
   :header-rows: 1
   :widths: 50 50

   * - Problem
     - Solution
   * - My job failed, and I do not know why.
     - :ref:`job-failed`
   * - My job was stopped because of the time limit.
     - :ref:`job-timeout`
   * - My job ran out of memory.
     - :ref:`job-out-of-memory`
   * - My job stays pending (``PD``) and never starts.
     - :ref:`job-pending`
   * - ``sbatch`` says ``Invalid partition name specified``.
     - The partition does not exist on that cluster. See the partitions of
       :ref:`Apolo II <about_apolo-ii>` and :ref:`apolo-3`.
   * - ``sbatch`` says the script contains DOS line breaks.
     - :ref:`job-rejected`
   * - I want to test my script before running the real job.
     - :ref:`testing-slurm`
   * - What is the difference between ``-N``, ``-n`` and ``-c``? When should I
       use ``srun``?
     - :ref:`faq-slurm`

Software
--------

.. list-table::
   :header-rows: 1
   :widths: 50 50

   * - Problem
     - Solution
   * - I cannot find the program I need.
     - :ref:`use-scientific-software`
   * - ``module load`` says ``The following module(s) are unknown``.
     - :ref:`find-software`
   * - I need a program that is not installed.
     - :ref:`software-not-installed`
   * - OpenFOAM v2606 fails.
     - :ref:`openfoam-v2606-troubleshooting`
   * - A specific program fails.
     - Check the Troubleshooting section of its page in :ref:`software`.

Files and usage
---------------

.. list-table::
   :header-rows: 1
   :widths: 50 50

   * - Problem
     - Solution
   * - I need to copy files to or from the cluster.
     - :ref:`transfer-files`
   * - I want to know how long my jobs take, or how much memory they need.
     - :ref:`check-resource-usage`

Still stuck?
------------

Write to apolo@eafit.edu.co, or open an issue as described in
:ref:`report-a-bug`. Say which cluster you use, what you were trying to do,
the exact command and the full error message; for jobs, include the job ID.
