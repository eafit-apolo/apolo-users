.. _MODFLOW-6.4.4:


MODFLOW 6.4.4
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.usgs.gov/software/modflow-6-usgs-modular-hydrologic-model
- **Downloads page:** https://github.com/MODFLOW-USGS/modflow6/releases/tag/6.5.0
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 9.3.0

Installation
-------------

#. First of all, download the zip file

    .. code-block:: bash

        $ wget https://github.com/MODFLOW-USGS/modflow6/releases/download/6.4.4/mf6.4.4_linux.zip

#. Then, we need to unpack this zip file

    .. code-block:: bash

        $ unzip mf6.4.4_linux.zip


#. Then, we enter in the mdf6.4.4 directory

    .. code-block:: bash

        $ cd mdf6.4.4

#. Now we are ready to use MODFLOW.

    .. code-block:: bash

        $ ./bin/mdf6

:Author:

 - Juan Manuel Gómez <jmgomezp@eafit.edu.co>