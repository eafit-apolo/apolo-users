.. _trimmomatic-0.36:

****
0.36
****

- **Installation date:** 01/03/2017
- **URL:** http://www.usadellab.org/cms/?page=trimmomatic
- **Apolo version:** Apolo II
- **License:** GNU GENERAL PUBLIC LICENSE, Version 3

.. contents:: Tabe of Contents

Installation
------------

These are the steps to install **Trimmomatic:**

1. Download the latest software version (Binaries - zip) (0.36):

.. code-block:: bash

    cd /home/$USER/apps/trimmomatic/src
    wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.36.zip
    unzip Trimmomatic-0.36.zip

2. For installation, the following steps must be done:

.. code-block:: bash

    cd Trimmomatic-0.36
    sudo mkdir -p /share/apps/trimmomatic/0.36/lib
    sudo cp -r uk/ org/ net/ trimmomatic-0.36.jar /share/apps/fastqc/0.11.5/lib

Module
------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module trimmomatic/0.36
    ##
    ## /share/apps/modules/trimmomatic/0.36     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\ttrimmomatic/0.36 - sets the Environment for Trimmomatic in \
        \n\tthe share directory /share/apps/trimmomatic/0.36\n"
    }

    module-whatis "\n\n\tSets the environment for using Trimmomatic 0.36 \
                   \n\tprecompiled\n"

    # for Tcl script use only
    set       topdir     /share/apps/trimmomatic/0.36
    set       version    0.36
    set       sys        x86_64-redhat-linux

    conflict trimmomatic

    module load java/jdk-1.8.0_112

    prepend-path CLASSPATH			$topdir/lib/trimmomatic-0.36.jar

Mode of use
-----------

Load the necessary environment through the module:

.. code-block:: bash

    module load trimmomatic/0.36

SLURM Template
++++++++++++++

.. code-block:: bash


    #!/bin/sh
    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=1
    #SBATCH --time=10:00
    #SBATCH --job-name=trimmomatic_example
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err
    #SBATCH --mail-type=END,FAIL
    #SBATCH --mail-user=mgomezz@eafit.edu.co

    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load trimmomatic/0.36

    java -jar /share/apps/trimmomatic/0.36/lib/trimmomatic-0.36.jar PE -phred33 input_forward.fq.gz input_reverse.fq.gz output_forward_paired.fq.gz output_forward_unpaired.fq.gz
    output_reverse_paired.fq.gz output_reverse_unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

TO-DO

References
----------

- http://www.usadellab.org/cms/?page=trimmomatic

Author
------

- Mateo Gómez Zuluaga
