.. _wrf-3.12-installation:

.. role:: bash(code)
    :language: bash

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- **Compiler:** GCC :math:`\boldsymbol{\ge}` 7.4.
- **Requirements:**

  * CHARM++ :math:`\boldsymbol{\ge}` 6.8.2 with GCC 7.4.
  * CUDA 10.1 (Optional).

Build process
-------------

#. Download NAMD from the `official website <https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=NAMD>`_, you should create an account and agree the license term.

#. Decompress the tar file.

   .. code-block:: bash

      tar xfz NAMD_2.13_Source.tar.gz
      cd NAMD_2.13_Source

#. Compile CHARM++.

    **Charm++** [1]_ is a parallel object-oriented programming language based on C++ and
    developed in the Parallel Programming Laboratory at the University of Illinois
    at Urbana–Champaign. Charm++ is designed with the goal of enhancing programmer
    productivity by providing a high-level abstraction of a parallel program while
    at the same time delivering good performance on a wide variety of underlying
    hardware platforms.

    #. Decompress it (the namd source files contains the needed source files of CHARM).

       .. code-block:: bash

          tar xf charm-6.8.2.tar
          cd charm-6.8.2

    #. Compile it. The command structure is :bash:`build <target> <version> <options> [charmc-options ...]`

      .. code-block:: bash

         ## To compile NAMD with CUDA
         ./build charm++ multicore-linux-x86_64 smp gcc --with-production

         ## To compile NAMD with MPI
         ./build charm++ mpi-linux-x86_64 mpicxx gcc --with-production

#. Configure the compilation.

   .. code-block:: bash

      ## To compile NAMD with CUDA
      ./config Linux-x86_64-g++ --charm-arch multicore-linux-x86_64 --with-cuda --cuda-prefix /path/to/cuda/10.1/

      ## To compile NAMD with MPI
      ./config Linux-x86_64-g++ --charm-arch mpi-linux-x86_64-mpicxx

#. Compile NAMD.

   .. code-block:: bash

      cd Linux-x86_64-g++
      make -j 4

Module files
------------

- **NAMD with CUDA**

    .. literalinclude:: src/2.13-gcc_CUDA
          :language: bash
          :caption: :download:`2.13-gcc_CUDA <src/2.13-gcc_CUDA>`

- **NAMD with MPI**

    .. literalinclude:: src/2.13-gcc_MPI
          :language: bash
          :caption: :download:`2.13-gcc_MPI <src/2.13-gcc_MPI>`

.. [1] Wikipedia contributors. (2019a, September 11). Charm++. Retrieved December 11, 2019, from https://en.wikipedia.org/wiki/Charm%2B%2B
