.. _mothur-1.42.3-index:

.. role:: bash(code)
    :language: bash

Mothur 1.42.3
=============

Basic Information
-----------------

- **Deploy date:** 24 January 2019
- **Official Website:** https://www.mothur.org
- **License:** GNU General Public License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------

This entry covers the entire process performed for the installation and
configuration of Mothur.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----
This section describes the method to submit jobs with the resource manager SLURM.

#. Load the necessary environment.

   .. code-block:: bash

      module load mothur/1.42.1_intel-2017_update-1

#. Run Mothur with SLURM.

    An example with `AmazonData.zip <https://www.mothur.org/w/images/3/37/AmazonData.zip>`_:

    .. literalinclude:: src/mothur.sh
      :language: bash
      :caption: :download:`mothur.sh <src/mothur.sh>`


Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
