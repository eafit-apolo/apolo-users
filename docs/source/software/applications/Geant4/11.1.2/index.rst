.. _Geant4-11.1.2:


GEANT4 11.1.2
==============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://geant4.web.cern.ch/
- **Downloads page:** https://geant4.web.cern.ch/download/
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 9.3.0

Installation
-------------

#. First of all, we need to load the following modules for the compilation

    .. code-block:: bash

        $ module load cmake-3.22.2-gcc-9.3.0-paiswui expat-2.4.6-gcc-9.3.0-nlngbc3 gcc/9.3.0 mpich/4.1_gcc-9.3.0

#. Then, download the tar.gz file and unpack it

    .. code-block:: bash

        $ wget https://gitlab.cern.ch/geant4/geant4/-/archive/v11.1.2/geant4-v11.1.2.tar.gz
        $ tar -xvf geant4-v11.1.2.tar.gz

#. Then, we create two directories in the same location than we unpack the tar.gz file, one for build and the other for install

    .. code-block:: bash

        $ mkdir build_geant4 install_geant4


#. Then we can continue with the installation

    .. code-block:: bash

        $ cd build_geant4
        $ cmake -DCMAKE_INSTALL_PREFIX=../install -DGEANT4_BUILD_MULTITHREADED=ON ../geant4-v11.1.2/
        $ make -j 8
        $ make install

.. note::

    There is another flag for the cmake command, this flag is -DGEANT4_INSTALL_DATA. This flag for default is OFF and thanks to the firewall
    of the University, this flag doesn't work, because it uses a protocol that this firewall doesn't allow. But you are free to try.

#. Now, if we need to use the data, we must install this manually as follows

    .. code-block:: bash

        $ cd ../install_geant4/share/Geant4
        $ mkdir data
        $ cd data

#. Then, we download the tar.gz files and unpack it

    .. code-block:: bash

        $ wget https://cern.ch/geant4-data/datasets/G4NDL.4.7.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4EMLOW.8.2.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4PhotonEvaporation.5.7.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4RadioactiveDecay.5.6.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4PARTICLEXS.4.0.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4PII.1.3.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4RealSurface.2.2.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4SAIDDATA.2.0.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4ABLA.3.1.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4INCL.1.0.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4ENSDFSTATE.2.3.tar.gz
        $ wget https://cern.ch/geant4-data/datasets/G4TENDL.1.4.tar.gz
        $ tar xf G4ABLA.3.1.tar.gz
        $ tar xf G4EMLOW.8.2.tar.gz
        $ tar xf G4ENSDFSTATE.2.3.tar.gz
        $ tar xf G4INCL.1.0.tar.gz
        $ tar xf G4NDL.4.7.tar.gz
        $ tar xf G4PARTICLEXS.4.0.tar.gz
        $ tar xf G4PII.1.3.tar.gz
        $ tar xf G4RadioactiveDecay.5.6.tar.gz
        $ tar xf G4RealSurface.2.2.tar.gz
        $ tar xf G4SAIDDATA.2.0.tar.gz
        $ tar xf G4TENDL.1.4.tar.gz

.. note::

    This process is very slow, so you must be patient.

#. Then, we must modify one file to use this data

    .. code-block:: bash

        $ cd ../../../bin/
        $ vim geant4.sh

#. Now, we modify lines 70 - 80 (delete '#' to uncommon these lines). Then, we exit from vim and execute this file

    .. code-block:: bash

        $ ./geant4.sh

#. Now we are ready to use Geant4.

:Author:

 - Juan Manuel Gómez <jmgomezp@eafit.edu.co>
