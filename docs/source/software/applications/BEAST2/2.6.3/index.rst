.. _beast-2.6.3-index:


BEAST 2.6.3
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.beast2.org/
- **License:**  GNU LESSER GENERAL PUBLIC LICENSE Version 2.1
- **Installed on:** Apolo II
- **Installation date:** 23/02/2021

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)

- **Dependencies:**
    - Java JDK - 1.8.0 u112

Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/blopezp/Desktop/BEAST
        wget https://github.com/CompEvol/beast2/releases/download/v2.6.3/BEAST.v2.6.3.Linux.tgz
        tar -zxvf BEAST.v2.6.3.Linux.tgz
        2. After unpacking blast, continue with the following steps to finish the installation:


#. After unpacking blast, continue with the following steps to finish the installation:

    .. code-block:: bash

        cd beast
        sudo mkdir -p /share/apps/beast2/2.6.3
        sudo cp -r bin/ lib/ templates / examples/ images/ /sahre/apps/beast2/2.6.3
        ls -p /share/apps/beast2/2.6.3



Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module beast2/2.6.3
        ##
        ## /share/apps/modules/beast2/2.6.3 Written by Bryan López Parra
        ##

        proc ModulesHelp { } {
            puts stderr "\tbeast2/2.6.3 - sets the Environment for BEAST2 \
            \n\tin the share directory /share/apps/beast2/2.6.3\n"
        }

        module-whatis "\n\n\tSets the environment for using beast2\n"

        # for Tcl script use only
        set     topdir          /share/apps/beast2/2.6.3
        set     version         2.6.3
        set     sys             linux-x86_64

        conflict beast2

        module load java/jdk-1.8.0_112

        prepend-path PATH               $topdir/bin

        prepend-path CLASSPATH          $topdir/lib/beast.jar
        prepend-path CLASSPATH          $topdir/lib/beast.src.jar
        prepend-path CLASSPATH          $topdir/lib/DensiTree.jar
        prepend-path CLASSPATH          $topdir/lib/launcher.jar


Use
---

    .. code-block:: bash

        module load beast2/2.6.3

Slurm template
--------------

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --job-name=BEAST2-2.6.0-case
        #SBATCH --partition=batch
        #SBATCH --nodes=1
        #SBATCH --ntasks=8
        #SBATCH --time=1:00:00

        module load beast2/2.6.3

        beast -threads $SLURM_NTASKS testStarBeast.xml






Resources
---------
* http://www.beast2.org/


:Author:

* Bryan López Parra <blopezp@eafit.edu.co>
