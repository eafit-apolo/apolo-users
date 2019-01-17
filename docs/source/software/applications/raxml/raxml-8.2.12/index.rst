.. _raxml-8.2.12-index:

.. role:: raw-html(raw)
   :format: html

RAxML - 8.2.12
==============

Basic information
-----------------

- **Deploy date:** 2 August 2018
- **Official Website:** https://sco.h-its.org/exelixis/web/software/raxml/
- **License:** GNU GENERAL PUBLIC LICENSE - Version 3 (GPL 3.0), 29 June 2007
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`
- **Available versions:** Hybrid (MPI and Threads), MPI


Installation
------------

This entry covers the entire process performed for the installation and
configuration of RAxML on a cluster with the conditions described below.

.. toctree::
   :maxdepth: 1

   installation

Usage
-----

This subsection describes how to use RAxML on a cluster and the necessary
elements to get a good performance.

#. Before launch **RAxML** you should read next documentation

   - :download:`The RAxML v8.2.X Manual (Mandatory) * <doc/official-manual-8.2.x.pdf>`

     - (*When to use which Version?*)

   - :download:`Hybrid Parallelization of the MrBayes & RAxML Phylogenetics
     Codes <doc/presentation.pdf>`

     - (*Hybrid MPI/Pthreads*)


   .. note::

      It is really important to understand how the *HYBRID* version works, since
      this is the only available version for HPC scenarios. Additionally,
      understanding the behavior of the *HYBRID* version is the key to properly
      use the computational resources and achieve better performance.

#. In the following example we will run 100 bootstrap replicates
   (MPI parallelization) and independent tree searches
   (PThreads - shared memory) for each bootstrap replicate, all of this using
   SLURM (Resource Manager) to spawn properly the processes across the
   nodes.


   .. literalinclude:: src/slurm.sh
      :language: bash
      :caption: :download:`slurm.sh <src/slurm.sh>`


   .. note::

      Node quick specs (Apolo II): 32 Cores, 64 GB RAM

        - *- -ntasks-per-node* :raw-html:`&rarr;` MPI process per node
        - *- -cpus-per-task* :raw-html:`&rarr;` PThreads per MPI process
        - *- -nodes* :raw-html:`&rarr;` Number of nodes

      In this case, we will use 2 MPI process per node and each MPI process has
      16 PThreads; for a total of 32 processes per node.
      Also we will use 3 nodes.

References
----------

- `The RAxML v8.2.X Manual,  Alexandros Stamatakis Heidelberg Institute for
  Theoretical Studies, July 20, 2016
  <https://sco.h-its.org/exelixis/php/countManualNew.php>`_

Authors
-------

- Mateo Gómez-Zuluaga <mgomezz@eafit.edu.co>
