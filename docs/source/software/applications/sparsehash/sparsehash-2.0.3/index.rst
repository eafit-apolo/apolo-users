.. _sparsehash-2.0.3:

.. role:: bash(code)
   :language: bash

.. role:: c(code)
   :language: c

Google Sparsehash 2.0.3
=======================

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://github.com/sparsehash/sparsehash
- **License:** BSD 3-Clause
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------

.. note::
    Note that the compiler used is `Intel 2019 <https://software.intel.com/en-us/articles/intel-c-compiler-190-for-linux-release-notes-for-intel-parallel-studio-xe-2019>`.
    Also, if the compiler to be used is different than this one, the compiler flag :bash:`-xHost` might be different.

#. Follow these steps, run:

    .. code-block:: bash

        $ git clone https://github.com/sparsehash/sparsehash
        $ cd sparsehash && mkdir build && cd build
        $ module load intel/19.0.4
        $ CFLAGS="-O3 -xHost" CXXFLAGS="-O3 -xHost" ../configure --prefix=/share/apps/sparsehash/2.0.3/intel/19.0.4
        $ make && make check
        $ sudo mkdir -p /share/apps/sparsehash/2.0.3/intel/19.0.4
        $ sudo make install

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/2.0.3_intel-19.0.4
        :language: bash
        :caption: :download:`2.0.3_intel-19.0.4 <src/2.0.3_intel-19.0.4>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/sparsehash/
        $ sudo mv 2.0.3_intel-19.0.4 /share/apps/modules/sparsehash/

Usage
-----
Load the module:

    .. code-block:: bash

        $ module load sparsehash/2.0.3_intel-19.0.4

If it's being used to compile an application, loading the module should be enough. If it's being used to code something, include its header files:

    .. code-block:: c++

        #include <sparsehash/sparse_hash_map> // or sparse_hash_set, dense_hash_map ...

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
