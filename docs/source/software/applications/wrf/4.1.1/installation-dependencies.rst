.. _wrf-4.1.1-installation-dependencies:

.. role:: bash(code)
    :language: bash

.. role:: raw-html(raw)
    :format: html

WRF 4.1.1 Dependencies
======================

Basic Information
-----------------

- **Deploy date:** June 2020
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Compiler:** Intel :math:`\boldsymbol{\ge}` 19.0.4

Installation
------------

This entry covers the entire process performed for the installation and
configuration of all WRF 4.1.1 dependencies on a cluster with an Intel compiler. **FOLLOW THE ORDER**

#. Export the following environmental variables.

    .. code-block:: bash

        export CFLAGS='-O3 -xHost -ip -no-prec-div -static-intel'
        export CXXFLAGS='-O3 -xHost -ip -no-prec-div -static-intel'
        export FFLAGS='-O3 -xHost -ip -no-prec-div -static-intel'
        export CPP='icc -E'
        export CXXCPP='icpc -E'
        export FC='ifort -E'
        export F77='ifort -E'


#. Follow this guide to install zlib correctly :ref:`Zlib-1.2.11-intel`.

#. Follow this guide to install szip correctly :ref:`Szip-2.1.1-intel`.

#. Follow this guide to install netcdf-c correctly :ref:`NetCDF-4.7.4-index`.

#. Follow this guide to install mpich correctly :ref:`mpich-3.3.2-index`.

#. Follow this guide to install netcdf-fortran correctly :ref:`NetCDF-fortran-4.5.3-index`.

#. Follow this guide to install Jasper correctly :ref:`Jasper-1.900.1-intel`.

#. After you have installed all the dependencies above correctly, you may proceed with the WRF Installation Guide.

:Authors:

- Tomas Navarro <tdnavarrom@eafit.edu.co>
- Satiago Alzate <salzatec1@eafit.edu.co>
