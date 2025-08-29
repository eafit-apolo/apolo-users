.. _blast-2.6.0-index:


BLAST 2.6.0
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://blast.ncbi.nlm.nih.gov/Blast.cgi
- **License:**  GNU LESSER GENERAL PUBLIC LICENSE Version 2.1
- **Installed on:** Apolo II and Cronos
- **Installation date:** 21/02/2017

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)

- **Dependencies:**
    - python >= 2.7.11
    - libm (by default)

Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/vsearch/gcc
        wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.6.0/ncbi-blast-2.6.0+-x64-linux.tar.gz
        tar -zxvf ncbi-blast-2.6.0+-x64-linux.tar.gz


#. After unpacking blast, continue with the following steps to finish the installation:

    .. code-block:: bash

        cd ncbi-blast-2.6.0+
        rm ChangeLog LICENSE ncbi_package_info README
        sudo mkdir -p /share/apps/ncbi-blast/2.6.0
        sudo mv bin /share/apps/ncbi-blast/2.6.0/



Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## modules ncbi-blast+/2.6.0
        ##
        ## /share/apps/modules/ncbi-blast+/2.6.0_x86_64  Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\n\tThe NCBI Basic Local Alignment Search Tool (BLAST) finds \
                    \n\tregions of local similarity between sequences in the \
                \n\tshare directory /share/apps/ncbi-blast+/2.6.0\n"
        }

        module-whatis "\n\tSets the Environment for NCBI-BLAST 2.6.0\n"

        # for Tcl script use only
        set     topdir     /share/apps/ncbi-blast+/2.6.0
        set	version    2.6.0
        set	sys        x86_64-redhat-linux

        conflict ncbi-blast+
        module load intel/2017_update-1
        module load mkl/2017_update-1
        module load python/2.7.12_intel-2017_update-1

        prepend-path PATH $topdir/bin


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
 * https://blast.ncbi.nlm.nih.gov/Blast.cgi


Author
------
    * Mateo Gómez Zuluaga
