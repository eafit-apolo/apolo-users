.. _parallel-20250222-index:


PARALLEL 20250222
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.gnu.org/software/parallel/
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 8.5.0

Installation
-------------

#. First of all, we need to create a directory where we will build the software. In this case, we will create a directory called ``build_parallel`` in our home directory

    .. code-block:: bash
        $ mkdir build_parallel

#. Then, we need to download and extract the parallel source code

    .. code-block:: bash
        $ wget https://ftpmirror.gnu.org/parallel/parallel-latest.tar.bz2
        $ tar xf parallel-latest.tar.bz2

#. Then, we can execute install parallel

    .. code-block:: bash
        $ cd parallel-20250222
        $ ./configure --prefix=$HOME/build_parallel
        $ make -j 8
        $ make install

#. Finally, we can add parallel to our PATH environment variable

    .. code-block:: bash
        $ export PATH=$PATH:~/build_parallel/bin

Author
------
 - Juan Manuel Gomez Piedrahita
