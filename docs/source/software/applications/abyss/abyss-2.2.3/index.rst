.. abyss-2.2.3:

ABySS 2.2.3
===========

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** http://www.bcgsc.ca/platform/bioinfo/software/abyss
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`
- **Dependencies:**
    - C++ compiler that supports OpenMP such as GCC.
    - Boost
    - Open MPI
    - sparsehash

Installation
------------

To compile it we used `Intel 19.0.4 <https://software.intel.com/en-us/articles/intel-c-compiler-190-for-linux-release-notes-for-intel-parallel-studio-xe-2019>`_.
This entry covers the entire process performed in the installation and test of 
**EDGE-pro** on a cluster with the conditions described below. It is worth 
mentioning that this application does not meet the Linux Directory Hierarchy 
Standard, so we change the directory structure to make it work with ``modules``,
``Slurm``, and other subsystems.

As a side note, the performance of **EDGE-pro** depends directly on the 
**bowtie**'s performance, so we suggest making a different tuning compilation of it. 

      	
Usage
-----
In the following example we are going to run a test included in the source code
of **EDGE-pro**. Note that we are using one single compute-node. Bowtie will be 
using ``OpenMP`` with 16 and 32 threads, in Cronos and Apolo, respectively. 

**Apolo**


     
To run the previous example.

.. code-block:: bash

	sbatch slurm_edge_pro_[apolo|cronos].sh

.. note::

    As you can notice in the previous examples we are using the flag ``-s``.
    This is because we must specify to **EDGE_pro** where is the directory 
    that contains: the built executable, the binaries of ``bowtie2`` and 
    additional scripts.

.. note::

     In this example we are using the default version of **EDGE-pro**
     module. We recommend to specify the version. To use the
     version of this entry, pleace load the module as follow: 
      

      In Apolo II:

      .. code-block:: bash

	 module load edge_pro/1.3.1_intel-2017_update-1

      In Cronos:

      .. code-block:: bash

	 module load edge_pro/1.3.1_intel-18.0.2

Authors
-------

- Juan David Arcila-Moreno <jarcil13@eafit.edu.co>