.. _gromacs-3.0.0-index:

.. role:: bash(code)
   :language: bash

GROMACS 2019.3
==============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://manual.gromacs.org/documentation/
- **License:** GNU Lesser General Public License (LGPL), version 2.1.
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Compiler:** Intel MPI Library :math:`\boldsymbol{\ge}` 17.0.1 (Apolo)
* **Math Library:** FFTW 3.3.8 (Built in) and OpenBlas 0.2.19


Installation
------------

The following procedure present the way to compile **GROMACS 2019.3**
for parallel computing using the GROMACS built-in thread-MPI and CUDA. [1]_


.. note:: For the building, the Intel compiler 2017 was used due to compatibility issues with CUDA
          which only supports, for Intel as backend compiler, up to 2017 version.

#. Download the latest version of GROMACS

   .. code-block:: bash

      $ wget http://ftp.gromacs.org/pub/gromacs/gromacs-2019.3.tar.gz
      $ tar xf gromacs-2019.3.tar.gz

#. Inside the folder, on the top create a :file:`build` directory where the installation binaries will be put by cmake.

   .. code-block:: bash

        $ cd gromacs-2019.3
        $ mkdir build
        $ cd build

#. Load the necessary modules for the building.

   .. code-block:: bash

        $ module load cmake/3.7.1 \
                      cuda/9.0 \
                      openblas/0.2.19_gcc-5.4.0 \
                      intel/2017_update-1 \
                      python/2.7.15_miniconda-4.5.4

#. Execute the cmake command with the desired directives.

   .. code-block:: bash

        $ cmake .. -DGMX_GPU=on -DCUDA_TOOLKIT_ROOT_DIR=/share/apps/cuda/9.0/ -DGMX_CUDA_TARGET_SM="30;37;70" \
                    -DGMX_SIMD=AVX2_256 -DCMAKE_INSTALL_PREFIX=/share/apps/gromacs/2019.3_intel-17_cuda-9.0 \
                    -DGMX_FFT_LIBRARY=fftw3 -DGMX_BUILD_OWN_FFTW=ON -DGMX_EXTERNAL_BLAS=on -DREGRESSIONTEST_DOWNLOAD=on

   .. note:: The above command will enable the GPU usage with CUDA for the specified architecures, sm_30 and sm_37 for
             Tesla K80 and sm_70 for V100 because these are the GPUs used in Apolo. [2]_

   .. note:: For "FFT_LIBRARY" there are some options like Intel MKL. Generally, it is recommended to use the FFTW because
            there is no advantage in using MKL with GROMACS, and FFTW is often faster. [1]_

   To build the distributed GROMACS version you have to use an MPI library. The GROMACS team recommends
   OpenMPI version 1.6 (or higher), MPICH version 1.4.1 (or higher).

   .. code-block:: bash
      :emphasize-lines: 4

      $ module load cmake/3.7.1 \
                    cuda/9.0 \
                    openblas/0.2.19_gcc-5.4.0 \
                    openmpi/1.10.7_gcc-5.4.0 \
                    python/2.7.15_miniconda-4.5.4

   .. code-block:: bash

        $ cmake .. -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DGMX_MPI=on -DGMX_GPU=on \
                   -DCUDA_TOOLKIT_ROOT_DIR=/share/apps/cuda/9.0/ -DGMX_CUDA_TARGET_SM="30;37;70" \
                   -DGMX_SIMD=AVX2_256 -DCMAKE_INSTALL_PREFIX=/share/apps/gromacs/2019.3_intel-17_cuda-9.0 \
                   -DGMX_FFT_LIBRARY=fftw3 -DGMX_BUILD_OWN_FFTW=ON -DGMX_EXTERNAL_BLAS=on -DREGRESSIONTEST_DOWNLOAD=on

   **For more information about the compile options you can refer to the Gromacs Documentation.** [1]_

#. Execute the make commands sequence.

   .. code-block:: bash

        $ make -j <N>
        $ make check
        $ make -j <N> install

   .. warning:: Some tests may fail, but the installation can continue depending on the number of failed tests.

Usage
-----

This section describes a way to submit jobs with the resource manager SLURM.

#. Load the necessary environment.

   .. code-block:: bash

      # Apolo
      module load gromacs/2019.3_intel-17_cuda-9.0

      # Cronos
      module load gromacs/2016.4_gcc-5.5.0

#. Run Gromacs with SLURM.

   a. An example with GPU (Apolo), given by one of our users:

     .. literalinclude:: src/example_simulation/gpu/sbatch.sh
        :language: bash
        :linenos:

     Note lines 18, 28, 31, 43, 47 the use of :bash:`gmx mdrun` with the flag :bash:`-gpu_id 01`:

     * If Gromacs was compiled with Cuda, it will use the GPUs available by default.
     * The flag :bash:`-gpu_id 01` tells Gromacs which GPUs can be used. The :bash:`01` means use GPU with device ID 0 and GPU with device ID 1.
     * Note in line 9 the use of :bash:`#SBATCH --gres=gpu:2`. :bash:`gres` stands for *generic resource scheduling*. :bash:`gpu` requests GPUs to Slurm, and :bash:`:2` specifies the quantity.
     * Note that we have 3 GPUs in Accel-2, but we are indicating only two GPUs. This is useful when some other user is using one or more GPUs.
     * Also, note that the number of tasks per node must be a multiple of the number of GPUs that will be used.
     * Setting a :bash:`cpus-per-task` to a value between 2 and 6 seems to be more efficient than values greather than 6.
     * The files needed to run the example above are :download:`here <src/example_simulation/gpu/gromacs_example_gpu.zip>`.
     * For more information see [3]_.

   b. An example with CPU only (Cronos):

     .. literalinclude:: src/example_simulation/cpu/sbatch.sh
        :language: bash
        :linenos:

     * Note the use of :bash:`gmx_mpi` instead of :bash:`gmx`.
     * Also, note the use of :bash:`srun --mpi=pmi2` instead of :bash:`mpirun -np <num-tasks>`. The command :bash:`srun --mpi=pmi2` gives to :bash:`gmx_mpi` the context of where and how many tasks to run.
     * In lines 13 and 14 note that it is requesting 4 nodes and 16 mpi tasks on each node. Recall that each node in Cronos has 16 cores.
     * In lines 16, 29, 32, 36, 40, 44 note that :bash:`srun --mpi=pmi2` is not used. This is due that, those are preprocessing steps, they do not need to run distributedly.
     * The needed files to run the example simulation can be found :download:`here <src/example_simulation/cpu/gromacs_example_cpu.zip>`.


References
----------

.. [1] GROMACS Documentation. (2019, June 14). GROMACS. Fast, Flexible and Free.
       Retrieved July 10, 2019, from http://manual.gromacs.org/documentation/current/manual-2019.3.pdf

.. [2] Matching SM architectures. (2019, November 11). Blame Arnon Blog.
       Retrieved July 10, 2019, from https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/

.. [3] Getting good performance from mdrun. (2019). GROMACS Development Team.
       Retrieved September 3, 2019, from http://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html#running-mdrun-within-a-single-node

Authors
-------

- Johan Sebastián Yepes Ríos <jyepesr1@eafit.edu.co>
- Hamilton Tobón Mosquera <htobonm@eafit.edu.co>
