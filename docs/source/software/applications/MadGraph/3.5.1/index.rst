.. _madgraph-3.5.1:


MADGRAPH-3.5.1
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official website:** http://madgraph.phys.ucl.ac.be/
- **Install page:** https://launchpad.net/mg5amcnlo
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 9.3.0

Installation
-------------

#. First of all, we need to download the tar.gz file

    .. code-block:: bash

        $ wget https://launchpad.net/mg5amcnlo/3.0/3.5.x/+download/MG5_aMC_v3.5.1.tar.gz

#. Then, we unpack this tar.gz file

    .. code-block:: bash

        $ tar xf MG5_aMC_v3.5.1.tar.gz

#. Then, we enter in the MadGraph directory

    .. code-block:: bash

        $ cd MG5_aMC_v3_5_1

#. Now we are ready to use MadGraph

    .. code-block:: bash

        $ ./bin/mg5_aMC

:Author:

- Juan Manuel Gómez <jmgomezp@eafit.edu.co>
