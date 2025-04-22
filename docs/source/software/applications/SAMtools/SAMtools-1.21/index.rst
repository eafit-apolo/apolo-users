.. _SAMtools-1.21:


.. contents:: Table of Contents

*****
1.21
*****

- **Installation date:** 01/04/2025
- **URL:** https://www.htslib.org/

Dependencies
------------

- bzip2 >= 1.0.6

Installation
------------

After installing the dependencies we can proceed with **SAMtools** installation

1. Download the latest version of the software (https://www.htslib.org/download/):

.. code-block:: bash

    tar -xvjf samtools-1.21.tar.bz2

2. For configuration and compilation, the following steps must be taken:

.. code-block:: bash

    cd samtools-1.21
    ./configure --prefix=/where/to/install
    make
    make install

3. The executable programs will be installed to a bin subdirectory under your specified prefix, so you may wish to add this directory to your $PATH:

.. code-block:: bash

   export PATH=/where/to/install/bin:$PATH

4. Verify the installation:

.. code-block:: bash

   ./samtools --version

Also you can acces the examples folder and test the installation.

Module
------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## modules samtools1.21_gcc-11.2.0
    ##
    ## /share/apps/samtools/1.21/samtools-1.21
    ##

    proc ModulesHelp { } {
        puts stderr "\t1.21samtools-1.21 - sets the Enviroment for SAMTOOLS in \
        \n\tthe share directory /share/apps/modules/samtools/1.21_gcc-11.2.0\n"
    }

    module-whatis "\n\n\tSets the enviroment for SAMTOOLS\
                  \n\tbuilt with gcc-11.2.0\n"

    #for TCL script use only
    set       topdir     /share/apps/samtools/1.21/samtools-1.21
    set       version    1.21
    set       sys        x86_64-redhat-linux

    conflict samtools

    module load bzip2

    prepend-path    LD_LIBRARY_PATH         $topdir/htslib-1.21/htslib
    prepend-path    LD_RUN_PATH             $topdir/htslib-1.21/htslib
    prepend-path    LIBRARY_PATH            $topdir/htslib-1.21/htslib

    prepend-path    PATH                    $topdir/bin

    prepend-path    MANPATH                 $topdir/share/man

Mode of use
-----------

Load the necessary environment through the **module:**

.. code-block:: bash

    module load samtools/1.21_gcc-11.2.0

References
----------

- https://www.htslib.org/download/
- https://github.com/samtools/samtools/releases/tag/1.21

Author
------

- Emanuell Torres López
