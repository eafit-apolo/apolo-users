.. _gatk4-4.1.0.0-index:

.. role:: bash(code)
    :language: bash

GATK4-4.1.0.0
=============

.. contents:: Table of Contents

Basic Information
-----------------

- **Deploy date:** 2 January 2019
- **Official Website:** https://software.broadinstitute.org/gatk/documentation/quickstart
- **License:** `GATK4 License <https://github.com/broadinstitute/gatk/blob/master/LICENSE.TXT>`_
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------

This entry covers the entire process performed for the installation GATK4
on a cluster.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----
This section describes the method to submit jobs with the resource manager SLURM.

#. Load the necessary environment.

   .. code-block:: bash

      module load gatk4/4.1.0.0

#. Run GATK4 with SLURM.

   An example:

   For this example, we use the GATK tutorial `Run the Pathseq pipeline <https://gatkforums.broadinstitute.org/gatk/discussion/10913/how-to-run-the-pathseq-pipeline>`_

   .. literalinclude:: src/gatk4.sh
      :language: bash
      :caption: :download:`gatk.sh <src/gatk4.sh>`

   .. note::

         If you want to run some tests, go to the `GATK4 page with tutorials <https://software.broadinstitute.org/gatk/documentation/topic?name=tutorials>`_.

Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
