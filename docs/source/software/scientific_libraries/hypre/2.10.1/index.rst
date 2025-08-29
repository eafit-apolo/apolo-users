.. _hypre2.10.1-index:


Hypre 2.10.1
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://computation.llnl.gov/projects/hypre-scalable-linear-solvers-multigrid-methods
- **License:** GNU Lesser General Public License 2.1
- **Installed on:** Apolo II and Cronos
- **Installation date:** 03/03/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Parallel Studio XE Cluster Edition 2017 (Update 1) (Intel Compiler, Intel MPI and MKL)



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/hypre/src/intel
        wget http://computation.llnl.gov/projects/hypre-scalable-linear-solvers-multigrid-methods/download/hypre-2.10.1.tar.gz
        tar -zxvf hypre-2.10.1.tar.gz


#. After unpacking Hypre, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        module load intel/2017_update-1
        module load impi/2017_update-1
        module load mkl/2017_update-1
        cd hypre-2.10.1/src
        ./configure --prefix=/share/apps/hypre/2.10.1/intel_impi/2017_update-1 --enable-fortran --with-MPI --with-blas-libs=mkl_intel_ilp64 mkl_sequential mkl_core pthread m dl --with-blas-lib-dirs=/share/apps/intel/ps_xe/2017_update-1/mkl/lib/intel64_lin --with-lapack-libs=mkl_intel_ilp64 mkl_sequential mkl_core pthread m dl --with-lapack-lib-dirs=/share/apps/intel/ps_xe/2017_update-1/mkl/lib/intel64_lin
        make -2>&1 | tee make-hypre.log
        make check 2>&1 | tee make-check-hypre.log



#. Installation of compiled binaries

    .. code-block:: bash

        sudo mkdir -p /share/apps/hypre/2.10.1/intel_impi/2017_update-1
        sudo chown -R mgomezzul.apolo /share/apps/hypre/2.10.1/intel_impi/2017_update-1
        make install 2>&1 | tee make-install-hypre.log




Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module hypre/2.10.1_intel_impi-2017_update-1
        ##
        ## /share/apps/modules/hypre/2.10.1_intel_impi-2017_update-1	Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\thypre/2.10.1_intel-2017_update-1 - sets the Environment for Hypre in \
            \n\tthe share directory /share/apps/hypre/2.10.1/intel_impi/2017_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using Hypre-2.10.1 \
                    \n\tbuilded with Intel Parallel Studio XE 2017 Update 1\n"

        conflict hypre

        module load intel/2017_update-1
        module load impi/2017_update-1
        module load mkl/2017_update-1

        # for Tcl script use only
        set   	      topdir	/share/apps/hypre/2.10.1/intel_impi/2017_update-1
        set	      version	2.10.1
        set	      sys	x86_64-redhat-linux

        prepend-path LD_LIBRARY_PATH		$topdir/lib
        prepend-path LIBRARY_PATH       	$topdir/lib
        prepend-path LD_RUN_PATH        	$topdir/lib

        prepend-path C_INCLUDE_PATH     	$topdir/include
        prepend-path CXX_INCLUDE_PATH   	$topdir/include
        prepend-path CPLUS_INCLUDE_PATH 	$topdir/include





Use
---

    .. code-block:: bash

        module load hypre/2.10.1_intel_impi_2017_update-1



Resources
---------
    * https://wiki.rc.ufl.edu/doc/Hypre
    * https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor

Author
------
    * Mateo Gómez Zuluaga
