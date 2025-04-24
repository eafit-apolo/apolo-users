.. _namd-2.13-index:

.. role:: bash(code)
    :language: bash

NAMD 2.13
=========

Basic Information
-----------------

- **Deploy date:** November 9th 2018
- **Official Website:** https://www.ks.uiuc.edu/Research/namd/
- **License:** University of Illinois NAMD Mlecular Dynamics software license.
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------

This entry covers the entire process performed for the installation and
configuration of NAMD 2.13 on a cluster.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----

This section describes the method to submit jobs with the resource manager SLURM.

#. Run WRF from a SLURM bash script, for this example we will use a test case from NAMD official page `namd-tutorial-files <http://www.ks.uiuc.edu/Training/Tutorials/namd/namd-tutorial-files.tar.gz>`_

   .. code-block:: bash

      sbatch example.sh

The following code is an example for running NAMD using SLURM:

.. literalinclude:: src/example.sh
      :language: bash
      :caption: :download:`example.sh <src/example.sh>`

Authors
-------

- Vincent Alejandro Arcila Larrea <vaarcilal@eafit.edu.co>.
- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
