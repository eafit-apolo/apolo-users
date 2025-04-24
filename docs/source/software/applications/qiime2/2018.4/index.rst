.. _2018.4-index:

.. role:: bash(code)
   :language: bash

Qiime2 2018.4
=============

.. contents:: Table of Contents

Basic information
-----------------
- **Installation Date:**  15/06/2018
- **URL:** https://docs.qiime2.org/2018.4
- **License:** BSD 3-Clause License
- **Installed on:** Apolo II & Cronos

Tested on (Requirements)
------------------------

* **Dependencies to run Qiime2:**
    * Python >= 3.6.5 (Miniconda)

Installation
------------

#. Charge the environment and perform the following steps for installation:

    .. code-block:: bash

        module load python/3.6.5_miniconda-4.5.1
        cd /home/mgomezzul/apps/qiime2
        wget https://data.qiime2.org/distro/core/qiime2-2018.4-py35-linux-conda.yml
        conda env create -n qiime2-2018.4 --file qiime2-2018.4-py35-linux-conda.yml

Mode of Use
-----------

Load the necessary environment through the modules:

    .. code-block:: bash

        module load python/3.6.5_miniconda-4.5.1
        source activate qiime2-2018.4

SLURM Template
--------------

    .. code-block:: bash

        #!/bin/sh

        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --ntasks-per-node=16
        #SBATCH --time=10:00
        #SBATCH --job-name=qiime2_test
        #SBATCH -o result_%N_%j.out
        #SBATCH -e result_%N_%j.err

        # Don't share environment variables
        export SBATCH_EXPORT=NONE
        export OMP_NUM_THREADS=$SLURM_NTASKS

        module load python/3.6.5_miniconda-4.5.1

        source activate qiime2-2018.4

        qiime tools import --type EMPPairedEndSequences \
            --input-path /home/mgomezzul/test/qiime2/source \
            --output-path /home/mgomezzul/test/qiime2/result.qza

Input files
-----------

- Remember to create the **source** directory in the place where the **slurm.sh** file is located
- Have the files (**barcodes.fastq.gz, forward.fastq.gz, reverse.fastq.gz**)


References
----------

- https://docs.qiime2.org/2018.4/install/native/#install-qiime-2-within-a-conda-environment
- https://anaconda.org/qiime2/qiime2
- https://wiki.hpcc.msu.edu/display/ITH/QIIME+2
- https://hpc.research.uts.edu.au/software_specific/software_qiime2/

Authors
-------

- Mateo Gómez Zuluaga
