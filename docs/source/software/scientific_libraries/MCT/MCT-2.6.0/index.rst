
MCT
===============================

.. contents:: Table of Contents

Basic information
-----------------
- **License:**  This product includes software developed by the University of Chicago, as Operator of Argonne National Laboratory. MCT license [1]_
- **Apolo Version:** Indices

Requiriments
------------

* GNU Fortran 11.2.0
* MPICH 4.0.1

Installation
------------

1. clone the github repository in your home

.. code-block:: bash

  $ git clone https://github.com/jcwarner-usgs/COAWST.git

2. move the MCT folder to the /share/apps/MCT folder, since the installation has to be done from root

.. code-block:: bash

  $ cd COAWST/Lib
  $ sudo cp -r MCT /share/apps/MCT/2.6.0/

3. Configure

.. code-block:: bash

  $ ./configure --preffix=/share/apps/MCT/2.6.0/gcc-11.2.0

4. Enter to the Makefile.conf and modify the following lines

.. code-block:: bash

  FCFLAGS = -fPIC -fopenmp -O3 -mavx2 -fallow-argument-mismatch

.. note:: The **-fallow-argument-mismatch** is necessary since there is a function that doesn't have the correct return, if you don't include the flag the compilation will fail always

.. code-block:: bash

  ...

  REAL8 = -r8
  ...

  ENDIAN = -convert big_endian
  ...

  INCPATH = -I/share/apps/MCT/2.6.0/MCT/mpeu -I/share/apps/mpich/4.0.1/gcc-11.2.0/include
  ...

  MPILIBS = /share/apps/mpich/4.0.1/gcc-11.2.0/bin/mpif90
  ...

4. Make and make install

.. code-block:: bash

  $ make
  $ make install

Module
------

.. code-block:: tcl

  #%Module1.0#####################################################################
  ##
  ## module MCT/2.6.0_Intel_oneAPI-2022_update-1
  ##
  ## /share/apps/MCT/2.6.0/gcc-11.2.0     Written by Jacobo Monsalve Guzman
  ##

  proc ModulesHelp { } {
    puts stderr "\tcurl/7.82.0 - sets the Environment for MCT in \
    \n\tthe share directory /share/apps/MCT/2.6.0\n"
  }

  module-whatis "\n\n\tSets the environment for using MCT-2.6.0 \
               \n\tbuilded with gcc 11.2.0\n"

  # for Tcl script use only
  set       topdir     /share/apps/MCT/2.6.0/gcc-11.2.0
  set       version    2.6.0
  set       sys        x86_64-redhat-linux

  conflict MCT

  module load mpich/4.0.1_gcc-11.2.0 gcc/11.2.0

  prepend-path LD_LIBRARY_PATH    $topdir/lib
  prepend-path LIBRARY_PATH       $topdir/lib
  prepend-path LD_RUN_PATH        $topdir/lib

  prepend-path C_INCLUDE_PATH     $topdir/include
  prepend-path CXX_INCLUDE_PATH   $topdir/include
  prepend-path CPLUS_INCLUDE_PATH $topdir/include

References
----------

.. [1] https://github.com/jcwarner-usgs/COAWST/blob/master/Lib/MCT/COPYRIGHT
