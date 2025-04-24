.. _pargenes-master-index:

.. role:: bash(code)
   :language: bash

ParGenes master
===============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/BenoitMorel/ParGenes
- **Download Website:** https://github.com/BenoitMorel/ParGenes.git
- **License:** GNU General Public License v3.0
- **Installed on:** Apolo II

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies to run ParGenes:**
    * GCC 5.0 >  (tested on version 5.4.0)
    * Python 2.7 or 3.X (tested on Python 3.6.5)
    * CMAKE > 3.6 (tested on version 3.7.1)
    * mpich2 (tested on version 3.2)

Installation
------------

The following procedure is the easiest way to install ParGenes (master git version) in a cluster.

#. Clone the git repository of ParGenes in a cluster location (we are going to use the ``$HOME`` directory).

   .. code-block:: bash

    $ git clone --recursive https://github.com/BenoitMorel/ParGenes.git

   .. note::

        ParGenes at the moment only runs via ``.py`` files, therefore is not posible to install it properly in a cluster. Only the user that clones the repo can run ParGenes.



#. Load the dependencies so ParGenes will be able to run, and check the GCC version.

    .. code-block:: bash

        $ module load mpich2/3.2_gcc-5.4.0 python/3.6.5_miniconda-4.5.1 cmake/3.7.1
        $ gcc --version
        gcc (GCC) 5.4.0

#. Now, for being able to run ParGenes please follow these commands:

    .. code-block:: bash

        $ cd ParGenes
        $ ./install.sh

    Now you have ParGenes installed inside your ``$HOME`` directory.

Running Example
----------------

In this section, there is an example run that ParGenes already has.

#.  First, we create a conda environment, so we can run ParGenes in a secure environment (it is not necessary but we recommend it).

    .. code-block:: bash

        $ conda create --name pargenes
        $ conda activate pargenes
        $ cd examples/data/small/
        $ python ../../../pargenes/pargenes-hpc.py -a fasta_files/ -o output_dir -c 32 -d nt -R "--model GTR"

    .. note::
        Make sure to load every module from the beginning, specially mpich2.

    If everything runs without errors, you have installed ParGenes successfully in your ``$HOME`` directory

#. This is an example for Apolo in SLURM.
    .. code-block:: bash

        #!/bin/bash

        #SBATCH --partition=longjobs
        #SBATCH --nodes=2
        #SBATCH --ntasks-per-node=1
        #SBATCH --cpus-per-task=16
        #SBATCH --time=1:00:00
        #SBATCH --job-name=ParGenes
        #SBATCH --partition=longjobs
        #SBATCH -o result_%N_%j.out
        #SBATCH -e result_%N_%j.err

        module load mpich2/3.2_gcc-5.4.0 python/3.6.5_miniconda-4.5.1 cmake/3.7.1

        python ~/scripts/ParGenes/pargenes/pargenes-hpc.py -a ~/Bacillus_subtilis/ParGenes_data/mix_msa -o ~/output_dir_slurm3 -c 32 -d nt -b 10000 -R "--model GTR"

For more information on how to use ParGenes, please visit the official website.

References
----------

 ParGenes - ParGenes Official website.
       Retrieved Octubre 4, 2019, from https://github.com/BenoitMorel/ParGenes/wiki

 Installation - ParGenes Official Website.
       Retrieved Octubre 4, 2019, from https://github.com/BenoitMorel/ParGenes#installation

Authors
-------

- Tomas David Navarro Munera <tdnavarrom@eafit.edu.co>
