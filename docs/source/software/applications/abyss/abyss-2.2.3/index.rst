.. abyss-2.2.3:

ABySS 2.2.3
===========

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://github.com/bcgsc/abyss
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Dependencies:**
    - C++ compiler that supports OpenMP such as GCC.
    - :ref:`Google Sparsehash <sparsehash>`
    - ARCS
    - Tigmint
    - Pigz
    - Samtools
    - Zsh
    - Boost
    - Open MPI or MVAPICH

Installation
------------
Before compiling and installing Abyss install all its dependencies.
To install Google Sparsehash follow the instructions here.
After installing all the dependencies run:

.. code-block:: bash

    $ module load boost
    $ module load mvapich
    $ module load sparsehash
    $ module load arcs
    $ module load tigmint
    $ conda activate <env-with-tigmint>
    $ module load pigz
    $ module load zsh

Usage
-----

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>