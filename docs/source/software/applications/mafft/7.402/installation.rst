.. _maff-7.402-installation:

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents

   .. contents::
      :local:

Tested on (Requirements)
------------------------

- **OS base:** Linux (x86-64) >= 2.6

Installation
------------

1. Download the package and decompress it.
   
.. code-block:: bash

   $ wget https://mafft.cbrc.jp/alignment/software/mafft-7.402-with-extensions-src.tgz
   $ tar xfvz mafft-7.402-with-extensions-src.tgz

2. Enter in core directory and open the Makefile wit the editor of your choice.
   
.. code-block:: bash

   $ cd mafft-7.402-with-extensions/core
   $ emacs -nw Makefile

   
3. Change the PREFIX (first line) with the path where you want the program.

   from:
   
   PREFIX = /usr/local
   
   to:
   
   PREFIX = /your/path

.. code-block:: bash
		
   $ make clean
   $ make
   $ make install
