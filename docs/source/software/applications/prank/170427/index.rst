.. _prank170427-index:


Prank 170427
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://wasabiapp.org/software/prank/
- **Downloads page:** http://wasabiapp.org/download/prank/
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6

- **Compiler** Intel 19.0.4

Installation
-------------


#. First of all, you must load the following modules for the compilation.

    .. code-block:: bash

        $ module load intel/19.0.4


#. After that, download the source code from github and move into the src directory generated.

    .. code-block:: bash

        $ git clone https://github.com/ariloytynoja/prank-msa.git
        $ cd prank-msa/src


#. Before starting the installation, you should make some changes,
   in the Makefile in order to be able to compile Prank with
   ICC and ICPC support, so open your trusted text editor and edit the file.

    .. code-block:: bash

        $ # For this case I'll use vim
        $ vim Makefile

#. At the top of the Makefile, you'll find a section titled "Compiler, tools and options".
   There, there are some variables such as CC, CXX, CFLAGS, CXXFLAGS, etc.
   Those variables should look like the following after the changes.

    .. code-block:: bash

        CC            = icc
        CXX           = icpc
        DEFINES       = -xHost -Ofast -pipe
        CFLAGS        = $(DEFINES)
        CXXFLAGS      = $(DEFINES)
        LINK          = icpc
        AR            = xiar cqs

#. Then you can continue with the installation.

    .. code-block:: bash

        $ make -j


#. If the installation was successful then you should:

    .. code-block:: bash

        $ ./prank -version


#. Optional: If you want, you can add the Prank binary to your $PATH.
   For this, is highly recommended to move just the binary file to another location
   and add it to your $PATH

    .. code-block:: bash

        $ mkdir -p $HOME/prank-bin
        $ cp prank $HOME/prank-bin
        $ cd $HOME/prank-bin
        $ ./prank -version
        $ # From here you can follow some tutorial about how to add something to your $PATH



Authors
-------
 - Laura Sanchez Cordoba
 - Samuel Palacios Bernate
