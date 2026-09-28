.. ------------------------------------------------------------------------
   PROCEDURE TEMPLATE

   Use for an operational task that must be carried out the same way every
   time (creating an account, rotating a license, draining a node).
   Audience: someone who knows the context and needs the exact steps.

   How to use:
   1. Copy this file to its destination, named in kebab-case
      (for example: create-user-account.rst) and add it to a toctree.
   2. Replace every [bracketed text] and YYYY-MM-DD.
   3. Delete these comment blocks and any optional section you do not use.
   ------------------------------------------------------------------------

.. _procedure-replace-me:

[Verb + object, e.g. Create a user account]
===========================================

:Authors: [Full name]
:Maintainer: [Full name]
:Last reviewed: YYYY-MM-DD
:Applies to: [Apolo II | Apolo 3]

[One to three sentences: what this procedure achieves and when to run it.]

.. contents:: On this page
   :local:
   :depth: 1

Purpose
-------

[Why this procedure exists and what outcome it guarantees.]

Scope
-----

[What this procedure covers and, just as important, what it does not.]

Roles
-----

.. List who does what. Use roles, and name the person only if there is
   exactly one.

- **Executor:** [role that carries out the steps]
- **Approver:** [role that must authorize it, if any]

Prerequisites
-------------

.. Everything that must be true before step 1: access, tools, approvals,
   information to have at hand.

- [Access or permission required]
- [Information or ticket required]

Procedure
---------

.. One action per step. Put the command directly under the step and state
   the expected result whenever it is not obvious.

#. [First action.]

   .. code-block:: bash

      [command]

   Expected result: [what the executor should see].

#. [Second action.]

   .. code-block:: bash

      [command]

#. [Third action.]

Verification
------------

[How to confirm that the procedure succeeded.]

.. code-block:: console

   $ [verification command]
   [expected output]

Rollback
--------

.. Optional. How to undo the procedure if verification fails. Delete this
   section if the procedure changes nothing that can be undone.

#. [Undo step.]

See also
--------

.. Link related pages by label, e.g. - :ref:`report-a-bug`

- [Related page]
