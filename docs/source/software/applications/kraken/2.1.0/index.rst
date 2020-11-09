.. _kraken-2.1.0-index:


Kraken 2.1.0
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://ccb.jhu.edu/software/kraken2/
- **Downloads page:** https://github.com/DerrickWood/kraken2
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6

- **Compiler** Perl 5.26.1 and GCC 7.4.0

Installation
-------------


#. First of all, you must load the following modules for the compilation.

    .. code-block:: bash

        $ module load gcc/7.4.0
        $ module load perl/5.26.1_gcc-4.4.7


#. After that, download the source code from github and move into the directory generated.

    .. code-block:: bash

        $ git clone https://github.com/DerrickWood/kraken2.git
        $ cd kraken2/


#. Before to start the installation, you should make two directories,
   the first one is an installation directory acting as "prefix",
   the second one is the bin directory, the last one is useful
   if you want to place the kraken2 scripts in you $PATH.

    .. code-block:: bash

        $ mkdir -p $HOME/kraken/{instalation,bin}
        $ # This sets a temporal environment variable to set the "prefix path"
        $ KRAKEN_DIR="$HOME/kraken/instalation/"


#. Then you can continue with the installation, after execute the install
   script you should copy three binary files from the "installation prefix"
   \(install directory\) to the binaries \(bin directory\), mentioned above.

    .. code-block:: bash

        $ ./install_kraken2.sh $KRAKEN_DIR
        $ cd $KRAKEN_DIR/..
        $ cp instalation/kraken2{,-build,-inspect} bin/


#. If the installation was successful then you should:

    .. code-block:: bash

        $ cd bin/
        $ ./kraken2 --version


#. Optional: If you want, you can add the $HOME/kraken/bin/ directory to your $PATH.


Authors
-------
 - Laura Sanchez Cordoba
 - Samuel Palacios Bernate
