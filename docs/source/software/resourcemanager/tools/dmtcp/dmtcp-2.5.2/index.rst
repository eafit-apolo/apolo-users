.. _dmtcp-2.5.2-index:

.. role:: bash(code)
   :language: bash

DMTCP-2.5.2
===========

Basic Information
-----------------

- **Deploy date:** 3 August 2018.
- **Official Website:** http://dmtcp.sourceforge.net/
- **License:** `Lesser GNU Public License (LGPL) 
  <https://www.gnu.org/licenses/lgpl.html>`_
- **Installed on:** :ref:`Cronos <about_cronos>`
- **Supported versions:** Serial, parallel jobs

Installation
------------

This entry covers the entire process performed for the installation and
configuration of DMTCP on a cluster with the conditions described above.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----

This subsection describes a method to submit jobs to the cluster and restarting
them using DMTCP's checkpointing services.

For both types of jobs, in the SLURM launch script, load the necessary environment including DMTCP's module. After that, source the coordinator bash script in order to use the start_coordinator function. Remember to assing a checkpointing interval in seconds with the -i flag.

For serial software
...................

.. literalinclude:: src/examples_dmtcp/serial_example/dmtcp-launch.sh
   :language: bash
   :caption: :download:`Launch script example <src/examples_dmtcp/serial_example/dmtcp-launch.sh>`

.. literalinclude:: src/examples_dmtcp/serial_example/dmtcp-restart.sh
   :language: bash
   :caption: :download:`Launch script example <src/examples_dmtcp/restart_example/dmtcp-restart.sh>`
	     
For parallel software
...................

In this example we run an OpenMP application. Notice that in the restart script we don't assign again the OMP_NUM_THREADS variable again.

.. literalinclude:: src/examples_dmtcp/parallel_example/dmtcp-launch.sh
   :language: bash
   :caption: :download:`Launch script example <src/examples_dmtcp/parallel_example/dmtcp-launch.sh>`

.. literalinclude:: src/examples_dmtcp/parallel_example/dmtcp-restart.sh
   :language: bash
   :caption: :download:`Launch script example <src/examples_dmtcp/parallel_example/dmtcp-restart.sh>`

Authors
-------
- Sebastian Patiño Barrientos <spatino6@eafit.edu.co>
