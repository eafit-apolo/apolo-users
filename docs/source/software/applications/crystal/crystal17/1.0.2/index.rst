.. _crystal17-1.2.0:

***************
Crystal17 1.0.2
***************

- **Installation date:** 07/03/2022
- **URL:** http://www.crystalsolutions.eu/crystal.html
- **Apolo version:** Apolo II
- **License:** Academic license

.. contents:: Table of Contents

Dependencies
------------

- Intel oneAPI 2022 Update 1

Installation
------------

#. First download the tar from the main page http://www.crystalsolutions.eu/try-it.html

    .. code-block:: bash

        module load intel/2022_oneAPI-update1
        mkdir CRYSTAL17
        cd CRYSTAL17
        tar -zxvf crystal17_v1_0_2_demo.tar.gz

#. It will generate some tarball files, uncompress the Linux one

    .. code-block:: bash

        tar -zxvf crystal17_v1_0_2_Linux-ifort17_emt64_demo.tar.gz

#. Copy the bin directorie to the Root directorie of crystal

    .. code-block:: bash

        sudo mkdir /share/apps/crystal17/1_0_2/Intel_oneAPI-2022_update-1
        sudo cp -r bin /share/apps/crystal17/1_0_2/Intel_oneAPI-2022_update-1

Module
------

.. code-block:: tcl

    #%Module1.0#####################################################################
    ##
    ## modules 1.0.4_intel_impi-2017_update-1
    ##
    ## /share/apps/crystal17/1_0_2/Intel_oneAPI-2022_update-1  Written by Santiago Alzate Cardona
    ##

    proc ModulesHelp { } {
        puts stderr "\tcrystal17/v$version - sets the Environment for crystal17 in \
        \n\tthe share directory /share/apps/crystal17/1_0_2/Intel_oneAPI-2022_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using crystal17 v1.0.2 builded with \
              \n\tIntel_oneAPI-2022_update-1 (ifort and mpiifort)\n"

    # for Tcl script use only
    set     topdir           /share/apps/crystal17/1_0_2/Intel_oneAPI-2022_update-1
    set     version          1.0.4
    set     sys          x86_64-redhat-linux

    # Module use
    set         user         [exec bash -c "echo \$USER"]
    set         CRY17_ROOT   $topdir
    set         CRY17_BIN    bin
    set         CRY17_ARCH   Linux-ifort14_XE_emt64/std
    set         VERSION      v1.0.2
    set         CRY17_EXEDIR $CRY17_ROOT/$CRY17_BIN/$CRY17_ARCH


    conflict crystal

    module load intel

    setenv      CRY17_ROOT   $topdir
    setenv      CRY17_BIN    bin
    setenv      CRY17_ARCH   Linux-ifort14_XE_emt64/std
    setenv      VERSION      v1.0.2
    setenv      CRY17_EXEDIR $CRY17_ROOT/$CRY17_BIN/$CRY17_ARCH

    prepend-path PATH    $CRY17_EXEDIR

Usage mode
----------

.. code-block:: bash

    cd example_crystal
    module load module load crystal17/1_2_0_Intel_oneAPI-2022_update-1
    crystal

References
----------

- https://www.crystal.unito.it/documentation.php
- https://www.crystal.unito.it/Manuals/crystal17_P.pdf

Author
------

- Santiago Alzate Cardona
