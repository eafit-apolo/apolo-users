.. _openfoam-v2606-troubleshooting:

OpenFOAM v2606 troubleshooting
==============================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-10-08
:Applies to: Apolo II

Known problems when running OpenFOAM v2606, and how to solve them. The
examples refer to the job layout of :ref:`openfoam-v2606`.

``module load openfoam/v2606`` says the module does not exist
-------------------------------------------------------------

**Cause:** your cached list of modules is outdated.

**Solution:** delete the cache and load the module again.

#. Delete the cache:

   .. code-block:: bash

      rm -rf ~/.cache/lmod

#. Load the module:

   .. code-block:: bash

      module load openfoam/v2606

The job ends immediately and there is nothing in ``logs/``
----------------------------------------------------------

**Cause:** the ``logs`` directory does not exist, or ``sbatch`` was run from
another directory.

**Solution:** create ``logs`` and run ``sbatch`` from the job directory.

#. Go to the job directory:

   .. code-block:: bash

      cd ~/pitzDaily-test

#. Create the ``logs`` directory:

   .. code-block:: bash

      mkdir logs

#. Submit the job again:

   .. code-block:: bash

      sbatch job.sh

"Permission denied" when running ``./bin/…``
--------------------------------------------

**Cause:** the scripts are not executable.

**Solution:** make them executable and submit the job again:

.. code-block:: bash

   chmod +x bin/mesh.sh bin/solve.sh bin/reconstruct.sh

"There are not enough slots available"
--------------------------------------

**Cause:** the solver asks for more processes than ``--ntasks``.

**Solution:** in :file:`bin/solve.sh`, use ``$SLURM_NTASKS`` instead of a
fixed number:

.. code-block:: bash

   openfoam mpirun -np "$SLURM_NTASKS" simpleFoam -parallel -case pitzDaily

An error about ``numberOfSubdomains``
-------------------------------------

**Cause:** ``numberOfSubdomains`` in :file:`system/decomposeParDict` and
``--ntasks`` in :file:`job.sh` are different.

**Solution:** use the same number in both.

"No such file or directory" with your case
------------------------------------------

**Cause:** the case is outside your home directory, where OpenFOAM cannot
see it.

**Solution:** move the case to your home directory
(:file:`/home/{username}`). If you need to use another location, contact the
Apolo staff.
