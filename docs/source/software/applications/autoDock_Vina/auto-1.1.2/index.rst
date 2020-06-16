.. _vina:

**************
AutoDock Vina
**************


.. contents:: Table of Contents

Basic information
--------------------

- **Installation date:** 19/09/2016
- **URL:** http://vina.scripps.edu/index.html
- **Apolo version:** Apolo I
- **License:** Apache License Version 2.0

Installation
--------------

#. First download the tar from the main page

.. code-block:: bash

    $ wget https://ccpforge.cse.rl.ac.uk/gf/download/frsrelease/255/4726/dl_class_1.9.tar.gz
    $ tar -zxvf dl_class_1.9.tar.gz

#. configure the makefile

.. code-block:: bash

    cd dl_class_1.9
    cp build/MakePAR source/Makefile
    cd source
    module load openmpi/1.6.5_gcc-4.8.4
    make gfortran


Module
---------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## modules dl_class/1.9_openmpi-1.6.5_gcc-4.8.4
    ##
    ## /share/apps/modules/dl_class/1.9_openmpi-1.6.5_gcc-4.8.4
    ## Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tdl_classic/1.9_openmpi-1.6.5_gcc-4.8.4 - sets the
        \n\tEnvironment for DL_POLY Classic in the share directory
        \n\t/share/apps/dl_class/1.9/openmpi-1.6.5/gcc-4.8.4\n"
    }

    module-whatis "\n\n\tSets the environment for using DL_POLY Classic 1.9 \
                   \n\tbuilded with openMPI 1.6.5 and GCC 4.8.4 version\n"

    # for Tcl script use only
    set       topdir     /share/apps/dl_class/1.9/openmpi-1.6.5/gcc-4.8.4
    set       version    1.9
    set       sys        x86_64-redhat-linux

    module load openmpi/1.6.5_gcc-4.8.4

    prepend-path    PATH $topdir/bin


Usage mode
------------

.. code-block:: bash

    module load dl_class/1.9_openmpi-1.6.5_gcc-4.8.4


References
------------

- Mail from the people of the University of Cartagena
- Manual within the software package

Author
------

- Mateo Gómez Zuluaga
