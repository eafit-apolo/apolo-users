.. ------------------------------------------------------------------------
   POLICY TEMPLATE

   Use for a rule that users or staff must follow (acceptable use, storage
   quotas, data retention, account lifecycle). A policy states WHAT must
   happen and WHO is responsible; the HOW goes in a separate procedure page
   linked from here.

   How to use:
   1. Copy this file to its destination, named in kebab-case
      (for example: storage-quota-policy.rst) and add it to a toctree.
   2. Replace every [bracketed text] and YYYY-MM-DD.
   3. Write each rule with "must", "should" or "may" (section 2 of
      docs/contributing/style-guide.md) and number it so it can be cited.
   4. Every change to the rules bumps Version, updates Effective date and
      adds a row to Revision history.
   5. Delete these comment blocks.
   ------------------------------------------------------------------------

.. _policy-replace-me:

[Policy name, e.g. Storage quota policy]
========================================

:Authors: [Full name]
:Maintainer: [Full name]
:Last reviewed: YYYY-MM-DD
:Version: 1.0
:Effective date: YYYY-MM-DD
:Approved by: [Full name, role]
:Applies to: [All Apolo users | staff | cluster]

[One to three sentences summarizing the rule and who it affects.]

.. contents:: On this page
   :local:
   :depth: 1

Purpose
-------

[Why the policy exists: the risk it prevents or the goal it serves.]

Scope
-----

This policy applies to [who and what]. It does not apply to [exclusions].

Definitions
-----------

.. Define every term a reader could interpret differently. Delete the
   section if there are none.

[Term]
   [Definition.]

[Term]
   [Definition.]

Policy
------

.. Number the rules as P1, P2... so they can be cited unambiguously
   ("see P3 of the storage quota policy"). Never renumber existing rules;
   retire them instead.

P1
   [Rule, using must / should / may.]

P2
   [Rule.]

P3
   [Rule.]

Responsibilities
----------------

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Role
     - Responsibility
   * - [Users]
     - [What they must do.]
   * - [Apolo staff]
     - [What they must do.]

Exceptions
----------

[How to request an exception, who can grant it and for how long.]

Compliance
----------

[How compliance is checked and what happens when the policy is not
followed.]

Related documents
-----------------

.. Link the procedures that implement this policy, e.g.
   - :ref:`report-a-bug`

- [Related procedure or policy]

Revision history
----------------

.. Newest version first.

.. list-table::
   :header-rows: 1
   :widths: 15 20 65

   * - Version
     - Date
     - Changes
   * - 1.0
     - YYYY-MM-DD
     - Initial version.
