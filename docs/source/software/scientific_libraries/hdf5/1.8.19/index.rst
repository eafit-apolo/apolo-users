.. _hdf5-1.8.19-index:


Hdf5 1.8.19
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://support.hdfgroup.org/HDF5/release/obtainsrc518.html
- **License:**  GNU GENERAL PUBLIC LICENSE Version 2
- **Installed on:** Apolo II and Cronos
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

        cd /home/mgomezzul/apps/hdf5/intel
        wget https://support.hdfgroup.org/ftp/HDF5/current18/src/hdf5-1.8.19.tar
        tar -xvf hdf5-1.8.19.tar


#. After unpacking HDF5, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd hdf5-1.8.19
        module unload slurm
        module load intel/2017_update-1 zlib/1.2.11_intel-2017_update-1 szip/2.1_intel-2017_update-1
        ./configure --prefix=/share/apps/hdf5/1.8.19/intel-2017_update-1 --build=x86_64-redhat-linux --enable-fortran --enable-cxx --with-zlib=/share/apps/zlib/1.2.11 --with-szlib=/share/apps/szip/2.1/intel-2017_update-1 2>&1 | tee hdf5-conf.log
        make 2>&1 | tee hdf5-make.log
        sudo mkdir -p /share/apps/hdf5/1.8.19/intel-2017_update-1
        sudo chown -R mgomezzul.apolo /share/apps/hdf5/1.8.19/intel-2017_update-1
        make install 2>&1 | tee hdf5-make-install.log
        sudo chown -R root.root /share/apps/hdf5/1.8.19/intel-2017_update-1


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load hdf5/1.8.19_intel-2017_update-1
        ##
        ## /share/apps/modules/hdf5/1.8.19_intel-2017_update-1
        ## Written by Mateo Gómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using hdf5 1.8.19\
                \nin the shared directory /share/apps/hdf5/1.8.19/intel-2017_update-1\
                \nbuilded with intel-17.0.1."
        }

        module-whatis "(Name________) hdf5"
        module-whatis "(Version_____) 1.8.19"
        module-whatis "(Compilers___) intel-17.0.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) zlib, szip"

        # for Tcl script use only
        set         topdir        /share/apps/hdf5/1.8.19/intel-2017_update-1
        set         version       1.8.19
        set         sys           x86_64-redhat-linux

        conflict hdf5
        module load intel/2017_update-1
        module load szip/2.1_intel-2017_update-1
        module load zlib/1.2.11_intel-2017_update-1


        prepend-path	PATH			$topdir/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib

        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLUDE_PATH	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include




Use
---

    TO-DO


Resources
---------
    * https://support.hdfgroup.org/downloads/index.html


Author
------
    * Mateo Gómez Zuluaga
