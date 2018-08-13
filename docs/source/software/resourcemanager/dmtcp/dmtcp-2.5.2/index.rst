.. _dmtcp-2.5.2-index:

.. role:: bash(code)
   :language: bash

DMTCP-2.5.2
===========

Basic Information
-----------------

- **Deploy date:** 3 August 2018
- **Official Website:** http://dmtcp.sourceforge.net/
- **Instaled on:** :ref:`Cronos <about_cronos>`

Installation
------------

This entry covers the entire process performed for the installation and
configuration of DMTCP on a cluster with the conditions described above.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----

This subsection describes a method to submit jobs to the cluster and restarting
them using DMTCP's checkpointing services.

1. Load the necessary environment.

   .. code-block:: bash

      module load dmtcp/2.5.2

2. Run the SLURM script.

   .. code-block:: bash

      #!/bin/bash
      #SBATCH --partition=longjobs
      #SBATCH --nodes=1
      #SBATCH --ntasks-per-node=32
      #SBATCH --time=00:10:00
      #SBATCH --job-name=test
      #SBATCH -o result_%N_%j.out      # File to which STDOUT will be written
      #SBATCH -e result_%N_%j.err      # File to which STDERR will be written
      #SBATCH --mail-type=ALL   
      #SBATCH --mail-user=test@example.com

      export OMP_NUM_THREADS=1
      
      dmtcp_launch --rm ./test <test_args>
      
Authors
-------
- Sebastian Patiño Barrientos <spatino6@eafit.edu.co>
