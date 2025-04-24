
*******
vsearch
*******

The aim of this project is to create an alternative to the USEARCH tool developed by Robert C. Edgar (2010). The new tool should:

    * have open source code with an appropriate open source license
    * be free of charge
    * have a 64-bit design that handles very large databases and much more than 4GB of memory
    * be as accurate or more accurate than usearch
    * be as fast or faster than usearch

We have implemented a tool called VSEARCH which supports de novo and reference based chimera detection, clustering, full-length and prefix dereplication, rereplication, reverse complementation, masking, all-vs-all pairwise global alignment, exact and global alignment searching, shuffling, subsampling and sorting. It also supports FASTQ file analysis, filtering, conversion and merging of paired-end reads.

VSEARCH stands for vectorized search, as the tool takes advantage of parallelism in the form of SIMD vectorization as well as multiple threads to perform accurate alignments at high speed. VSEARCH uses an optimal global aligner (full dynamic programming Needleman-Wunsch), in contrast to USEARCH which by default uses a heuristic seed and extend aligner. This usually results in more accurate alignments and overall improved sensitivity (recall) with VSEARCH, especially for alignments with gaps.

VSEARCH binaries are provided for x86-64 systems running GNU/Linux, macOS (version 10.7 or higher) and Windows (64-bit, version 7 or higher), as well as ppc64le systems running GNU/Linux.

VSEARCH can directly read input query and database files that are compressed using gzip and bzip2 (.gz and .bz2) if the zlib and bzip2 libraries are available.

Most of the nucleotide based commands and options in USEARCH version 7 are supported, as well as some in version 8. The same option names as in USEARCH version 7 has been used in order to make VSEARCH an almost drop-in replacement. VSEARCH does not support amino acid sequences or local alignments. These features may be added in the future.

.. toctree::
   :caption: Versions
   :maxdepth: 1

   2.4.0/index
