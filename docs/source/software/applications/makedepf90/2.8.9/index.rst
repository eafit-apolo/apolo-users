.. _makedepf90-2.8.9:

****************
Makedepf90 2.8.9
****************

.. contents:: Table of Contents

Basic Information
-----------------

- **Deploy Date:** March 28 2022
- **Downloads page:** https://github.com/outpaddling/makedepf90
- **Installed on:** APOLO II

Requirements
------------

- gcc
- bison
- flex

Installation
------------

As the installation process changed for this version the README and readme are deprecated

#. Load the modules you need to compile the desired version of Makedepf90

   .. code-block:: bash

       module load gcc/11.2.0

#. Clone the repository in the directory you are going to compile the application

   .. code-block:: bash

       mkdir build-makedepf90 && cd build-makedepf90
       git clone https://github.com/outpaddling/makedepf90.git
       cd makedepf90

#. Open the file Makefile.in and edit the variable DESTDIR to your preference

   .. code-block:: Makefile

       DESTDIR ?= /

#. Run make and then edit the file Makefile again to change the prefix variable.


    .. code-block:: bash

        make
        vim Makefile

    Edit the Makefile that has been written by the command above

    .. code-block:: Makefile

        PREFIX ?= /share/apps/makedepf90/2.8.9/gcc-11.2.0/

#. Run make install as super user to end the installation process

   .. code-block:: bash

       sudo make install

Module
------

.. code-block:: tcl

    #%Module1.0####################################################################
    ##
    ## module load makedepf90/2.8.9_gcc-11.2.0
    ##
    ## /share/apps/modules/makedepf90/2.8.9_gcc-11.2.0
    ## Written by Alejandra Cardenas and Santiago Alzate
    ##

    proc ModulesHelp {} {
        global version modroot
        puts stderr "Sets the environment for using makedepf90 2.8.9\
                    \nin the shared directory \
                    \n/share/apps/makedepf90/2.8.9/gcc-11.2.0 builded with\
                    \ngcc-11.2.0,\
    }

    module-whatis "(Name________) makedepf90"
    module-whatis "(Version_____) 2.8.9"
    module-whatis "(Compilers___) gcc-11.2.0"
    module-whatis "(System______) x86_64-redhat-linux"

    # for Tcl script use only
    set         topdir        /share/apps/makedepf90/2.8.9/gcc-11.2.0
    set         version       2.8.9
    set         sys           x86_64-redhat-linux

    conflict makedepf90

    module load gcc/11.2.0

    prepend-path    PATH                    $topdir/bin

    prepend-path    MANPATH                 $topdir/share/man

:Authors:
    Santiago Alzate Cardona <salzatec1@eafit.edu.co>

    Alejandra Cárdenas  <acarden6@eafit.edu.co>
