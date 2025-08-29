.. _mpich-3.4.2:


MPICH 3.4.2
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.mpich.org/
- **Downloads page:** https://www.mpich.org/downloads
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 9.3.0

.. note::
   This version of MPICH is recommended for WRFCMAQ

Installation
-------------

#. First of all, we need to load the following modules for the compilation

    .. code-block:: bash

        $ module load intel/2022_oneAPI-update1

#. Then download the tar.gz file and unpack it

    .. code-block:: bash

        $ wget https://www.mpich.org/static/downloads/3.4.2/mpich-3.4.2.tar.gz
        $ tar -xvf mpich-3.4.2.tar.gz
        $ cd mpich-3.4.2


#. Then we can continue with the installation

    .. code-block:: bash

        $ unset F90
        $ unset F90FLAGS
        $ ./configure CC=/share/apps/gcc/9.3.0/bin/gcc FC=/share/apps/gcc/9.3.0/bin/gfortran F77=/share/apps/gcc/9.3.0/bin/gfortran --prefix=/share/apps/mpich/3.4.2/gcc-9.3.0 --with-device=ch3
        $ make
        $ sudo make install

.. note::

    The configure can vary on the environment you are working on. In Apolo the only way to make it function is to burn the environmental variables directly in the configure.
    Also you may need to unset F90 and F90FLAGS variables depending in your enviroment.


:Author:

 - Bryan López Parra <blopezp@eafit.edu.co>
