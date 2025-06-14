.. _BWA:

***
BWA
***

Description
-----------

BWA [1] is a software package for mapping low-divergent sequences against a large reference genome, 
such as the human genome. It consists of three algorithms: BWA-backtrack, BWA-SW and BWA-MEM. 
The first algorithm is designed for Illumina sequence reads up to 100bp, while the rest two for longer 
sequences ranged from 70bp to 1Mbp. BWA-MEM and BWA-SW share similar features such as long-read support 
and split alignment, but BWA-MEM, which is the latest, is generally recommended for high-quality queries as 
it is faster and more accurate. BWA-MEM also has better performance than BWA-backtrack for 70-100bp Illumina reads.s. 


.. toctree::
   :caption: Versions

   
   :maxdepth: 1

   bwa-0.7.17/index

.. [1] Lh. (s. f.). GitHub - lh3/bwa: Burrow-Wheeler Aligner for short-read alignment . GitHub. https://github.com/lh3/bwa
       Retrieved 8:13, June 17, 2024