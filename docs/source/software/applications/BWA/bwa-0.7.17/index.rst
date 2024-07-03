.. _bwa-0.7.17:

BWA 0.7.17
===========

.. contents:: Table of contents

Basic information
--------------------

- **Installation date:** 17/06/2024
- **URL:** https://github.com/lh3/bwa
- **Apolo version:** Apolo II
- **License:** GPL

Dependencies
------------

- gcc-11.2.0
- samtools
- htslib

Installation
------------

After solving the previously mentioned dependencies, you can proceed with the installation of **BWA.**

1. Download the latest version of the software repository :

.. code-block:: bash
  git clone https://github.com/lh3/bwa.git


2. Compilation (Makefile), do the following steps:

.. code-block:: bash

     cd bwa;
     make

Usage mode
-----------

Load the necessary environment through the **module:**

.. code-block:: bash

    module load bwa/0.7.17_gcc-11.2.0



References
----------
- Li H. and Durbin R. (2009) Fast and accurate short read alignment with Burrows-Wheeler transform. Bioinformatics, 25, 1754-1760. [PMID: 19451168].

- Li H. and Durbin R. (2010) Fast and accurate long-read alignment with Burrows-Wheeler transform. Bioinformatics, 26, 589-595. [PMID: 20080505]. -

- Li H. (2013) Aligning sequence reads, clone sequences and assembly contigs with BWA-MEM. arXiv:1303.3997v2 [q-bio.GN].
- Makefile (inside bz2)

Authors
------

- Isis Amaya <icamayaa@eafit.edu.co>
- Santiago Arias <sariash@eafit.edu.co>
