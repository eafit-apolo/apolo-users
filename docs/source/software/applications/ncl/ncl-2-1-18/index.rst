.. _ncl-2.1:

.. contents:: Table of Contents

************
NCL 2.1.18
************

- **Installation date:** 06/02/2017
- **URL:** https://sourceforge.net/projects/ncl/
- **Apolo version:** Apolo II
- **License:** Simplified BSD license

Dependencies
-------------

- Intel Parallel Studio XE 2017 Update 1 (C y C++)

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    wget https://downloads.sourceforge.net/project/ncl/NCL/ncl-2.1.18/ncl-2.1.18.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fncl%2F&ts=1486420255&use_mirror=ufpr
    tar -zxvf ncl-2.1.18.tar.gz


#. compilation config

.. code-block:: bash

    cd ncl-2.1.18
    module load intel/2017_update-1
    env CPPFLAGS=-DNCL_CONST_FUNCS ./configure --prefix=/share/apps/ncl/2.1.18/intel/2017_update-1  --build=x86_64-redhat-linux  2>&1 | tee ncl-conf.log
    make 2>&1 | tee ncl-make.log

Module
---------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module ncl/2.1.18_intel-2017_update-1
    ##
    ## /share/apps/ncl/2.1.18/intel/2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tncl/2.1.18_intel-2017_update-1 - sets the Environment for NCL in \
        \n\tthe share directory /share/apps/ncl/2.1.18/intel/2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using NCL 2.1.18 \
                   \n\tbuilded with Intel Parallel Studio XE 2017\n"

    # for Tcl script use only
    set       topdir     /share/apps/ncl/2.1.18/intel/2017_update-1
    set       version    2.1.18
    set       sys        x86_64-redhat-linux

    module load intel/2017_update-1

    prepend-path PATH		$topdir/bin

    prepend-path LD_LIBRARY_PATH    $topdir/lib/ncl
    prepend-path LIBRARY_PATH       $topdir/lib/ncl
    prepend-path LD_RUN_PATH        $topdir/lib/ncl

    prepend-path C_INCLUDE_PATH     $topdir/include/ncl
    prepend-path CXX_INCLUDE_PATH   $topdir/include/ncl
    prepend-path CPLUS_INCLUDE_PATH $topdir/include/ncl

    prepend-path PKG_CONFIG_PATH    $topdir/lib/pkgconfig

usage mode
-----------

.. code-block:: bash

    module load ncl/2.1.18_intel-2017_update-1

References
------------

- manual

Author
------

- Mateo Gómez Zuluaga
