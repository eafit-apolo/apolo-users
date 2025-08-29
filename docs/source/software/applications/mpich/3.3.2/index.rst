.. _mpich-3.3.2-index:


MPICH 3.3.2
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.mpich.org/
- **Downloads page:** https://www.mpich.org/downloads
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** Intel 19.0.4

Installation
-------------

#. First of all, we need to load the following modules for the compilation

    .. code-block:: bash

        $ module load intel/19.0.4

#. Then download the tar.gz file and unpack it

    .. code-block:: bash

        $ wget http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz
        $ tar -xvf mpich-3.3.2.tar.gz
        $ cd mpich-3.3.2


#. Then we can continue with the installation

    .. code-block:: bash

        $ unset F90
        $ unset F90FLAGS
        $ ./configure CC=/share/apps/intel/ps_xe/2019_update-4/compilers_and_libraries_2019.4.243/linux/bin/intel64/icc FC=/share/apps/intel/ps_xe/2019_update-4/compilers_and_libraries_2019.4.243/linux/bin/intel64/ifort F77=/share/apps/intel/ps_xe/2019_update-4/compilers_and_libraries_2019.4.243/linux/bin/intel64/ifort CXX=/share/apps/intel/ps_xe/2019_update-4/compilers_and_libraries_2019.4.243/linux/bin/intel64/icpc --prefix=/share/apps/mpich2/3.3.2/intel-19.0.4 --build=x86_64-redhat-linux --enable-cxx --enable-fortran=all --enable-threads=multiple --with-pm=hydra --with-thread-package=posix --with-mxm=/opt/mellanox/mxm --with-slurm=/opt/slurm/18.08.1
        $ make
        $ sudo make install

.. note::

    The configure can vary on the environment you are working on. In Apolo the only way to make it function is to burn the environmental variables directly in the configure.
    Also you may need to unset F90 and F90FLAGS variables depending in your enviroment.


Author
------
 - Tomas David Navarro
 - Santigo Alzate Cardona
