.. _2.7.0-index:

.. role:: bash(code)
   :language: bash

TensorFlow 2.7.0
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

1. Load the necessary modules and install TensorFlow 2.7.0 in your environment:

    .. code-block:: bash

        module load python
        module load tensorflow/2.7_gcc-10.3.0-oneapi-2022.0.0-pkk745h

2. Create and activate your environment with Python 3.9:

    .. code-block:: bash

        conda env create -n yourenvname python=3.9
        conda activate yourenvname

3. Install TensorFlow for Apolo(accel):

    .. code-block:: bash

        pip install $tf_accel

Mode of Use
-----------

Load the necessary modules, activate your environment, and install TensorFlow as shown above. Once activated:

    .. code-block:: bash

        conda activate yourenvname
        pip install $tf_accel

You can now run any Python script using `import tensorflow` as usual.

SLURM Template
--------------

    .. code-block:: bash

        #!/bin/sh
        #SBATCH --partition=accel
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
        module load tensorflow/2.7_gcc-10.3.0-oneapi-2022.0.0-pkk745h

        source activate yourenvname

        python -c "import tensorflow as tf; print('Num GPUs Available:', len(tf.config.list_physical_devices('GPU')))"

Compilation
-----------

1. Load the necessary modules:

    .. code-block:: bash

        module load python/3.9_miniconda-4.10.3
        module load bazel-3.7.2-gcc-10.3.0-zhgjyn7
        module load gcc-10.3.0-oneapi-2022.0.0-pkk745h
        module load openjdk-11.0.12_7-oneapi-2022.0.0-qr72bsf
        module load cuda-11.2.2-oneapi-2022.0.0-oemftwp
        module load cudnn-8.1.1.33-11.2-oneapi-2022.0.0-62fa2gf

2. Clone the repository and navigate to the directory:

    .. code-block:: bash

        git clone https://github.com/tensorflow/tensorflow.git
        cd tensorflow

    By default, this repository is on the `master` branch. Switch to a release branch if needed (e.g., r2.11):

    .. code-block:: bash

        git checkout r2.7

3. Configure compilation parameters:

    Run the configuration script:

    .. code-block:: bash

        ./configure

    - Select **Yes** for the CUDA option.
    - Provide the versions of CUDA (11.2) and cuDNN (8.1) when prompted.
    - Set compute capability to `3.7,7.0` for K80 and V100 GPUs, respectively.

    Use paths corresponding to CUDA and cuDNN versions:

    .. code-block:: bash

        /share/apps/spack/opt/spack/linux-rocky8-broadwell/oneapi-2022.0.0/cuda-11.2.2-oemftwp7zntabzspvgejuoaoj4ms5me3/lib64,/share/apps/spack/opt/spack/linux-rocky8-broadwell/oneapi-2022.0.0/cuda-11.2.2-oemftwp7zntabzspvgejuoaoj4ms5me3/include,/share/apps/spack/opt/spack/linux-rocky8-broadwell/oneapi-2022.0.0/cuda-11.2.2-oemftwp7zntabzspvgejuoaoj4ms5me3/bin,/share/apps/spack/opt/spack/linux-rocky8-broadwell/oneapi-2022.0.0/cuda-11.2.2-oemftwp7zntabzspvgejuoaoj4ms5me3/,/share/apps/spack/opt/spack/linux-rocky8-broadwell/oneapi-2022.0.0/cudnn-8.1.1.33-11.2-62fa2gf5ok5usibjycgsfjaos5qwucov/lib64,/share/apps/spack/opt/spack/linux-rocky8-broadwell/oneapi-2022.0.0/cudnn-8.1.1.33-11.2-62fa2gf5ok5usibjycgsfjaos5qwucov/include,/share/apps/spack/opt/spack/linux-rocky8-broadwell/oneapi-2022.0.0/cudnn-8.1.1.33-11.2-62fa2gf5ok5usibjycgsfjaos5qwucov/

4. Build TensorFlow:

    .. code-block:: bash

        bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package

    Once complete, the compiled `.whl` file will be located in:

    .. code-block:: bash

        ./bazel-bin/tensorflow/tools/pip_package/

5. Install TensorFlow:

    Install the compiled `.whl` file in a virtual environment using the same Python version used for compilation:

    .. code-block:: bash

        pip install /home/user/route/to/your/wheel

References
----------

- TensorFlow: https://www.tensorflow.org/install/source

Authors
-------

- Sebastián Andrés Uribe Ruiz
