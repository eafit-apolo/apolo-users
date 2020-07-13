.. _Cufflinks-2.2.1:

Cufflinks 2.2.1
================

- **Installation date:** 28/02/2017
- **URL:** http://cole-trapnell-lab.github.io/cufflinks/
- **Apolo version:** Apolo II
- **License:** Boost Software License, Version 1.0

.. contents:: Table of Contents

Installation
------------

These are the steps to install **Cufflinks:**

1. Download the latest version of the software (Binaries - bz2) (http://cole-trapnell-lab.github.io/cufflinks/install/):

.. code-block:: bash

    cd /home/$USER/apps/cufflinks/src
    wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
    tar xf cufflinks-2.2.1.Linux_x86_64.tar.gz

2. For installation, the following steps must be done:

..code-block:: bash

    cd cufflinks-2.2.1.Linux_x86_64
    sudo mkdir -p /share/apps/cufflinks/2.2.1/bin
    sudo cp cuff* g* /share/apps/cufflinks/2.2.1/bin

Module
------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module cufflinks/2.2.1
    ##
    ## /share/apps/modules/cufflinks/2.2.1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tcufflinks/2.2.1_intel-2017_update-1 - sets the Environment for Cufflinks in \
        \n\tthe share directory /share/apps/cufflinks/2.2.1\n"
    }

    module-whatis "\n\n\tSets the environment for using Cufflinks 2.2.1 \n"

    # for Tcl script use only
    set       topdir     /share/apps/cufflinks/2.2.1
    set       version    2.2.1
    set       sys        x86_64-redhat-linux

    repend-path PATH    $topdir/bin

Mode of use
-----------

Load the necessary environment through the **module:**

.. code-block:: bash

    module load cufflinks/2.2.1

TO-DO

References
----------

- https://github.com/cole-trapnell-lab/cufflinks

Author
------

- Mateo Gómez Zuluaga
