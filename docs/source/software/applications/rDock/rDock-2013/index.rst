.. _rdock:

.. contents:: Table of Contents

************
rDock 2013.1
************

- **Installation date:** 18/10/2017
- **URL:** http://rdock.sourceforge.net/
- **Apolo version:** Apolo II
- **License:** GNU-LGPLv3.0


Dependencies
-------------

- GNU GCC >= 3.3.4
- cppunit >= 1.12.1
- cppunit-devel >= 1.12.1
- popt-devel >= 1.7-190
- popt >= 1.7-190

Installation
------------
Load the needed modules or add the to the path

1. Download the binaries

.. code-block:: bash

    $ wget https://downloads.sourceforge.net/project/rdock/rDock_2013.1_src.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Frdock%2F%3Fsource%3Dtyp_redirect&ts=1508430181&use_mirror=superb-dca2
    $ mv rDock_2013.1_src.tar.gz\?r\=https\:%2F%2Fsourceforge.net%2Fprojects%2Frdock%2F\?source\=typ_redirect rDock_2013.1_src.tar.gz



2. unzip and compilation

.. code-block:: bash

    $ tar -xvzf rDock_2013.1_src.tar.gz
    $ cd rDock_2013.1_src/build
    $ make linux-g++-64 (usar 'make linux-g++' para 32-bits)

3. Test installation

.. code-block:: bash

    $ make test

Module
------

.. code-block:: bash

    #%Module1.0####################################################################
    ##
    ## module load rdock/2013.1
    ##
    ## /share/apps/modules/rdock/2013.1
    ## Written by Juan David Arcila Moreno
    ##

    proc ModulesHelp {} {
         global version modroot
         puts stderr "Sets the environment for using rdock 2013.1\
                      \nin the shared directory \
                      \n/share/apps/rdock/2013.1/\
                      \nbuilded with gcc-5.4.0"
    }

    module-whatis "(Name________) rdock"
    module-whatis "(Version_____) 2013.1"
    module-whatis "(Compilers___) g++-4.4.7"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) popt-1.7-190"

    # for Tcl script use only
    set         topdir        /share/apps/rdock/2013.1/
    set         version       2013.1
    set         sys           x86_64-redhat-linux

    conflict rdock


    prepend-path    PATH                    $topdir/bin

    prepend-path    LD_LIBRARY_PATH         $topdir/lib
    prepend-path    LIBRARY_PATH            $topdir/lib
    prepend-path    LD_RUN_PATH             $topdir/lib


Use mode
---------

.. code-block:: bash

    $ module load rdock/2013.1


References
----------

- https://sourceforge.net/projects/rdock/files/?source=navbar
- http://rdock.sourceforge.net/

Author
------

- Juan David Arcila-Moreno
