.. _2.11.0-index:

.. role:: bash(code)
   :language: bash

TensorFlow 2.11.0
================

.. contents:: Table of Contents

Basic Information
-----------------
- **Installation Date:** 27/09/2024
- **URL:** https://www.tensorflow.org
- **License:** Apache 2.0 License
- **Installed on:** Apolo II

Tested on (Requirements)
------------------------
- **Python Version for Module:** 3.12 (default module version)
- **Python Version for Environment:** 3.9

Installation
------------

This version is intended for accel-2

1. Load the necessary modules and install TensorFlow 2.11.0 in your environment:

    .. code-block:: bash

        module load python
        module load tensorflow/2.11_gcc-10.3.0-oneapi-2022.0.0-pkk745h

2. Create and activate your environment with Python 3.9:

    .. code-block:: bash

        conda env create -n yourenvname python=3.9
        conda activate yourenvname

3. Install TensorFlow for Apolo(accel-2):

    .. code-block:: bash

        pip install $tf_accel2

Mode of Use
-----------

Load the necessary modules, activate your environment, and install TensorFlow as shown above. Once activated:

    .. code-block:: bash

        conda activate yourenvname
        pip install $tf_accel2

You can now run any Python script using `import tensorflow` as usual.

SLURM Template
--------------

    .. code-block:: bash

        #!/bin/sh
        #SBATCH --partition=accel-2
        #SBATCH --nodes=1
        #SBATCH --ntasks=1
        #SBATCH --gres=gpu:2
        #SBATCH --time=30:00
        #SBATCH --job-name=test_TF
        #SBATCH -o %x_%j.out      # File to which STDOUT will be written
        #SBATCH -e %x_%j.err      # File to which STDERR will be written
        #SBATCH --mail-type=ALL
        #SBATCH --mail-user=sauriber2@eafit.edu.co

        # Load modules and activate the environment
        module load python/3.12_miniconda-24.7.1
        module load tensorflow/2.11_gcc-10.3.0-oneapi-2022.0.0-pkk745h

        source activate yourenvname

        python -c "import tensorflow as tf; print('Num GPUs Available:', len(tf.config.list_physical_devices('GPU')))"

References
----------

- TensorFlow: https://www.tensorflow.org/install/source

Authors
-------

- Sebastián Andrés Uribe Ruiz
