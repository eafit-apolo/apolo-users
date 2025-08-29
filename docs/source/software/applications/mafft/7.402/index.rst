.. _mafft-7.402-index:

.. role:: bash(code)
    :language: bash

.. role:: raw-html(raw)
    :format: html

MAFFT-7.402
===========

Basic Information
-----------------

- **Deploy date:** 27 July 2018
- **Official Website:** https://mafft.cbrc.jp/alignment/software/
- **License:** BSD License

  - **Extensions:**

    - **Mxcarna:** BSD License (For more information check README file in :bash:`mafft-7.402-with-extensions/extensions/mxscarna_src/`
    - **Foldalign:** GNU GPL-2
    - **Contrafold:** BSD License

- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`

Installation
------------

This entry covers the entire process performed for the installation and configuration of MAFFT with extensions (MXSCARNA, Foldalign and CONTRAfold) on a cluster.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----

This section describes the method to submit jobs with the resource manager SLURM.

#. Load the necessary environment.

   .. code-block:: bash

      module load mafft/7.402-with-extensions_intel-X.X.X

   .. note::

      Remember to load the proper environment for Cronos or Apolo

      * Apolo

    * :bash:`module load mafft/7.402-with-extensions_intel-17.0.1`

      * Cronos

    * :bash:`module load mafft/7.402-with-extensions_intel-18.0.2`

#. Run MAFFT with SLURM.

   An example:

   .. note::

      This example was tested with :download:`example.fa <src/example.fa>` that contains unlined DNA secuences.

   .. literalinclude:: src/mafft.sh
      :language: bash
      :caption: :download:`mafft.sh <src/mafft.sh>`


   **Options**

   - ``quiet`` :raw-html:`&rarr;` Do not report progress and this flag is mandatory to run unattended jobs.
   - ``auto`` :raw-html:`&rarr;` Automatically selects an appropriate strategy from L-INS-i, FFT-NS-i and FFT-NS-2, according to data size.
   - ``thread`` :raw-html:`&rarr;` Number of threads (number of cores reserved on SLURM).


   .. note::

      For more information, please read the manual entry for Mafft :bash:`man mafft` or :bash:`mafft -h`


Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
