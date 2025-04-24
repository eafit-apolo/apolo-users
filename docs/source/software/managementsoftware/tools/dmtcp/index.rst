.. _dmtcp-index:

DMTCP
=====

DMTCP (Distributed MultiThreaded Checkpointing) transparently checkpoints a
single-host or distributed computation in user-space with no modifications to
user code or to the O/S. It works on most Linux applications, including Python,
Matlab, R, etc. [1]_

.. Warning::

   The current Apolo implementation only offers checkpointing support to serial
   and parallel programs. It isn't compatible with distributed programs like
   those based on MPI.

.. toctree::
   :caption: Versions
   :maxdepth: 1

   dmtcp-2.5.2/index

.. [1] DMTCP: Distributed MultiThreaded CheckPointing. (n.d.).
       Retrieved from http://dmtcp.sourceforge.net/
