.. _lepro-2013:

.. contents:: Table of Contents

***********
LEPRO 2013
***********

- **Installation date:** 12/10/2017
- **URL:** http://www.lephar.com/
- **Apolo version:** Apolo II
- **License:** Not found


Dependencies
-------------
- GNU GCC >= 4.4.7

Installation
------------
Load the needed modules or add the to the path

1. Download the repository

.. code-block:: bash

    $ wget http://www.lephar.com/download/lepro_linux_x86

2. We create the installation folder and move the binary

.. code-block:: bash

    $ mkdir -p /share/apps/lepro/2013/bin
    $ mv lepro_linux_x86 /share/apps/lepro/2013/bin/lepro

3. execute permissions

.. code-block:: bash

    $ chmod +x /share/apps/lepro/2013/bin/lepro

Module
------

.. code-block:: bash

    #%Module1.0####################################################################
    ##
    ## module load lepro/2013
    ##
    ## /share/apps/modules/lepro/2013
    ## Written by Juan David Arcila Moreno
    ##

    proc ModulesHelp {} {
         global version modroot
         puts stderr "Sets the environment for using lepro 2013\
                      \nin the shared directory \
                      \n/share/apps/lepro/2013/\
                      \nDownload form http://www.lephar.com/download.htm"
    }

    module-whatis "(Name________) lepro"
    module-whatis "(Version_____) 2013"
    module-whatis "(Compilers___) "
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) "

    # for Tcl script use only
    set         topdir        /share/apps/lepro/2013/
    set         version       2013
    set         sys           x86_64-redhat-linux

    conflict lepro


    prepend-path    PATH                    $topdir/bin


Use mode
---------

.. code-block:: bash

    $ module load lepro/2013
    $ lepro [PDB file]

References
----------

- http://www.lephar.com/

Author
------

- Juan David Arcila-Moreno
