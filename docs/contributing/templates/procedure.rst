.. TEMPLATE: exact steps the staff follows for an operational task.
   Ask the maintainers where it goes before writing it. Every step must
   say what to run and what you should see. Everything below is an
   example: replace it, then delete this comment.

.. _drain-a-node:

Take a node out of service for maintenance
==========================================

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

How to stop Slurm from sending new jobs to a node, without killing the
jobs already running on it.

Before you start
----------------

- You have administrator access to Slurm.
- You know the name of the node, for example ``compute-0-1``.

Steps
-----

#. Drain the node, giving the reason:

   .. code-block:: bash

      scontrol update nodename=compute-0-1 state=drain reason="disk replacement"

#. Check that it is draining:

   .. code-block:: bash

      sinfo -R

   The node appears with the reason you gave.

#. Wait until its running jobs finish. It is ready when ``sinfo`` shows it
   as ``drained``.

Undo
----

When the maintenance is over, put the node back in service:

.. code-block:: bash

   scontrol update nodename=compute-0-1 state=resume
