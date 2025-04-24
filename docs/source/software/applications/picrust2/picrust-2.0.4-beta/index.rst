.. _picrust-2.0.4-beta-index:

PICRUSt 2.0.4-BETA
==================
.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/picrust/picrust2/wiki
- **License:** GNU General Public License v3.0
- **Tested on** CentOS (x86_64) ≥ 6.6 (Rocks 6.2)

Installation
------------

   .. note:: Official installation instructions can be found in https://github.com/picrust/picrust2/blob/master/INSTALL.md.

You should follow the following procedure in order to install this software on a conda environment, without root privileges.

#. Load conda module. On :ref:`Apolo II <about_apolo-ii>` is python/3.6.5_miniconda-4.5.1, on :ref:`Cronos <about_cronos>` python/3.6.5_miniconda-4.5.4.

   .. code-block:: bash

          $ module load <conda_module>

   .. note:: Be aware you can also try out the intel optimized conda modules, which are proved to increase performance in several applications: on :ref:`Apolo II <about_apolo-ii>` is python/3.5.2_intel-2017_update-1, on :ref:`Cronos <about_cronos>` is python/3.6.2_intel-18_u1.

#. Clone PICRUSt2 repository and cd into it:


   .. code-block:: bash

          $ git clone https://github.com/picrust/picrust2.git
          $ cd picrust2

   .. note:: All the following commands should be executed inside the "picrust2" directory!.

#. Install the required dependencies into a conda environment. This will create a conda environment named picrust2 in which the dependencies will be installed:



   .. code-block:: bash

          $ conda env create -f picrust2-env.yaml

#. Activate the conda environment and finish installing PICRUSt2:


   .. code-block:: bash

          $ source activate picrust2
          $ pip install --no-deps --editable .

#. Finally, test the installation.


   .. code-block:: bash

          $ pytest

Authors
-------

- Vincent Alejandro Arcila Larrea (vaarcilal@eafit.edu.co).
