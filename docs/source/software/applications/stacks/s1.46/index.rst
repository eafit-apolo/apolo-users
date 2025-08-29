.. _Stack46:

.. contents:: Table of Contents

**************
Stacks 1.46
**************

- **Installation date:** 21/04/2012
- **URL:** http://catchenlab.life.illinois.edu/stacks/
- **Apolo version:** Apolo II
- **License:**  GNU GPL

Dependencies
-------------

- GNU GCC 5.4.0
- SparseHash = 2.0.3

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    $ wget http://catchenlab.life.illinois.edu/stacks/source/stacks-1.46.tar.gz
    $ tar -zxvf stacks-1.46.tar.gz

#. configure the makefile

.. code-block:: bash

    cd stacks-1.46
    module load gcc/5.4.0
    sudo mkdir -p /share/apps/stacks/1.46/gcc-5.4.0
    sudo chwon -R mgomezzul.apolo /share/apps/stacks/1.46/gcc-5.4.0
    ./configure --prefix=/share/apps/stacks/1.46/gcc-5.4.0 --build=redhat-linux-x86_64 CXXFLAGS="-O3 -march=native" CFLAGS="-O3 -march=native" CPPFLAGS="-O3 -march=native" --enable-sparsehash --with-sparsehash-include-path=/share/apps/sparsehash/2.0.3/gcc-5.4.0/include
    make
    make install
    sudo chown -R root.root /share/apps/stacks/1.46/gcc-5.4.0


Module
---------

.. code-block:: bash

    #%Module1.0####################################################################
    ##
    ## module load stacks/1.46_gcc-5.4.0
    ##
    ## /share/apps/modules/stacks/1.46_gcc-5.4.0
    ##
    ## Written by Mateo Gómez-Zuluaga
    ##

    proc ModulesHelp {} {
         global version modroot
         puts stderr "Sets the environment for using stacks 1.46\
             \n\in the shared directory \
             \n\t\t/share/apps/stacks/1.46/gcc-5.4.0\
             \n\t\tbuilded with gcc-5.4.0\
             \n\t\t"
    }

    module-whatis "(Name________)  stacks"
    module-whatis "(Version_____)  1.46"
    module-whatis "(Compilers___)  gcc-5.4.0"
    module-whatis "(System______)  x86_64-redhat-linux"
    module-whatis "(Libraries___)  sparsehash"

    # for Tcl script use only
    set         topdir        /share/apps/stacks/1.46/gcc-5.4.0
    set         version       1.46
    set         sys           x86_64-redhat-linux

    conflict stacks

    module load sparsehash/2.0.3_gcc-5.4.0

    prepend-path PATH                $topdir/bin


Use mode
----------

.. code-block:: bash

    module load stacks/1.46_gcc-5.4.0


References
------------

- http://catchenlab.life.illinois.edu/stacks/manual/#install

Author
------

- Mateo Gómez-Zuluaga
- Alejandro Salgado Gómez
