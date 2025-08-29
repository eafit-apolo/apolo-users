.. _prinseq-lite:


Prinseq-lite
============

**PR** eprocessing and **IN** formation of **SEQ** uence data. **PRINSEQ** will help you to preprocess your genomic
or metagenomic sequence data in FASTA or FASTQ format.

The lite version is a standalone perl script (prinseq-lite.pl) that does not require any non-core
perl modules for processing.

The used modules are:

.. code-block:: bash

    Getopt::Long Pod::Usage
    File::Temp qw(tempfile)
    Fcntl qw(:flock SEEK_END)
    Digest::MD5 qw(md5_hex)
    Cwd List::Util qw(sum min max)

Also PRINSEQ is available in web and graphics version.

For additional information you can open those links:

- **Main page:** http://prinseq.sourceforge.net/
- **More information** https://sourceforge.net/projects/prinseq/files/?source=navbar
- **Download** https://sourceforge.net/projects/prinseq/files/standalone/prinseq-lite-0.20.4.tar.gz/download

.. toctree::
   :caption: Versions
   :maxdepth: 1

   prinseq-lite-0.20.4/index
