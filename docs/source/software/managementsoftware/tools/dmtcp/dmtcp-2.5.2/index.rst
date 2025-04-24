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

This subsection explains a method for submiting jobs to the cluster and
restarting them using DMTCP's checkpointing services.

For both types of jobs, in the SLURM launch script, load the necessary
environment including DMTCP's module. After that, source the coordinator bash
script in order to use the start_coordinator function. Remember to assing a
checkpointing interval **in seconds** with the -i flag.

The last step in both cases is launching the program in the next way.

.. code-block:: bash

   dmtcp_launch --rm <Your program binary> <args>...


For serial software
...................

.. literalinclude:: src/examples_dmtcp/serial_example/dmtcp-launch.sh
   :language: bash
   :caption: :download:`Launch script example <src/examples_dmtcp/serial_example/dmtcp-launch.sh>`

.. literalinclude:: src/examples_dmtcp/serial_example/dmtcp-restart.sh
   :language: bash
   :caption: :download:`Restart script example <src/examples_dmtcp/serial_example/dmtcp-restart.sh>`

For parallel software
.....................

In this example we run an OpenMP application. Notice that in the restart script
we don't assign again the OMP_NUM_THREADS variable again.

.. literalinclude:: src/examples_dmtcp/parallel_example/dmtcp-launch.sh
   :language: bash
   :caption: :download:`Launch script example <src/examples_dmtcp/parallel_example/dmtcp-launch.sh>`

.. literalinclude:: src/examples_dmtcp/parallel_example/dmtcp-restart.sh
   :language: bash
   :caption: :download:`Restart script example <src/examples_dmtcp/parallel_example/dmtcp-restart.sh>`

Sending commands to the coordinator
.....................................

If you want to send commands to the coordinator of a set of processes, the *start_coordinator* function you used in the script generates in your launch directory a *dmtcp_command.<job_id>* file. Using this, you can communicate with your applications currently running. You can use this to generate a manual checkpoint or to change the checkpointing interval.

Examples
^^^^^^^^

For launching a manual checkpoint use this command

.. code-block:: bash

   $JOBDIR/dmtcp_command.$JOBID -c

For changing the checkpointing interval use this command

.. code-block:: bash

   $JOBDIR/dmtcp_command.$JOBID -i <time_in_seconds>

Authors
-------

- Sebastian Patiño Barrientos <spatino6@eafit.edu.co>
