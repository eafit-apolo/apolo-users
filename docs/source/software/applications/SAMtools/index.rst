.. _samtools-index:

SAMTOOLS
=====

[1] Samtools is a suite of programs for interacting with high-throughput sequencing data. It consists of three separate repositories:

- Samtools: Reading/writing/editing/indexing/viewing SAM/BAM/CRAM format
- BCFtools: Reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants
- HTSlib: A C library for reading/writing high-throughput sequencing data

Samtools and BCFtools both use HTSlib internally, but these source packages contain their own copies of htslib so they can be built independently.
.. toctree::
   :caption: Versions
   :maxdepth: 1

   samtools-1.20.0/index

.. [1] SamTools. (s. f.). https://www.htslib.org/
       Retrieved 8:13, June 17, 2023
