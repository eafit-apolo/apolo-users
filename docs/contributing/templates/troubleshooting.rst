.. ------------------------------------------------------------------------
   TROUBLESHOOTING TEMPLATE

   Use to collect known problems and their fixes for one topic (a software
   package, the VPN, job submission). Organize by what the reader SEES,
   because that is what they will search for.

   How to use:
   1. Copy this file to its destination. For a software version, name it
      troubleshooting.rst inside the version directory; otherwise use a
      kebab-case name (for example: vpn-troubleshooting.rst). Add it to a
      toctree.
   2. Replace every [bracketed text] and YYYY-MM-DD.
   3. Copy the "Problem" section once per problem. Title each one with the
      symptom, ideally the key part of the error message.
   4. Paste error messages verbatim in a "text" block so they are
      searchable. Do not paraphrase them.
   5. Delete these comment blocks.
   ------------------------------------------------------------------------

.. _troubleshooting-replace-me:

[Topic] troubleshooting
=======================

:Authors: [Full name]
:Maintainer: [Full name]
:Last reviewed: YYYY-MM-DD
:Applies to: [Software version | cluster | service]

This page lists known problems with [topic] and how to solve them. If your
problem is not here, see `Still stuck?`_ at the end.

.. contents:: Problems on this page
   :local:
   :depth: 1

[Symptom, e.g. "error while loading shared libraries: libmpi.so.40"]
--------------------------------------------------------------------

Symptom
~~~~~~~

[When it happens: which command, at which step.]

.. code-block:: text

   [Exact error message or unexpected output]

Cause
~~~~~

[Why it happens, in one or two sentences.]

Solution
~~~~~~~~

#. [First fix step.]

   .. code-block:: bash

      [command]

#. [Confirm it is fixed.]

[Symptom of the second problem]
-------------------------------

Symptom
~~~~~~~

.. code-block:: text

   [Exact error message]

Cause
~~~~~

[Cause.]

Solution
~~~~~~~~

[Solution.]

Still stuck?
------------

If none of the above solves your problem, open an issue as described in
:ref:`report-a-bug`. Include:

- the exact command you ran and the full error message;
- the job ID, if the problem happened inside a Slurm job;
- the output of ``module list``.
