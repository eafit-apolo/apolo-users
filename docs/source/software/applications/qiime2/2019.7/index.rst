.. _qiime-2019.7-index:

.. role:: bash(code)
    :language: bash

Qiime2 2019.7
=============

Basic Information
-----------------

- **Deploy date:** 30 July 2019
- **Official Website:** https://docs.qiime2.org
- **License:** BSD 3-Clause License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`

Installation
------------

Tested on (Requirements)
""""""""""""""""""""""""

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- Python :math:`\boldsymbol{\ge}` 2.7

Build process
"""""""""""""

This entry described the installation process of Qiime2 in a Conda environment.

#. Download the dependencies file for your Qiime version, in this example
   we download the 2019.7 version.

   .. code-block:: bash

      wget https://data.qiime2.org/distro/core/qiime2-2019.7-py36-linux-conda.yml

#. Create the environment.

   .. note::

      It's highly recommend creating a new environment for each version of QIIME 2
      release being installed.

   .. code-block:: bash

      conda env create -n qiime2-2019.7 --file qiime2-2019.7-py36-linux-conda.yml

Testing
"""""""
#. Load the python module with conda.

   .. code-block:: bash

      module load python

#. Activate the conda environment :bash:`source activate <environment-name>`,
   this example we use the qiimw2-2019.7 environment.

   .. code-block:: bash

      source activate qiime2-2019.7

#. Run a simple command.

   .. code-block:: bash

      qiime --help

Usage
-----

This section describes the method to submit jobs with the resource manager SLURM.

.. literalinclude:: src/slurm.sh
      :language: bash
      :caption: :download:`slurm.sh <src/slurm.sh>`

.. note::

   For more information about plugins, read the
   qiime2 `documentation <https://docs.qiime2.org/2019.7/plugins/>`_

Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
