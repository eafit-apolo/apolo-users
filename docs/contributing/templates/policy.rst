.. TEMPLATE: a rule users or staff must follow.
   Ask the maintainers where it goes before writing it. Number the rules
   (P1, P2…) so they can be cited, and use "must", "should" or "may".
   Everything below is an example: replace it, then delete this comment.

.. _login-node-policy:

Use of the login nodes
======================

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Version: 1.0
:Effective date: 2026-10-01
:Approved by: John Roe, Apolo coordinator
:Applies to: All Apolo users

The login nodes are shared by everyone connected to a cluster. This policy
keeps them responsive.

Rules
-----

P1
   Computations **must** run as Slurm jobs, not on the login nodes.

P2
   Users **may** compile programs and edit files on the login nodes.

P3
   Users **should** compress large sets of files before transferring them.

If a rule is not followed
-------------------------

The Apolo staff may stop processes that break P1, and will notify the user.

Revision history
----------------

.. list-table::
   :header-rows: 1

   * - Version
     - Date
     - Changes
   * - 1.0
     - 2026-10-01
     - First version.
