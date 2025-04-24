.. _wrf-3.7-index:

.. role:: bash(code)
    :language: bash

.. role:: raw-html(raw)
    :format: html

WRF 3.7
=======

Basic Information
-----------------

- **Deploy date:** April 2015
- **Official Website:** https://www.mmm.ucar.edu/weather-research-and-forecasting-model
- **License:**
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------

This entry covers the entire process performed for the installation and
configuration of WRF 3.7 on a cluster.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----

This section describes the method to submit jobs with the resource manager SLURM.

#. Run WRF from a SLURM bash script, for this example we will use a test case
in :bash:`wrf-3.7/tests/em_real`

   .. code-block:: bash

      sbatch example.sh

The following code is an example for running WRF using SLURM:

.. literalinclude:: src/example.sh
      :language: bash
      :caption: :download:`example.sh <src/example.sh>`

Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
