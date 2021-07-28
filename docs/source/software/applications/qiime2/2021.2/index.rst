.. _qiime-2021.2-index:

.. role:: bash(code)
    :language: bash

Qiime2 2021.2
=============

Basic Information
-----------------

- **Deploy date:** 28 July 2021
- **Official Website:** https://docs.qiime2.org
- **License:** BSD 3-Clause License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,

Installation
------------

Tested on (Requirements)
""""""""""""""""""""""""

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- Python :math:`\boldsymbol{\ge}` 3.8

Build process
"""""""""""""

This entry described the installation process of Qiime2 in a Conda environment.

#. Create a directory to download the pre-installation

   .. code-block:: bash

      $ mkdir pre-install
      $ cd pre-install

#. Download the dependencies file for your Qiime2 version, in this example
   we download the 2021.2 version.

   .. code-block:: bash

      $ wget https://data.qiime2.org/distro/core/qiime2-2021.2-py36-linux-conda.yml

#. Create the environment.

   .. note::

      - It's highly recommend creating a new environment for each version of QIIME 2 release being installed.
      - Setting up the environment can take several minutes.

   .. code-block:: bash

      $ module load python/3.9_miniconda-4.9.2
      $ conda env create -n qiime2-2021.2 --file qiime2-2021.2-py36-linux-conda.yml
      $ cd ..




Testing
"""""""

For examples go to the following link and follow these steps: https://docs.qiime2.org/2021.2/tutorials/

.. code-block:: bash

   $ mkdir qiime2-read-joining-tutorial
   $ cd qiime2-read-joining-tutorial
   $ wget -O "demux.qza" "https://data.qiime2.org/2021.2/tutorials/read-joining/atacama-seqs.qza"
   $ cd ..


#. Activate the conda environment :bash:`source activate <environment-name>`,
   this example we use the qiime2-2021.4 environment.

   .. code-block::

      conda activate qiime2-2021.4

#. Run a simple command.

   .. code-block::

      qiime --help

Usage
-----

This section describes the method to submit jobs with the resource manager SLURM.

.. code-block::

   #!/bin/sh
   #SBATCH --partition=accel
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=2
   #SBATCH --time=05:00
   #SBATCH --job-name=qiime2_test
   #SBATCH -o resultqiime_%N_%j.out
   #SBATCH -e resultqiime_%N_%j.err
   #SBATCH --mail-type=ALL
   #SBATCH --mail-user=blopezp@eafit.edu.co

   module load python/3.9_miniconda-4.9.2

   source activate qiime2-2021.2

   qiime vsearch join-pairs \
     --i-demultiplexed-seqs qiime2-read-joining-tutorial/demux.qza \
     --o-joined-sequences demux-joined.qza


Authors
-------

- Bryan López Parra <blopezp@eafit.edu.co>
