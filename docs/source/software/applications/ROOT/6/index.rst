.. _ROOT-6:


ROOT 6
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://root.cern/
- **Install page:** https://root.cern/install/
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 9.3.0

Installation
-------------

#. First of all, we need to load the following module for the compilation

    .. code-block:: bash

        $ module load python/3.9_miniconda-4.10.3

#. Then, we create a conda environment

    .. code-block:: bash

        $ conda config --set channel_priority strict
        $ conda create -c conda-forge --name <my-environment> root

.. note::

    Replace <my-environment> for a proper name for the environment.

#. Then, we activate the environment in order to use ROOT

    .. code-block:: bash

        $ conda activate <my-environment>

#. Now we are ready to use ROOT.

    .. code-block:: bash

        $ root

.. note::

    Always that we want to use ROOT, we must activate the environment.

:Author:

- Juan Manuel Gómez <jmgomezp@eafit.edu.co>
