.. _SAMtools-1.3.1:


.. contents:: Table of Contents

*****
1.3.1
*****

- **Installation date:** 28/02/2017
- **URL:** http://samtools.sourceforge.net/
- **Apolo version:** Apolo II
- **License:** The MIT/Expat License

Dependencies
------------

- Intel Parallel Studio XE Cluster Edition 2017 Update 1
- zlib >= 1.2.11

Installation
------------

After solving the aforementioned dependencies, you can proceed with the installation of **SAMtools.**

1. Download the latest version of the software (Source code - bz2) (https://sourceforge.net/projects/samtools/files/):

.. code-block:: bash

    cd /home/$USER/apps/samtools/src
    wget https://downloads.sourceforge.net/project/samtools/samtools/1.3.1/samtools-1.3.1.tar.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsamtools%2Ffiles%2Fsamtools%2F&ts=1488295734&use_mirror=ufpr
    tar xf samtools-1.3.1.tar.bz2

2. For configuration and compilation, the following steps must be taken:

.. code-block:: bash

    cd samtools-1.3.1
    module load zlib/1.2.11_intel-2017_update-1
    ./configure --prefix=/share/apps/samtools/1.3.1/intel/2017_update-1 2>&1 conf-samtools.log
    make 2>&1 | tee make-samtools.log
    make check 2>&1 | tee make-check-samtools.log

3. After compiling **SAMtools**, we continue with the following steps:

.. code-block:: bash

    sudo mkdir -p /share/apps/samtools/1.3.1/intel/2017_update-1
    sudo mkdir -p /share/apps/samtools/1.3.1/intel/2017_update-1/include/bam
    sudo mkdir -p /share/apps/samtools/1.3.1/intel/2017_update-1/lib
    sudo chown -R $USER.apolo /share/apps/samtools/1.3.1/intel/2017_update-1
    make install 2>&1 | tee make-install-samtools.log
    cp libbam.a /share/apps/bwa/0.7.15/intel/2017_update-1/lib
    cp *.h /share/apps/samtools/1.3.1/intel/2017_update-1/include/bam
    sudo chown -R root.root /share/apps/samtools/1.3.1/intel/2017_update-1

Module
------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module load samtools/1.3.1_intel-2017_update-1
    ##
    ## /share/apps/modules/samtools/1.3.1_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tsamtools/1.3.1 - sets the Environment for SAMTOOLS in \
        \n\tthe share directory /share/apps/samtools/1.3.1/intel-2017_update-1\n"
    }

    module-whatis "\n\n\tSets the environment for using SAMTOOLS-1.3.1 \
                   \n\tbuilded with Intel Parallel Studio XE 2017\n"

    # for Tcl script use only
    set       topdir     /share/apps/samtools/1.3.1/intel/2017_update-1
    set       version    1.3.1
    set       sys        x86_64-redhat-linux

    module load intel/2017_update-1

    prepend-path PATH    $topdir/bin

    prepend-path LD_LIBRARY_PATH    $topdir/lib
    prepend-path LIBRARY_PATH       $topdir/lib
    prepend-path LD_RUN_PATH        $topdir/lib

    prepend-path C_INCLUDE_PATH     $topdir/include
    prepend-path CXX_INCLUDE_PATH   $topdir/include
    prepend-path CPLUS_INCLUDE_PATH $topdir/include

    prepend-path MANPATH $topdir/share/ma

Mode of use
-----------

Load the necessary environment through the **module:**

.. code-block:: bash

    module load samtools/1.3.1_intel-2017_update-1

TO-DO

References
----------

- INSTALL (File inside compressed package)
- https://github.com/cole-trapnell-lab/cufflinks

Author
------

- Mateo Gómez Zuluaga
