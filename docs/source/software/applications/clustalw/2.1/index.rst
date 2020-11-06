.. _clustalw-2.1-index:


Clustalw 2.1
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.clustal.org/clustal2/
- **Downloads page:** http://www.clustal.org/download/current/
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6

- **Compiler** Intel 19.0.4

Installation
-------------

#. First of all, we need to load the following module for the compilation

    .. code-block:: bash

        $ module load intel/19.0.4

#. After that download the tar.gz file and unpack it

    .. code-block:: bash

        $ wget http://www.clustal.org/download/current/clustalw-2.1.tar.gz
        $ tar -xzvf clustalw-2.1.tar.gz
        $ cd clustalw-2.1

#. Then we can continue with the installation

    .. code-block:: bash

        $ mkdir $HOME/clustalw
        $ ./configure --prefix=$HOME/clustalw --exec-prefix=$HOME/clustalw CFLAGS="-xHost -O3" CPPFLAGS="-xHost -O3" CXXFLAGS="-xHost -O3"
        $ make -j
        $ make install

#. If the installation was successful then you should:

    .. code-block:: bash

        $ cd $HOME/clustalw/bin/
        $ ./clustalw2


Authors
-------
 - Laura Sanchez Cordoba
 - Samuel Palacios Bernate
