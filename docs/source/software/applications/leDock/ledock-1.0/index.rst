.. _ledock-1.0:

.. contents:: Table of Contents

***********
LeDock 1.0
***********

- **Installation date:** 19/10/2017
- **URL:** http://www.lephar.com/
- **Apolo version:** Apolo II
- **License:**  Not found


Dependencies
-------------

- GNU GCC >= 4.4.7
- glibc >= 2.14
- patchelf >= 0.9

Installation
------------
Load the needed modules or add the to the path

1. Download the binaries

.. code-block:: bash

    $ wget http://www.lephar.com/download/ledock_linux_x86


2. create the directories

.. code-block:: bash

    $ mkdir -p /share/apps/ledock/1.0/bin
    $ mv ledock_linux_x86 /share/apps/ledock/1.0/bin/ledock

3. execute permissions

.. code-block:: bash

    $ chmod +x /share/apps/lepro/2013/bin/ledock

Patch of the binary
--------------------

.. code-block:: bash

    $ patchelf --set-interpreter /share/apps/glibc/2.20/lib/ld-linux-x86-64.so.2 /share/apps/ledock/1.0/bin/ledock

Module
------

.. code-block:: bash

    #%Module1.0##############################################################\
    ######
    ##
    ## module load ledock/1.0
    ##
    ## /share/apps/modules/ledock/1.0
    ## Written by Juan David Arcila Moreno
    ##

    proc ModulesHelp {} {
         global version modroot
         puts stderr "Sets the environment for using ledock 1.0\
                      \nin the shared directory \
                      \n/share/apps/ledock/1.0/\
                      \nbuilded with gcc-5.4.0\
                      \nledock needs glibc>=2.14"
    }

    module-whatis "(Name________) ledock"
    module-whatis "(Version_____) 1.0"
    module-whatis "(Compilers___) gcc-4.4.7"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) glibc-2.14"

    # for Tcl script use only
    set         topdir        /share/apps/ledock/1.0/
    set         version       1.0
    set         sys           x86_64-redhat-linux

    conflict ledock


    prepend-path    PATH                    $topdir/bin

Use mode
-----------

.. code-block:: bash

    $ module load ledock/1.0
    $ ledock config.file    !docking
    $ ledock -spli dok.file !split into separate coordinates

References
----------

- http://www.lephar.com/
- https://nixos.org/patchelf.html/

Author
------

- Juan David Arcila-Moreno
