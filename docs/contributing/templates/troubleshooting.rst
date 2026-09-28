.. TEMPLATE: known problems of one topic and how to fix them.
   Copy to: troubleshooting.rst next to the page it is about.
   Write one section per problem, titled with what the user sees, and
   copy error messages exactly. Everything below is an example: replace
   it, then delete this comment.

.. _minimap2-2.28-troubleshooting:

Minimap2 2.28 troubleshooting
=============================

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo 3

Known problems when running Minimap2 2.28, and how to solve them.

"minimap2: command not found" in the job
----------------------------------------

The ``.err`` file of the job shows:

.. code-block:: text

   /var/spool/slurmd/job123456/slurm_script: line 14: minimap2: command not found

**Cause:** the job script does not load the module.

**Solution:** add the module to the ``ENVIRONMENT`` block of the script:

.. code-block:: bash

   module load minimap2/2.28

The job stops before finishing
------------------------------

The ``.err`` file ends with:

.. code-block:: text

   slurmstepd: error: *** JOB 123456 ON <node> CANCELLED AT 2026-09-28T10:00:00 DUE TO TIME LIMIT ***

**Cause:** the job reached its ``--time`` limit.

**Solution:** request more time, for example ``#SBATCH --time=0-04:00:00``.
