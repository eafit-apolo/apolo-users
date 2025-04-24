.. _mothur-index:

.. role:: bash(code)
   :language: bash

MOTHUR
============

.. contents:: Table of Contents

Basic information
-----------------
- **Installation Date:** 05/09/2016
- **License:** GNU LESSER GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II

Tested on (Requirements)
------------------------

* **Dependencies to run PLUMED:**
    * zlib y zlib-devel
    * bzip2 y bzip2-devel
    * boost >= 1.58.0

Installation
------------

After solving the previously mentioned dependencies, you can proceed with the installation.

#. Download the latest version of the software (Source code - tgz) (https://github.com/mothur/mothur/releases):

    .. code-block:: bash

        cd ~/apps/mothur/src/
        wget https://github.com/mothur/mothur/archive/v1.38.1.1.tar.gz
        tar -zxvf v1.38.1.1.tar.gz

#. Makefile configuration, make the following changes:

    .. code-block:: bash

        cd mothur-1.38.1.1
        emacs Makefile
        BOOST_LIBRARY_DIR="\"/share/apps/boost-c++-lib/1.59.0/intel-15/lib\""
        BOOST_INCLUDE_DIR="\"share/apps/boost-c++-lib/1.59.0/intel-15/include\""
        MOTHUR_FILES="\"/home/mgomezzul/apps/mothur/src/mothur-1.38.1.1\""

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load plumed/2.3.5
        ##
        ## /share/apps/modules/plumed/2.3.5
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using plumed 2.3.5\
                \nin the shared directory /share/apps/plumed/2.3.5\
                \nbuilded with gcc-5.4.0, mpich2-3.2, openblas-0.2.19\
                \ngsl-2.4 and libmatheval-1.11.0."
        }

        module-whatis "(Name________) plumed"
        module-whatis "(Version_____) 2.3.5"
        module-whatis "(Compilers___) gcc-5.4.0_mpich2-3.2"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) opeblas-0.2.19, libmatheval-1.11.0, gsl-2.4"

        # for Tcl script use only
        set         topdir        /share/apps/plumed/2.3.5
        set         version       2.3.5
        set         sys           x86_64-redhat-linux

        conflict plumed

        module load mpich2/3.2_gcc-5.4.0
        module load openblas/0.2.19_gcc-5.4.0
        module load gsl/2.4_gcc-5.4.0
        module load libmatheval/1.1.11


        prepend-path	PATH			$topdir/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib
        prepend-path	DYLD_LIBRARY_PATH	$topdir/lib

        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLLUDE_PATH	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include

        setenv		PLUMED_KERNEL		$topdir/lib/libplumedKernel.so

Mode of Use
-----------

- The use of **Plumed** in this case is limited to patching the **Gromacs** source code for this MD to use **Plumed** for physical handling.

    .. code-block:: bash

       module load wrf/3.7.1_gcc-5.4.0

References
----------

- http://www.plumed.org
- https://plumed.github.io/doc-v2.3/user-doc/html/_installation.html
- https://plumed.github.io/doc-v2.3/user-doc/html/gromacs-5-1-4.html
- http://www.jyhuang.idv.tw/JYH_ComputingPackages.html
- http://pdc-software-web.readthedocs.io/en/latest/software/plumed/centos7/2.3b/
- https://plumed.github.io/doc-v2.4/user-doc/html/_g_m_x_g_p_u.html

Authors
-------

- Mateo Gómez Zuluaga
