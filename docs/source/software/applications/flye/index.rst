.. _flye:

Flye
====

Flye [1]_ is a de novo assembler for single-molecule sequencing reads, such as those produced by PacBio and Oxford Nanopore Technologies. It is designed for a wide range of datasets, from small bacterial projects to large mammalian-scale assemblies. The package represents a complete pipeline: it takes raw PacBio / ONT reads as input and outputs polished contigs. Flye also has a special mode for metagenome assembly.

Currently, Flye will produce collapsed assemblies of diploid genomes, represented by a single mosaic haplotype. To recover two phased haplotypes consider applying HapDup after the assembly.

.. toctree::
   :caption: Versions
   :maxdepth: 1

   flye2.9.6-b1802/index

.. [1] https://github.com/mikolmogorov/Flye
