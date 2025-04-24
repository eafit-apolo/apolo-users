.. _trinity-index:

Trinity
=======

Trinity [1]_  developed at the Broad Institute and the Hebrew University of Jerusalem, represents a novel method for the efficient and robust *de novo* reconstruction of transcriptomes from RNA-seq data. Trinity combines three independent software modules: Inchworm, Chrysalis, and Butterfly, applied sequentially to process large volumes of RNA-seq reads. Trinity partitions the sequence data into many individual de Bruijn graphs, each representing the transcriptional complexity at a given gene or locus, and then processes each graph independently to extract full-length splicing isoforms and to tease apart transcripts derived from paralogous genes. Briefly, the process works like so:

    Inchworm assembles the RNA-seq data into the unique sequences of transcripts, often generating full-length transcripts for a dominant isoform, but then reports just the unique portions of alternatively spliced transcripts.

    Chrysalis clusters the Inchworm contigs into clusters and constructs complete *De Bruijn* graphs for each cluster. Each cluster represents the full transcriptonal complexity for a given gene (or sets of genes that share sequences in common). Chrysalis then partitions the full read set among these disjoint graphs.

    Butterfly then processes the individual graphs in parallel, tracing the paths that reads and pairs of reads take within the graph, ultimately reporting full-length transcripts for alternatively spliced isoforms, and teasing apart transcripts that corresponds to paralogous genes.


.. toctree::
   :caption: Versions
   :maxdepth: 1

   trinity-2.8.5/index
   trinity-2.4.0/index

.. [1] Trinityrnaseq. (n.d.). trinityrnaseq/trinityrnaseq. Retrieved October 1, 2019, from https://github.com/trinityrnaseq/trinityrnaseq/wiki.
