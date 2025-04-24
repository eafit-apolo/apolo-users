.. _bayescan-2.1-index:

.. role:: raw-html(raw)
    :format: html

BayeScan - 2.1
===============

.. contents:: Table of Contents

Basic information
-----------------

- **Deploy date:** 23 July 2018
- **Official Website:** http://cmpg.unibe.ch/software/BayeScan/index.html
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`
- **Available versions:** OpenMP

Installation
------------

This entry covers the entire process performed in the installation
and test of **BayeScan** on a cluster with the conditions described below.

.. toctree::
   :maxdepth: 1

   installation

Usage
-----
In the following example we are going to run a test included in the source code
of **BayeSacan**. Note that we are using one single compute-node, with 16
threads.

.. literalinclude:: src/bayescan_run.sh
       :language: bash
       :caption: :download:`slurm.sh <src/bayescan_run.sh>`

To run the previous example.

.. code-block:: bash

   sbatch bayescan_run.sh

.. note::

     In this example we are using the default version of **BayeScan**
     module. We recommend to specify the version. To use the
     version of this entry, pleace load the module as follow:


      In Apolo II:

      .. code-block:: bash

	 module load bayescan/2.1_intel-2017_update-1

      In Cronos:

      .. code-block:: bash

	 module load bayescan/2.1_intel-18.0.2



Performance Tests
-----------------
The following test was performed in :ref:`Cronos <about_cronos>`.
We were comparing the build-in version and our builded version described in this
entry. As input, we use one of the included tests of **BayeScan** source.

sbatch script for build-in version test:

.. literalinclude:: src/sbatch
     :language: bash


The test for our **builded version** was executed by the example provided in
`Usage`_ section of this entry.

.. note::
    As you can see in the sbatch script, the time was calculated using
    ``time`` command.

**Results**

+------------------+-----------------------------------+
|     Compiled     |                Time               |
|     version      |                                   |
+------------------+----------+------------+-----------+
|                  |   Real   |    User    |    Sys    |
+------------------+----------+------------+-----------+
| Build-in         | 7m3.124s | 46m39.444s | 6m46.893s |
+------------------+----------+------------+-----------+
| Intel (icmp)     | 2m8.054s | 33m26.063s | 0m42.262s |
+------------------+----------+------------+-----------+
| **change**       | 99.970%  | 28.341%    | 89.613%   |
+------------------+----------+------------+-----------+

Authors
-------

- Juan David Arcila-Moreno <jarcil13@eafit.edu.co>
