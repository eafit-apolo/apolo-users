.. _Jasper-3.0.3:

Jasper 3.0.3
============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 15/03/2022
- **Official Website:** https://www.ece.uvic.ca/~frodo/jasper/
- **Supercomputer:** Apolo II
- **License:** JasPer License Version 3.0

Prerequisites
-------------

- GCC >= 9.3.0
- cmake >= 3.20.2

Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module load gcc/9.3.0

2. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget https://github.com/jasper-software/jasper/archive/refs/tags/version-3.0.3.tar.gz

3. After decompressing JASPER, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd jasper-version-3.0.3
        $ mkdir build2
        $cd build2

        $ make .. -DCMAKE_INSTALL_PREFIX=/share/apps/jasper/3.0.3/gcc-9.3.0

        $ make -j 10 2>&1 | tee jasper-make.log
        $ make check 2>&1 | tee jasper-make-check.log
        $ sudo mkdir -p /share/apps/jasper/3.0.3
        $ sudo make install 2>&1 | tee jasper-make-install.log


Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load jasper/3.0.3_gcc-9.3.0
        ##
        ## /share/apps/jasper/3.0.3/gcc-9.3.0
        ## Written by Bryan Lopez Parra
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using jasper 1in the shared directory /share/apps/jasper/3.0.3/gcc-9.3.0/\
                          \nbuilded with gcc 9.3.0\
                          \n2019\n"
        }

        module-whatis "(Name________) jasper"
        module-whatis "(Version_____) 3.0.3"
        module-whatis "(Compilers___) gcc-9.3.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/jasper/3.0.3
        set         version       3.0.3
        set         sys           x86_64-redhat-linux

        module load gcc/9.3.0

        setenv          JASPERLIB               $topdir/lib
        setenv          JASPERINC               $topdir/include

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLLUDE_PATH       $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include



Mode of use
-----------

    .. code-block:: bash

        $ module load jasper/3.0.3_gcc-9.3.0

References
----------

.. [1] https://www.ece.uvic.ca/~frodo/jasper/#download


:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
