.. _vsearch-2.4.0-index:


VSEARCH 2.4.0
=============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/torognes/vsearch
- **License:** GNU GLP3
- **Installed on:** Apolo II and Cronos
- **Installation date:** 20/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * g++ >= 4.9.4



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/vsearch/gcc
        wget https://github.com/torognes/vsearch/archive/v2.4.0.tar.gz
        tar -zxvf v2.4.0.tar.gz


#. Do the following steps fpr the compilation:

    .. code-block:: bash

        module load gcc/4.9.4
        cd vsearch-2.4.0
        ./autogen.sh
        ./configure --prefix=/share/apps/vsearch/2.4.0/gcc/4.9.4 --build=x86_64-redhat-linux
        make


#. After compiling vshare, continue with the following steps:

    .. code-block:: bash

        sudo mkdir -p /share/apps/vsearch/2.4.0/gcc/4.9.4
        sudo chown -R mgomezzul.apolo /share/apps/vsearch/2.4.0/gcc/4.9.4
        make install
        sudo chown -R root.root /share/apps/vsearch/2.4.0/gcc/4.9.4




Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module vsearch/2.4.0_gcc-4.9.4
        ##
        ## /share/apps/modules/vsearch/2.4.0_gcc-4.9.4     Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tvsearch/2.4.0_gcc-4.9.4 - sets the Environment for VSEARCH 2.4.0 in \
            \n\tthe share directory /share/apps/vsearch/2.4.0/gcc/4.9.4\n"
        }

        module-whatis "\n\n\tSets the environment for using VSEARCH 2.4.0 \
                    \n\tbuilded with GNU GCC 4.9.4\n"

        # for Tcl script use only
        set       topdir     /share/apps/vsearch/2.4.0/gcc/4.9.4
        set       version    2.4.0
        set       sys        x86_64-redhat-linux

        module load gcc/4.9.4

        prepend-path PATH    $topdir/bin
        prepend-path MANPATH $topdir/share/man



Use
---

Slurm template
~~~~~~~~~~~~~~

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

        module load vsearch/2.4.0

        vsearch --usearch_global queries.fsa --db database.fsa --id 0.9 --alnout alnout.txt



Resources
---------
 * https://github.com/torognes/vsearch


Author
------
    * Mateo Gómez Zuluaga
