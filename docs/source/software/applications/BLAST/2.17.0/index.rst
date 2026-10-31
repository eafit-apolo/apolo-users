.. _Blast_2.17.0:

************
Blast 2.17.0
************

- **Installation date:** 2026-03-25
- **Version:** 2.17.0
- **URL:** https://blast.ncbi.nlm.nih.gov/blast/Blast.cgi
- **Installed on:** Apolo III

.. contents:: Table of Contents

Description
-----------

BLAST (Basic Local Alignment Search Tool) is an algorithm and program for comparing primary biological sequence information, such as the amino-acid sequences of proteins or nucleotide sequences of DNA and/or RNA.

Usage
-----

To use Blast 2.17.0, run the following commands:

.. code-block:: bash

   module load blast/2.17.0
   # Check version
   blastn -version

Installation
------------

1. Download the version for your architecture here (https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/):

.. code-block:: bash

   # Untar
   tar -xzf ncbi-blast-2.17.0+-x64-linux.tar.gz -C ~/blast --strip-components=1

2. Add the binaries to the PATH:

.. code-block:: bash

   export PATH=~/blast/bin:$PATH

3. Reload the shell:

.. code-block:: bash

   source ~/.bashrc

4. Verify the installation:

.. code-block:: bash

   blastn -version

References
----------

- https://blast.ncbi.nlm.nih.gov/doc/blast-help/downloadblastdata.html

Author
------

- Installed by: Emanuell Torres López
