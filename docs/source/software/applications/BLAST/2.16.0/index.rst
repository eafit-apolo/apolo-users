.. _blast-2.16.0-index:


BLAST 2.16.0
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://blast.ncbi.nlm.nih.gov/doc/blast-help/downloadblastdata.html
- **License:**  GNU LESSER GENERAL PUBLIC LICENSE Version 2.1
- **Installed on:** Apolo II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux (8.10)

- **Dependencies:**
    - python >= 2.12.4
    - perl (dependencie at run time for update_blastdb.pl)
    - libm (by default)

Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.16.0/ncbi-blast-2.16.0+-x64-linux.tar.gz
        tar -zxvf ncbi-blast-2.16.0+-x64-linux.tar.gz


#. After unpacking blast, continue with the following steps to finish the installation:

    .. code-block:: bash

        cd ncbi-blast-2.16.0+
        rm ChangeLog LICENSE ncbi_package_info README
        sudo mkdir -p /share/apps/ncbi-blast/2.16.0
        sudo mv bin /share/apps/ncbi-blast/2.16.0/



Module
------

    .. code-block:: bash

        #%Module

        ##  blast2.16.0_gcc-11.2.0
        ##  "URL: https://blast.ncbi.nlm.nih.gov/doc/blast-help/downloadblastdata.html"
        ##  "SOURCE_CODE: https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/"
        ##  "Category: Aplication"

        module-whatis "The Basic Local Alignment Search Tool (BLAST) finds regions of local similarity between sequences."

        proc ModulesHelp { } {
            puts stderr "Purpose"
            puts stderr "-------"
            puts stderr "BLAST+ command line tools for sequence alignment, database manipulation, and conserved domain analysis"
            puts stderr "\nAvailable programs and their functions:"

            # Nucleotide/Protein BLAST Core Tools
            puts stderr "\nCore Search Tools:"
            puts stderr "  blastn      - Searches nucleotide queries against nucleotide databases"
            puts stderr "  blastp      - Searches protein queries against protein databases"
            puts stderr "  blastx      - Translates nucleotide query in 6 frames vs protein database"
            puts stderr "  tblastn     - Searches protein query vs translated nucleotide database"
            puts stderr "  tblastx     - Translated nucleotide query vs translated nucleotide database"

            # Specialized Algorithms
            puts stderr "\nSpecialized Search Tools:"
            puts stderr "  deltablast  - Sensitive protein search using conserved domains (requires delta CDD)"
            puts stderr "  psiblast    - Iterative protein search for building PSSM profiles"
            puts stderr "  rpsblast    - Protein vs conserved domain database (CDD)"
            puts stderr "  rpstblastn  - Translated nucleotide query vs CDD database"

            # Database Utilities
            puts stderr "\nDatabase Management:"
            puts stderr "  makeblastdb - Creates BLAST databases from FASTA files"
            puts stderr "  blastdbcmd  - Retrieves sequences/info from BLAST databases"
            puts stderr "  blastdbcheck - Verifies integrity of BLAST databases"
            puts stderr "  update_blastdb.pl - Downloads preformatted databases from NCBI/AWS/GCP"

            # Masking Tools
            puts stderr "\nSequence Masking:"
            puts stderr "  dustmasker  - Masks low-complexity regions in nucleotide sequences"
            puts stderr "  segmasker   - Masks low-complexity regions in protein sequences"
            puts stderr "  windownasker - Masks repeats in nucleotide sequences"

            # Advanced Utilities
            puts stderr "\nAdditional Utilities:"
            puts stderr "  blast_formatter - Formats BLAST results from RID or archive files"
            puts stderr "  get_species_taxids.sh - Generates taxid lists for database filtering"
            puts stderr "  makeprofiledb  - Creates CDD databases from PSSM matrices"
            puts stderr "  legacy_blast.pl - Converts legacy BLAST commands to BLAST+ syntax"

            # Detailed Information
            puts stderr "\nTechnical information:"
            puts stderr "Compiler: gcc/11.2.0"
            puts stderr "Dependencies at run time:\n"
            puts stderr "  perl  - For update_blastdb.pl"
        }



        conflict blast

        #set fn $ModulesCurrentModulefile
        #set fn [file normalize $ModulesCurrentModulefile]

        #if {[file type $fn] eq "link"} {
        #    set fn [exec readlink -f $fn]
        #}

        if {![is-loaded perl]} {
            module load perl
        }

        set     compiler   gcc-11.2.0
        set     version    2.16.0
        set     sys        x86_64-redhat-linux
        set     topdir     /share/apps/blast/${version}/${compiler}

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/inc
        prepend-path    CXX_INCLUDE_PATH        $topdir/inc


Slurm template
------------------

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --ntasks-per-node=32
        #SBATCH --time=1:00:00
        #SBATCH --job-name=vsearch
        #SBATCH -o result_%N_%j.out
        #SBATCH -e result_%N_%j.err

        export SBATCH_EXPORT=NONE
        export OMP_NUM_THREADS=???

        module load ncbi-blast/2.6.0_x86_64

        xxx

Resources
---------
 * https://blast.ncbi.nlm.nih.gov/doc/blast-help/downloadblastdata.html


Author
------
    * Julian Valencia Bolaños
