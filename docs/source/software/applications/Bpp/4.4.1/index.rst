.. _bpp-4.4.1-index:


BP&P 4.4.1
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/bpp/bpp/
- **License:** GNU GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II
- **Installation date:** 15/03/2022

Tested on (Requirements)
------------------------

* **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}`
* **Dependencies:**
    * Intel oneAPI 2022 update 1 (Intel C Compiler)



Installation
------------


#. Download the desired version of the software.

    .. code-block:: bash

        cd /home/blopezp/Modulos
        git clone https://github.com/bpp/bpp.git




#. Manual compilation procedure.

    .. code-block:: bash

        cd bpp-4.4.1/src/
        module load intel/2022_oneAPI-update1
        make


#. After compiling BP&P, continue with the following steps:

    .. code-block:: bash

        sudo mkdir /share/apps/bpp/4.4.1/Intel_oneAPI-2022_update-1/bin -p
        sudo cp src/bpp /share/apps/bpp/4.4.1/Intel_oneAPI-2022_update-1/bin





Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module bpp/4.4.1_Intel_oneAPI-2022_update-1
        ##
        ## /share/apps/bpp/4.4.1/Intel_oneAPI-2022_update-1     Written by Bryan Lopez Parra
        ##

        proc ModulesHelp { } {
            puts stderr "\tbpp/4.4.1_intel-2022_update-1 sets the Environment for Bpp in \
            \n\tthe share directory /share/apps/bpp/4.4.1/Intel_oneAPI-2022_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using Bpp 4.4.1 \
                    \n\tbuilded with Intel oneAPI 2022 update 1\n"

        # for Tcl script use only
        set       topdir     /share/apps/bpp/4.4.1/Intel_oneAPI-2022_update-1
        set       version    4.4.1
        set       sys        x86_64-redhat-linux

        module load intel/2022_oneAPI-update1

        prepend-path PATH    $topdir/bin





Slurm template
--------------

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --ntasks=1
        #SBATCH --time=14-00:00:00
        #SBATCH --job-name=A10_All_L-D
        #SBATCH -o result_%x_%j.out      # File to which STDOUT will be written
        #SBATCH -e result_%x_%j.err      # File to which STDERR will be written
        #SBATCH --mail-type=ALL
        #SBATCH --mail-user=blopezp@eafit.edu.co

        module load bpp/4.4.1_Intel_oneAPI-2022_update-1

        bpp --cfile A10_All_L-D.ctl



Resources
---------
- https://github.com/bpp/bpp/


:Authors:

- Bryan López Parra <blopezp@eafit.edu.co>
