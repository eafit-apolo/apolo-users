.. _ecl-24.5.10-index:


ECL 24.5.10
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.mpich.org/
- **Downloads page:** https://www.mpich.org/downloads
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 8.5.0

Installation
-------------

#. First of all, we need to create a directory where we will build the software. In this case, we will create a directory called ``build_ecl``

    .. code-block:: bash

        $ mkdir build_ecl

#. Then, we need to clone the GitHub repository

    .. code-block:: bash

        $ git clone https://github.com/roswell/ecl.git

#. Then, we can continue with the installation

    .. code-block:: bash

        $ cd ecl
        $ ./configure --prefix=../build_ecl
        $ make -j 10
        $ make install

#. Finally, we can add ecl to our PATH environment variable

    .. code-block:: bash

        $ export PATH=$PATH:~/build_ecl/bin

Author
------
 - Juan Manuel Gomez Piedrahita