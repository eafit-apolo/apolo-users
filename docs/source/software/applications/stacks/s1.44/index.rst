.. _Stack44:

.. contents:: Table of Contents

**************
Stacks 1.44
**************

- **Installation date:** 06/02/2012
- **URL:** http://catchenlab.life.illinois.edu/stacks/
- **Apolo version:** Apolo II
- **License:**  GNU GPL

Dependencies
-------------

- GNU GCC 4.7

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    $ wget http://catchenlab.life.illinois.edu/stacks/source/stacks-1.44.tar.gz
    $ tar -zxvf stacks-1.44.tar.gz

#. configure the makefile

.. code-block:: bash

    cd stacks-1.44
    module load gcc/4.9.4
    export CXXFLAGS="-O3 -march=broadwell"
    ./configure --prefix=/share/apps/stacks/1.44/gcc/4.9.4
    make
    sudo make install


Module
---------

.. code-block:: bash

  #%Module1.0#####################################################################
    ##
    ## module stacks/1.44_gcc_4.9.4
    ##
    ## /share/apps/stacks/1.44/gcc/4.9.4     Written by Alejandro Salgado-Gomez
    ##

    proc ModulesHelp { } {
        puts stderr "\tncl/2.1.18_intel-2017_update-1 - sets the Environment for stacks in \
        \n\tthe share directory /share/apps/stacks/1.44/gcc/4.9.4\n"
    }

    module-whatis "\n\n\tSets the environment for using stacks 1.44 \
                   \n\tbuilded with Gcc 4.9.4\n"

    # for Tcl script use only
    set       topdir     /share/apps/stacks/1.44/gcc/4.9.4
    set       version    1.44
    set       sys        x86_64-redhat-linux

    module load gcc/4.9.4

    prepend-path PATH       $topdir/bin


Use mode
----------

.. code-block:: bash

    module load stacks/1.44_gcc_4.9.4


References
------------

- http://catchenlab.life.illinois.edu/stacks/manual/#install

Author
------

- Alejandro Salgado Gómez
