.. _mothur-.42.3-installation:

.. role:: bash(code)
    :language: bash

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- bzip2
- bzip2-devel
- libz
- zlib-devel
- HDF5

Build process
-------------

#. Load the right environment.

.. code-block:: bash

   module load hdf5

#. Download and decompress the Mothur's source code

.. code-block:: bash

   wget https://github.com/mothur/mothur/archive/v.1.42.3.tar.gz

   tar fxz v.1.42.3.tar.gz

#. Enter to Mothur makefile and edit the PREFIX path and HDF5 file paths.

.. code-block:: bash

   cd mothur-v.1.42.3
   emacs Makefile

.. code-block:: bash

   PREFIX := "/path/to/install/mothur"
   ...
   HDF5_LIBRARY_DIR ?= "/path/to/hdf5/lib"
   HDF5_INCLUDE_DIR ?= "/path/to/hdf5/include"

#. Compile Mothur

.. code-block:: bash

   make

Module Files
------------

Apolo II
^^^^^^^^

.. literalinclude:: src/1.42.3
   :language: tcl
   :caption: :download:`Mothur-1.42.3 <src/1.42.3>`
