.. _bayescan-2.1-index:

.. role:: raw-html(raw)
    :format: html

BayeScan - 2.1
===============

Basic information
-----------------

- **Deploy date:** 23 July 2018
- **Official Website:** http://cmpg.unibe.ch/software/BayeScan/index.html
- **License:** GNU General Public License
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

.. code-block:: bash
		
   module load bayescan
   bayescan -h

Performance Tests
-----------------
The following test were performed using a single compute-node in **Cronos**.
We were comparing the build-in version and our compiled version described
in this entry. As input, we use one the included files of **BayeScan** source

Sbatch Script for intel-compiled version:

.. literalinclude:: src/sbatch
     :language: bash
     :caption: :download:`sbatch <src/sbatch>`


The build-in version were executed using the full-path to the build-in binaries
and with the same arguments.

.. note::
     As you can see in the sbatch script, the time was calculated using ``time`` command.
     See man for more information.
   
+------------------------------------------------------+
|                      **Results**                     |
+==================+===================================+
|        x         |                Time               |
+------------------+----------+------------+-----------+
| Compiled Version |   Real   |    User    |    Sys    |
+------------------+----------+------------+-----------+
| Build-in         | 7m3.124s | 46m39.444s | 6m46.893s |
+------------------+----------+------------+-----------+
| Intel            | 2m8.054s | 33m26.063s | 0m42.262s |
+------------------+----------+------------+-----------+
|  **change**      | 99.970%  | 28.341%    | 89.613%   |
+------------------+----------+------------+-----------+

Authors
-------

- Juan David Arcila-Moreno <jarcil13@eafit.edu.co>
		       
