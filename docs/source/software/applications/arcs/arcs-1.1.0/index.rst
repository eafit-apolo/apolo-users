.. arcs-1.1.0:

ARCS 1.1.0
==========

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://github.com/bcgsc/abyss
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Dependencies:**
    - GCC greather than 4.4.7.
    - :ref:`Google Sparsehash <sparsehash>`
    - Boost
    - :ref:`LINKS <links>`
    - Autotools

Installation
------------
#. Before compiling and installing ARCS install all its dependencies. After installing all the dependencies run:

    .. code-block:: bash

        $ git clone https://github.com/bcgsc/arcs.git
        $ cd arcs
        $ module load gcc/7.4.0
        $ module load boost/1.67.0_intel-17.0.1
        $ module load sparsehash/2.0.3_intel-19.0.4
        $ ./autogen.sh
        $ mkdir build && cd build
        $ ../configure CFLAGS="-O3 -mavx2" CXXFLAGS="-O3 -mavx2" --prefix=/share/apps/arcs/1.1.0/gcc/7.4.0
        $ make -j4 && make check

    Make sure all the checks run correctly. Then install it:

    .. code-block:: bash

        $ mkdir -p /share/apps/arcs/1.1.0/gcc/7.4.0
        $ sudo make install

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/1.1.0_gcc-7.4.0
        :language: bash
        :caption: :download:`1.1.0_gcc-7.4.0 <src/1.1.0_gcc-7.4.0>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/arcs
        $ sudo mv 1.1.0_gcc-7.4.0 /share/apps/modules/arcs/

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
