.. abyss-2.2.3:

.. role:: bash(code)
   :language: bash

ABySS 2.2.3
===========

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://github.com/bcgsc/abyss
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Dependencies:**
    - :ref:`Google Sparsehash <sparsehash>`
    - :ref:`ARCS <arcs>`
    - :ref:`Tigmint <tigmint>`
    - Boost
    - Open MPI or MVAPICH
- **Optional dependencies:**
    - :ref:`Pigz <pigz>`
    - Samtools
    - zsh

Installation
------------
#. Before compiling and installing ABySS install all its dependencies. After installing all the dependencies run:

    .. code-block:: bash

        $ module load gcc/5.4.0
        $ module load boost/1.67.0_intel-17.0.1
        $ module load mvapich2/2.2.3a_gcc-5.4.0
        $ module load sparsehash/2.0.3_intel-19.0.4
        $ wget https://github.com/bcgsc/abyss/releases/download/2.2.3/abyss-2.2.3.tar.gz
        $ tar xvf abyss-2.2.3.tar.gz
        $ cd abyss-2.2.3
        $ mkdir build && cd build
        $ CFLAGS="-O3 -mavx2 -fopenmp" CXXFLAGS="-O3 -mavx2 -fopenmp" ../configure --prefix=/share/apps/abyss/2.2.3/gcc/5.4.0 --enable-mpich --with-mpi=/share/apps/mvapich2/2.2.3a/gcc-5.4.0
        $ make -j10
        $ make check

    Make sure all the tests passed. Then install it:

    .. code-block:: bash

        $ sudo make install

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/2.2.3_gcc-5.4.0
        :language: bash
        :caption: :download:`2.2.3_gcc-5.4.0 <src/2.2.3_gcc-5.4.0>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/abyss
        $ sudo mv 2.2.3_gcc-5.4.0 /share/apps/modules/abyss/

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
