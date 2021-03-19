.. _iqtree-2.1.2-index:


IQ-TREE 2.1.2
=============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/iqtree/iqtree2/
- **License:** GNU GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II
- **Installation date:** 07/02/2021

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GCC > 7.4.0



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        mkdir apps/iqutree -p
        cd apps/iqutree/
        wget https://github.com/iqtree/iqtree2/releases/download/v2.1.2/iqtree-2.1.2-Linux.tar.gz
        tar xfz iqtree-2.1.2-Linux.tar.gz



#. Enter to the extracted folder.

    .. code-block:: bash

        cd icu-release-68-1/iqtree-2.1.2-Linux
        module load gcc/7.4.0


#. Continue with the following steps:

    .. code-block:: bash

        sudo mkdir -p /share/apps/iqutree/2.1.2/
        sudo cp * /share/apps/iqutree/2.1.2/ -r





Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module iqutree/2.1.2
        ##
        ## /share/apps/modules/iqutree/2.1.2 Written by Tomas Navarro Munera
        ##

        proc ModulesHelp { } {
            puts stderr "\tiqutree/2.1.2 - sets the Environment for BEAST2 \
            \n\tin the share directory /share/apps/iqutree/2.1.2\n"
        }

        module-whatis "\n\n\tSets the environment for using beast2\n"

        # for Tcl script use only
        set     topdir          /share/apps/iqutree/2.1.2
        set     version         2.1.2
        set     sys             linux-x86_64

        conflict iqutree

        module load gcc/7.4.0

        prepend-path PATH               $topdir/bin





Usage mode
------------

    .. code-block:: bash

       module load iqutree/2.1.2



Resources
---------
 * https://github.com/iqtree/iqtree2/


:Authors:

- Tomas Navarro <tdnavarrom@eafit.edu.co>
