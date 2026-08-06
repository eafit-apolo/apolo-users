.. _qiime-2024.5-index:

.. role:: bash(code)
   :language: bash

Qiime2 Metagenome Distribution 2024.5
=============

Basic Information
-----------------

- **Deploy date:** 11 October 2024
- **Official Website:** https://docs.qiime2.org
- **License:** BSD 3-Clause License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,

Installation
------------

Tested on (Requirements)
""""""""""""""""""""""""

- **OS base:** Rocky Linux (x86_64) :math:`\boldsymbol{\ge}` 8
- Python :math:`\boldsymbol{\ge}` 3.9 (Miniconda)

Build process
"""""""""""""

This entry described the installation process of Qiime2 Metagenome Distribution in a Conda environment.

#. Load the python module with conda.

   .. code-block:: bash

      module load python

#. Download the dependencies file for your Qiime version, in this example
   we download the 2024.5 version.

   .. code-block:: bash

      wget https://data.qiime2.org/distro/metagenome/qiime2-metagenome-2024.5-py39-linux-conda.yml

#. Create the environment.

   .. note::

      It's highly recommend creating a new environment for each version of QIIME 2
      release being installed.

   .. code-block:: bash

      conda env create -n qiime2-metagenome-2024.5 --file qiime2-metagenome-2024.5-py39-linux-conda.yml

Testing
"""""""
#. Load the python module with conda.

   .. code-block:: bash

      module load python

#. Activate the conda environment :bash:`source activate <environment-name>`,
   this example we use the qiime2-amplicon-2024.5 environment.

   .. code-block:: bash

      source activate qiime2-metagenome-2024.5

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
   qiime2 `documentation <https://docs.qiime2.org/2024.5/plugins/>`_

Authors
-------

- Isis Catitza Amaya Arbelaez <icamayaa@eafit.edu.co>
