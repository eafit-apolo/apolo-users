.. _hdf5-1.12.0-index:


Hdf5 1.12.0
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://support.hdfgroup.org/HDF5/release/obtainsrc518.html
- **License:**  GNU GENERAL PUBLIC LICENSE Version 2
- **Installed on:** Apolo II
- **Installation date:** 14/11/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Parallel Studio XE Cluster Edition >= 17.0.1
    * zlib >= 1.2.11
    * szip >= 2.1



Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd $HOME/apps/hdf5/intel
        wget https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_0/source/hdf5-1.12.0.tar.gz
        tar -xvf hdf5-1.8.19.tar


#. After unpacking HDF5, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd hdf5-1.8.19
        module load intel/intel-19.0.4 zlib/1.2.11_intel-19.0.4 szip/2.1.1_intel-19.0.4
        ./configure -prefix=/share/apps/hdf5/1.12/intel-19.0.4 --with-zlib=/share/apps/zlib/1.2.11/intel_19.0.4 --with-szlib=/share/apps/szip/2.1.1/intel_19.0.4 --enable-fortran --enable-cxx
        make 2>&1 | tee hdf5-make.log
        sudo mkdir -p /share/apps/hdf5/1.12/intel-19.0.4
        make install 2>&1 | tee hdf5-make-install.log

Troubleshooting
---------------

If you have an erro during the configure that says `Can not find ifort` or another compiler then do the followin:

Please export these variables

.. code-block:: bash

        export CC=icc
        export F9X=ifort
        export CXX=icpc

If you continue to have the error, burn the variables in the ./configure command

.. code-block:: bash

    ./configure CC=icc F9X=ifort CXX=icpc ...

If you continue to have an error, burn the path of the icc and ifort commands to the configure command

.. code-block:: bash

    ./configure CC=/path/to/icc F9X=/path/to/ifort CXX=/path/to/icpc ...

Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load hdf5/1.12_intel-19.0.4
        ##
        ## /share/apps/modules/hdf5/1.12_intel-19.0.4
        ## Written by Tomas Navarro & Santiago Alzate
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using hdf5 1.12\
                          \nin the shared directory /share/apps/hdf5/1.12/intel-19.0.4\
                          \nbuilded with intel-17.0.1."
        }

        module-whatis "(Name________) hdf5"
        module-whatis "(Version_____) 1.12"
        module-whatis "(Compilers___) intel-19.0.4"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) zlib, szip"

        # for Tcl script use only
        set         topdir        /share/apps/hdf5/1.12/intel-19.0.4
        set         version       1.8.19
        set         sys           x86_64-redhat-linux

        conflict hdf5
        module load intel
        module load szip/2.1.1_intel_19.0.4
        module load zlib/1.2.11_intel_19.0.4


        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include



Mode of use
-----------

    .. code-block:: bash

        $ module load hdf5/1.12_intel_19.0.4


Resources
---------
    * https://support.hdfgroup.org/downloads/index.html


Author
------
    * Tomas David Navarro
    * Santiago Alzate Cardona
