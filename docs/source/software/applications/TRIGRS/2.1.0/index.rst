.. _installation:

Installation and Compilation of TRIGRS
======================================

This document describes the steps to install and compile TRIGRS 2.1.0.

System Requirements
-------------------

- **Compiler:** GNU Fortran (GCC) 11.2.0
- **Dependencies:**
  - MPI (e.g., MPICH 4.0.1 with GCC 11.2.0)
  - GSL (GNU Scientific Library 2.7 with GCC 8.5.0)

Downloading and Extracting the Source Code
------------------------------------------

To download and extract the TRIGRS source code, run:

.. code-block:: bash

    mkdir TRIGRS
    cd TRIGRS
    wget https://code.usgs.gov/usgs/landslides-trigrs/-/archive/v2.1.0/landslides-trigrs-v2.1.0.tar.gz
    tar -xzvf landslides-trigrs-v2.1.0.tar.gz

Loading Required Modules
------------------------

Before compilation, load the necessary modules:

.. code-block:: bash

    module load mpich/4.0.1_gcc-11.2.0
    module load gsl-2.7-gcc-8.5.0-ylhdycm

Compiling TRIGRS
----------------

Navigate to the source directory:

.. code-block:: bash

    cd landslides-trigrs-v2.1.0/src/TRIGRS

Compile the source code:

.. code-block:: bash

    make

If the compilation is successful, the binaries `tpx`, `trg`, and `prg` will be generated inside `src/TRIGRS/`.

Troubleshooting Compilation Errors
----------------------------------

GSL Library Issues
~~~~~~~~~~~~~~~~~~

If you encounter errors related to the GSL library, manually export the library paths:

.. code-block:: bash

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/gsl/lib
    export LIBRARY_PATH=$LIBRARY_PATH:/path/to/gsl/lib
    export INCLUDE=$INCLUDE:/path/to/gsl/include

Missing TopoIndex Files
~~~~~~~~~~~~~~~~~~~~~~~

Compilation may fail due to missing object (.o) and source (.f90, .f95, etc.) files from TopoIndex. To fix this, copy the TopoIndex directory into TRIGRS:

.. code-block:: bash

    cp -r src/TopoIndex src/TRIGRS/

Missing Files During `make`
~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you encounter errors related to missing files such as `tpindx.o`, `nxtcel.o`, `mpfldr.o`, `rdflodir.o`, and `sindex.o`, ensure that the source files are in `src/TRIGRS/` and compile them manually if needed:

.. code-block:: bash

    mpif90 -c src/TRIGRS/sindex.f
    mpif90 -c src/TRIGRS/nxtcel.f90
    mpif90 -c src/TRIGRS/mpfldr.f

Additional Adjustments for Execution
------------------------------------

Copying TopoIndex Directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since TRIGRS requires object and source files from TopoIndex, copy this directory into TRIGRS:

.. code-block:: bash

    cp -r src/TopoIndex src/TRIGRS/

Duplicating `data` Directory as `Data`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some binaries search for files in `Data/`, but the original directory is named `data/`. To avoid issues, create a duplicate with the correct capitalization:

.. code-block:: bash

    cp -r data Data

Moving `dem.asc` Out of `tutorial/`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The file `dem.asc` is located inside `data/tutorial/`, but `tpx` expects it in `data/`. Move it as follows:

.. code-block:: bash

    mv data/tutorial/dem.asc data/

Running TRIGRS
--------------

Once compiled, TRIGRS can be executed using the following commands:

.. code-block:: bash

    ./src/TRIGRS/tpx tpx_in.txt
    ./src/TRIGRS/trg tr_in.txt
    ./src/TRIGRS/prg tr_in.txt

where `tpx_in.txt` and `tr_in.txt` are input files containing the necessary parameters for execution.

References
----------

TRIGRS User Guide https://code.usgs.gov/usgs/landslides-trigrs/-/blob/master/USER_GUIDE.md?ref_type=heads

Author: Luisa Fernanda Castaño Gómez
