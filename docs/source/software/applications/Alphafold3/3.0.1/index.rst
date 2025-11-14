.. _alphafold3-3.0.1-index:

AlphaFold3 3.0.1
================

.. contents:: Table of Contents

Basic Information
-----------------

- **Official repository**: https://github.com/google-deepmind/alphafold3.git
- **License**: Attribution-NonCommercial-ShareAlike 4.0 International
- **Installed on**: Apolo II
- **Official Information**: https://deepmind.google/science/alphafold/

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux (8.10)
- **Dependencies:**
    - python == 3.11 (conda environment)
    - hmmer == 3.4 (module dependency)
    - zlib == 1.2.1 (module dependency)
    - zstd == 1.5.2 (module dependency)

Installation
------------

An important note is that AlphaFold3 on Apolo II is installed in a conda environment, instead of a container (its standard usage method). This is due to policies, then the installation steps are different from the official documentation.

For the installation, you need to follow these steps:

1. Load AlphaFold3 module:

   .. code-block:: bash

      module load alphafold3/3.0.1_gcc-11.2.0

   This will load the necessary dependencies and environment variables.

2. Copy the **yml** file with the necessary dependencies and environment variables and create the conda environment:

   .. code-block:: bash

      cd /home/$USER
      cp /share/apps/alphafold3/3.0.1/gcc-11.2.0/alphafold3.yml .
      conda env create -f alphafold3.yml



3. Install the AlphaFold3 package in the conda environment:

   .. code-block:: bash

      conda activate alphafold3
      pip install --no-deps $alphafold3_accel2

Module
------

.. code-block:: bash

    #%Module

    ##  alphafold3.0.1_gcc-11.2.0
    ##  "URL: https://blog.google/technology/ai/google-deepmind-isomorphic-alphafold-3-ai-model/"
    ##  "SOURCE_CODE: https://github.com/google-deepmind/alphafold3"
    ##  "LICENCE: Attribution-NonCommercial-ShareAlike 4.0 International"
    ##  "LICENCE_URL: https://github.com/google-deepmind/alphafold3/blob/main/LICENSE"
    ##  "Category: Library"

    module-whatis "AlphaFold 3 is a cutting-edge deep learning system developed by DeepMind for predicting the 3D structures of biomolecules, including Proteins, DNA, RNA and Ligands."

    proc ModulesHelp { } {
        puts stderr "Purpose"
        puts stderr "-------"
        puts stderr "ALPHAFOLD3 - For predicting the structure of proteins, DNA, RNA, ligands and more, and how they interact, we hope it will transform our understanding of the biological world and drug discovery."

        # Detailed Information
        puts stderr "\nTechnical information:"
        puts stderr "Compiler: gcc/11.2.0"
        puts stderr "Dependencies at run time:\n"
        puts stderr "  hmmer"
        puts stderr "  zlib"
        puts stderr "  zstd"
    }

    set     compiler   gcc-11.2.0
    set     version    3.0.1
    set     sys        x86_64-redhat-linux
    set     topdir     /share/apps/alphafold3/${version}/${compiler}

    if {![is-loaded zlib]} {
        module load zlib-1.2.11-gcc-11.2.0-y3opf4s
    }

    if {![is-loaded zstd]} {
        module load zstd/1.5.2_gcc-11.2.0
    }

    if {![is-loaded hmmer]} {
        module load hmmer/3.4_gcc-11.2.0
    }

    prepend-path    alphafold3_accel2   $topdir/alphafold3-3.0.1-cp311-cp311-linux_x86_64.whl

Usage
-----

1. To use AlphaFold3, you need the parameters file, which you need to request from Google (more information on the official repository). If you are not using preprocessed data and you need the complete database (please do not download it to your home directory), please contact the administrators for instructions. When you have the parameters, save them in a directory and use the path to this directory when you run the job.

2. The only node on Apollo II with a compatible GPU is **accel-2**, so you need to submit your job to this node, and also you need to use a special option when you run the job: ``--flash_attention_implementation=xla``. This is because **accel-2** has Tesla V100 GPUs, which have compute capability 7.0, and AlphaFold3 requires a compute capability of 8.0 or higher for the flash attention implementation.

3. You need to clone the AlphaFold3 repository, and then you need to run the script ``run_alphafold.py`` with the necessary parameters. You can see an example below.

4. Before running the job you need to run the ``build_data`` or the job will fail.

Slurm Example
-------------

The next example uses preprocessed data, so there is no need to do a data pipeline, and it is only for example purposes. You need to change the parameters and the paths to your data.

.. code-block:: bash

    #!/bin/bash
    #SBATCH --partition=accel-2
    #SBATCH --nodes=1
    #SBATCH --nodelist=compute-0-11
    #SBATCH --time=04:00:00
    #SBATCH --gres=gpu:1
    #SBATCH --job-name=alpha_test
    #SBATCH -o /home/jevalencib/run_alphafold/%x_%j.out
    #SBATCH -e /home/jevalencib/run_alphafold/%x_%j.err
    #SBATCH --mail-type=BEGIN,END,FAIL
    #SBATCH --mail-user=user@eafit.edu.co

    # Load necessary modules
    module load alphafold3/3.0.1_gcc-11.2.0

    # Configuration
    export RUN_ALPHAFOLD_DIR=/home/jevalencib/run_alphafold
    conda activate alphafold3
    cd /home/jevalencib/apps/ALPHAFOLD3/alphafold3

    # Only for debugging
    echo "Running AlphaFold3 inference on $(hostname) with job ID $SLURM_JOB_ID"
    echo $XLA_FLAGS
    echo $XLA_PYTHON_CLIENT_PREALLOCATE
    echo $XLA_CLIENT_MEM_FRACTION
    echo "$(which python)"
    echo "Beginning AlphaFold3 inference"

    # Run AlphaFold3 inference
    python run_alphafold.py --input_dir=$RUN_ALPHAFOLD_DIR/af_input/processed       \
                            --model_dir=$RUN_ALPHAFOLD_DIR/models                   \
                            --output_dir=$RUN_ALPHAFOLD_DIR/af_output               \
                            --flash_attention_implementation=xla                    \
                            --norun_data_pipeline

Resources
---------

* https://github.com/google-deepmind/alphafold3

Author
------

* Julian Valencia Bolaños
