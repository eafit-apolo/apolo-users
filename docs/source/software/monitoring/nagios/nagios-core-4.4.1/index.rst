.. _nagios-core-4.4.1-index:

.. role:: raw-html(raw)
   :format: html

Nagios Core - 4.4.1
====================

Basic information
-----------------

- **Deploy date:** 14th August, 2018
- **Official Website:** https://www.nagios.org/about/
- **License:** Nagios Open Software License, Nagios Software License, GNU GENERAL PUBLIC LICENSE

Installation
------------

This entry covers the entire process performed for the installation and
configuration of Nagios Core in Centos 7. This process of installation and configuration
is automated using Ansible.

.. toctree::
   :maxdepth: 1

   installation

Plugins
-------

.. toctree::
   :maxdepth: 1

   plugins/ipmi-sensors
   plugins/dell-emc-openmanage
   plugins/ilo-rest
   
Usage
-----

This subsection describes how to use RAxML on a cluster and the necessary 
elements to get a good performance.

#. Before launch **RAxML** you should read next documentation


     - (*When to use which Version?*)


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


Authors
-------

- Andrés Felipe Zapata Palacio <azapat47@eafit.edu.co>
