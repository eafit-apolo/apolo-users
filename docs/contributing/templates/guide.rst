.. ------------------------------------------------------------------------
   GUIDE TEMPLATE

   Use to get a user through ONE concrete task as directly as possible
   ("Transfer files to Apolo", "Check how much disk you use"). If the page
   needs to teach concepts step by step, use tutorial.rst instead.

   How to use:
   1. Copy this file to its place, with a kebab-case name that starts
      with a verb (for example: transfer-files.rst), and add it to the
      toctree of the parent index.rst.
   2. Change the label below to the file name without ".rst".
   3. Replace every [bracketed text], <placeholder> and YYYY-MM-DD.
   4. Delete these comment blocks and any optional section you do not use.
   ------------------------------------------------------------------------

.. _guide-replace-me:

[Verb + object, e.g. Transfer files to and from Apolo]
======================================================

:Authors: [Full name]
:Maintainer: [Full name]
:Last reviewed: YYYY-MM-DD
:Applies to: [Apolo II | Apolo 3]

[One to three sentences: what the reader achieves with this guide and when
they need it.]

Before you start
----------------

.. What must already be true. Link the guide that gets the reader there.

- [Requirement, e.g. You are connected to the VPN.]

[First task or option, e.g. Copy a file with scp]
-------------------------------------------------

.. One section per way of doing the task, most common first. Inside each,
   numbered steps, one action per step.

#. [Action.]

   .. code-block:: bash

      [command with <placeholders>]

   Replace ``<placeholder>`` with [explanation].

#. [Action.]

[Second option]
---------------

[Steps.]

Check that it worked
--------------------

.. Optional. How the reader confirms the result.

.. code-block:: console

   $ [command]
   [expected output]

If something goes wrong
-----------------------

.. Optional. The two or three most likely problems, or a link to a
   troubleshooting page.

- **[Symptom].** [Fix.]

See also
--------

.. Related guides and reference pages, by label, e.g. - :ref:`report-a-bug`

- [Related page]
