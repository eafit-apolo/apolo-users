.. _trimmomatic:


***********
trimmomatic
***********

Description
-----------

Trimmomatic is a fast, multithreaded command line tool that can be used to trim and crop Illumina (FASTQ)
data as well as to remove adapters. These adapters can pose a real problem depending on the library preparation and
downstream application. There are two major modes of the program: Paired end mode and Single end mode.
The paired end mode will maintain correspondence of read pairs and also use the additional information
contained in paired reads to better find adapter or PCR primer fragments introduced by the library preparation process.
Trimmomatic works with FASTQ files (using phred + 33 or phred + 64 quality scores, depending on the Illumina pipeline used).
Files compressed using either „gzip‟ or „bzip2‟ are supported, and are identified by use of „.gz‟ or „.bz2‟ file extensions.

.. toctree::
    :caption: Versions
    :maxdepth: 1

    trimmomatic-0.36/index
