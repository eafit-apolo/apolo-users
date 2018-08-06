.. _mafft-7.402-index:

.. role:: bash(code)
    :language: bash

MAFFT 7.402
===========

Basic Information
-----------------

- **Deploy date:** 27 July 2018
- **Official Website:** https://mafft.cbrc.jp/alignment/software/
- **Instaled on:** :ref:`Apolo II <about_apolo-ii>`, 
  :ref:`Cronos <about_cronos>`

Installation
------------

This entry covers the entire process performed for the installation and configuration of MAFFT with extension (MXSCARNA, Foldalign and CONTRAfold) on a cluster.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----

For using Mafft with a command line would be with this form :bash:`mafft [arguments] input > output` . But in this case, we will show how to run Mafft with `SLURM <https://www.schedmd.com/>`_.


For example:

.. code-block:: bash

   #!/bin/bash
   
   #SBATCH --partition=longjobs
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=32
   #SBATCH --time=120:00:00
   #SBATCH --job-name=test
   #SBATCH -o result_%N_%j.out      # File to which STDOUT will be written
   #SBATCH -e result_%N_%j.err      # File to which STDERR will be written
   #SBATCH --mail-type=ALL                                                                                       
   #SBATCH --mail-user=test@example.com

   export SBATCH_EXPORT=NONE
   export OMP_NUM_THREADS=1

   #mafft [OPTIONS] arch.in > arch.out
   mafft --quiet --auto --thread $SLURM_NTASKS ITS.fa > ITS_al.fa
   mafft --quiet --localpair --adjustdirectionaccurately --op 2 --maxiterate 1000 --thread $SLURM_NTASKS HA.fasta > HA_al.fa

For more information, please read the manual entry for Mafft :bash:`man mafft` or :bash:`mafft -h`
   

Authors
-------

- Manuela Carrasco Pinzón
