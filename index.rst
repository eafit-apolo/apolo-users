.. _installation:

Installation and Compilation of MUSCLE
======================================

This document describes the steps to install and compile MUSCLE (Multiple Sequence Comparison by Log-Expectation).

System Requirements
-------------------

- **Compiler:** GNU GCC or G++ (e.g., GCC 8.5.0 or later)
- **Optional:** OpenMP support for multithreading

Downloading and Extracting the Source Code
------------------------------------------

To download and extract the MUSCLE source code, run:

.. code-block:: bash
    mkdir muscle
    cd muscle
    wget https://github.com/rcedgar/muscle/archive/refs/tags/v5.3.tar.gz
    tar -xzvf v5.3.tar.gz

Loading Required Modules
----------------------------------------

If you are working on a cluster or system using environment modules, load any required modules (e.g., GCC):

.. code-block:: bash
    module load gcc/8.5.0

Compiling MUSCLE
----------------

Navigate to the source directory:

.. code-block:: bash
    cd muscle-5.3

Compile the source code (this example uses the provided Makefile):

.. code-block:: bash
    make

If the compilation is successful, the binary `muscle` will be generated in the build directory (e.g., `muscle-5.3/`).

Troubleshooting Compilation Errors
----------------------------------

Missing GCC or G++
~~~~~~~~~~~~~~~~~~

If you encounter errors indicating that `gcc` or `g++` is missing, install it using your package manager:

.. code-block:: bash
    sudo apt-get install build-essential
    # or
    sudo yum groupinstall "Development Tools"

OpenMP Not Supported
~~~~~~~~~~~~~~~~~~~~

If you see warnings or errors about OpenMP, you can try compiling without OpenMP flags or ensure your compiler supports it.

.. code-block:: bash
    g++ -O3 -ffast-math -march=native -o muscle src/*.cpp
    # or use the Makefile with OpenMP disabled

Running MUSCLE
--------------

Once compiled, MUSCLE can be executed using the following command:

.. code-block:: bash
    ./muscle -align input.fasta -output aligned.fasta

where `input.fasta` is your input file containing unaligned sequences in FASTA format, and `aligned.fasta` is the output file for the aligned sequences.

Example: Running a Trial Alignment
----------------------------------

Create a sample FASTA file:

.. code-block:: bash
    cat > sample.fasta <<EOF
    >seq1
    ACGTACGTGACG
    >seq2
    ACGTGACGTGAC
    >seq3
    ACGTTGCAACGA
    EOF

Run MUSCLE on the sample data:

.. code-block:: bash
    ./muscle -align sample.fasta -output aligned.fasta

View the aligned output:

.. code-block:: bash
    cat aligned.fasta

Additional Adjustments for Execution
------------------------------------

Adding MUSCLE to PATH
~~~~~~~~~~~~~~~~~~~~~

To run MUSCLE from any directory, add its location to your PATH:

.. code-block:: bash
    export PATH="$(pwd):$PATH"

You may add this line to your `~/.bashrc` or `~/.bash_profile` for convenience.

References
----------

- MUSCLE documentation: https://drive5.com/muscle
- MUSCLE GitHub repository: https://github.com/rcedgar/muscle
