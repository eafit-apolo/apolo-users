.. _gromacs-2016.4-index:

.. role:: bash(code)
   :language: bash

GROMACS 2016.4
===========================

- **Installation Date:** 31/01/2018
-  **URL:** http://www.gromacs.org/
- - **Installed on:** Cronos
- **License:** GNU Lesser General Public License (LGPL), version 2.1.

.. contents:: Table of Contents

Dependencies
------------

- GNU GCC >= 5.5.0
- OpenMPI >= 2.1.2
- Fftw >= 3.3.7
- Cmake >= 3.3
- OpenBlas >= 0.2.20

Installation
------------

After resolving the aforementioned dependencies, you can proceed with the installation of GROMACS.

#. Download the latest version of GROMACS [1]_

   .. code-block:: bash

      $ wget http://ftp.gromacs.org/pub/gromacs/gromacs-2016.4.tar.gz
      $ tar -xzvf gromacs-2016.4

#. After unpacking GROMACS, we continue with the following configuration and compilation steps:

    .. note:: You have to load all the apps in the dependencies, or add them to the PATH, we are assuming that all is done

   .. code-block:: bash

        $ cd gromacs-2016.4
        $ mkdir build
        $ cd build
        $ cmake .. -DCMAKE_INSTALL_PREFIX=/share/apps/gromacs/2016.4 -DREGRESSIONTEST_DOWNLOAD=ON
            -DFFTWF_INCLUDE_DIR=/share/apps/fftw/3.3.7/gcc-5.5.0/  -DCMAKE_PREFIX_PATH=/share/apps/openblas/
            -DGMX_EXTERNAL_BLAS=ON | tee cmake.log
        $ make -j4 | tee make.log
        $ make check
        $ make install

References
----------

.. [1] Gromacs downloads.
        Retrieved January 31, 2018,  from http://manual.gromacs.org/documentation/2016.4/download.html

Authors
-------

- Juan David Arcila-Moreno
