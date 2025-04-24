.. _partFinder-2.1.1-index:

.. role:: bash(code)
    :language: bash

Partition Finder 2.1.1
======================

Basic Information
-----------------

- **Deploy date:** 5 December 2016
- **Official Website:** http://www.robertlanfear.com/partitionfinder/
- **License:** GNU General Public License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------

This entry covers the entire process performed for the installation and
configuration of Partition Finder in a Cluster with Conda.

#. Create a Conda Environment for Partition Finder

.. code-block:: bash

   conda create -n partitionFinder

#. Install the following dependencies (numpy, pandas, pytables, pyparsing, scipy, and sklearn).

.. code-block:: bash

   conda install numpy pandas pytables pyparsing scipy scikit-learn

#. Download the latest version of Partition Finder and decompress it.

.. code-block:: bash

   wget https://github.com/brettc/partitionfinder/archive/v2.1.1.tar.gz
   tar xfz v2.1.1.tar.gz

#. Move it to wherever you want to store and give it execution permissions.

.. code-block:: bash

   mv partitionfinder-2.1.1 /path/to/partition/finder
   chmod +x partitionfinder-2.1.1/PartitionFinder.py

Usage
-----

This section describes the method to submit jobs with the resource manager SLURM.

.. note::

   If it is the first time you need Partition Finder or you want to use it locally,
   you should create and load the environment.

   :bash:`conda env create -f partitionFinder.yml`

   .. literalinclude:: src/partitionFinder.yml
      :language: yaml
      :caption: :download:`Partition Finder environment <src/partitionFinder.yml>`

#. Run SLURM with the following bash file.

   .. code-block:: bash

      sbatch partitionFinder.sh

   .. literalinclude:: src/partitionFinder.sh
      :language: tcl
      :caption: :download:`Partition Finder SLURM <src/partitionFinder.sh>`

Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
