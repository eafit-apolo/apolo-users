.. _CDO-1.9.2:

CDO 1.9.2
===========

- **Installation date:** 22/02/2017
- **URL:** https://code.mpimet.mpg.de/projects/cdo/
- **Apolo version:** Apolo II
- **License:** GNU v2

.. contents:: Table of Contents

Dependencies
------------

- STD C++11
- GCC/5.4.0

Dependencies not mandatory
++++++++++++++++++++++++++

- NetCDF
- Hdf5
- Hdf5 szip
- proj.4
- ECMWF ecCodes
- Magic

Installation
------------

The installation specified here does not include any of the non-mandatory dependencies previously listed.

1. We obtain the source of **CDO (Climate Data Operations)** from the official website

.. code-block:: bash

    wget https://code.mpimet.mpg.de/attachments/download/16035/cdo-1.9.2.tar.gz

2. Unzip, open the package and enter the directory

.. code-block:: bash

    mkdir build
    mkdir -p /share/apps/cdo/1.9.2/

3. We carry out the compilation process

.. code-block:: bash

    cd build
    ../configure --prefix=/share/apps/cdo/1.9.2 --build=x86_64-redhat-linux-gnu
    make

4. We confirm that the compilation has been correct and then we install

.. code-block:: bash

    make check
    make install

Module file
-----------

.. code-block:: bash

    #%Module1.0####################################################################
    ##
    ## module load cdo/1.9.2
    ##
    ## /share/apps/modules/cdo/1.9.2
    ## Written by Juan David Arcila Moreno
    ##

    proc ModulesHelp {} {
        global version modroot
        puts stderr "Sets the environment for using cdo 1.9.2\
		            \nin the shared directory \
		            \n/share/apps/cdo/1.9.2\
		            \nbuilded with gcc-5.4.0"
    }

    module-whatis "(Name________) cdo"
    module-whatis "(Version_____) 1.9.2"
    module-whatis "(Compilers___) gcc-5.4.0"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) "

    # for Tcl script use only
    set         topdir        /share/apps/cdo/1.9.2
    set         version       1.9.2
    set         sys           x86_64-redhat-linux

    conflict cdo


    prepend-path	PATH			$topdir/bin



Usage mode
-----------

.. code-block:: bash

    module load cdo/1.9.2
    cdo -h [operator]

References
----------

`CDO Official page <https://code.mpimet.mpg.de/projects/cdo/>`_

Author
------

- Juan David Arcila-Moreno
