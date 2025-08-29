.. _fastQC-0.11.5:

******
0.11.5
******

- **Installation date:** 01/03/2017
- **URL:** http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
- **Apolo version:** Apolo II
- **License:** GNU GENERAL PUBLIC LICENSE, Version 3

.. contents:: Table of Contents

Installation
------------

These are the steps to install **FastQC:**

1. Download the latest version of the software (Binaries - zip) (http://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc):

.. code-block:: bash

    cd /home/$USER/apps/fastqc/src
    wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip
    unzip fastqc_v0.11.5.zip

2. For installation, the following steps must be done:

.. code-block:: bash

    cd FastQC
    sudo mkdir -p /share/apps/fastqc/0.11.5/bin
    sudo mkdir -p /share/apps/fastqc/0.11.5/lib
    sudo cp *.jar /share/apps/fastqc/0.11.5/lib/
    sudo cp -r uk/ org/ net/ fastqc /share/apps/fastqc/0.11.5/bin/

Module
------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module fastqc/0.11.5
    ##
    ## /share/apps/modules/fastqc/0.11.5     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tfastqc/0.11.5 - sets the Environment for FastQC in \
        \n\tthe share directory /share/apps/fastqc/0.11.5\n"
    }

    module-whatis "\n\n\tSets the environment for using FastQC 0.11.5 \
                   \n\tprecompiled\n"

    # for Tcl script use only
    set       topdir     /share/apps/fastqc/0.11.5
    set       version    0.11.5
    set       sys        x86_64-redhat-linux

    conflict fastqc

    module load java/jdk-1.8.0_112

    prepend-path PATH			$topdir/bin

    prepend-path CLASSPATH			$topdir/lib/cisd-jhdf5.jar
    prepend-path CLASSPATH			$topdir/lib/jbzip2-0.9.jar
    prepend-path CLASSPATH			$topdir/lib/sam-1.103.jar


Mode of use
-----------

Load the necessary environment through the **module:**

.. code-block:: bash

    module load fastqc/0.11.5

TO-DO

References
----------

- INSTALL.txt (file inside .zip)

Author
------

- Mateo Gómez Zuluaga
