.. _beast-2.4.5-index:


BEAST 2.4.5
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.beast2.org/
- **License:**  GNU LESSER GENERAL PUBLIC LICENSE Version 2.1
- **Installed on:** Apolo II and Cronos
- **Installation date:** 07/02/2017

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)

- **Dependencies:**
    - Java JDK - 1.8.0 u112

Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/bpp/intel
        wget https://github.com/CompEvol/beast2/releases/download/v2.4.5/BEAST.v2.4.5.Linux.tgz
        tar -zxvf BEAST.v2.4.5.Linux.tgz


#. After unpacking blast, continue with the following steps to finish the installation:

    .. code-block:: bash

        cd beast
        sudo mkdir -p /share/apps/beast2/2.4.5
        sudo cp -r bin/ lib/ templates/ examples/ images/ /share/apps/beast2/2.4.5


Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module beast2/2.4.5
        ##
        ## /share/apps/modules/beast2/2.4.5 Written by Juan David Pineda-Cárdenas
        ##

        proc ModulesHelp { } {
            puts stderr "\tbeast2/2.4.5 - sets the Environment for BEAST2 \
            \n\tin the share directory /share/apps/beast2/2.4.5\n"
        }

        module-whatis "\n\n\tSets the environment for using beast2\n"

        # for Tcl script use only
        set   	topdir		/share/apps/beast2/2.4.5
        set	version         2.4.5
        set     sys             linux-x86_64

        conflict beast2

        module load java/jdk-1.8.0_112

        prepend-path PATH		$topdir/bin

        prepend-path CLASSPATH 		$topdir/lib/beast.jar
        prepend-path CLASSPATH 		$topdir/lib/beast.src.jar
        prepend-path CLASSPATH 		$topdir/lib/DensiTree.jar
        prepend-path CLASSPATH 		$topdir/lib/launcher.jar


Use
---

    .. code-block:: bash

        module load beast2/2.4.5





Resources
---------
 * http://www.beast2.org/


Author
------
    * Mateo Gómez Zuluaga
