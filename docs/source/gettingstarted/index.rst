.. _gettingstarted-index:

First steps on Apolo
====================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: New users

This page is the path from "I have never used Apolo" to "my first job ran".
Follow the steps in order; each one links to a guide with the details.

Step 1: Get your accounts
-------------------------

You need a VPN account and a cluster account, both created by the Apolo
staff after a short meeting with you. Research at Universidad EAFIT is free;
other institutions and companies can also compute on Apolo, at a cost.

:ref:`Request an account <request-an-account>`

Step 2: Connect to the cluster
------------------------------

Install the VPN client, connect to the VPN, and log in to your cluster
(Apolo II or Apolo 3) with SSH.

:ref:`Connect to Apolo <connect-to-apolo>`

Step 3: Run your first job
--------------------------

Write a small job script, submit it to Slurm, follow its state and read its
output. It takes about 10 minutes.

:ref:`Run your first Slurm job <run-your-first-job>`

Step 4: Run your real work
--------------------------

- Find and load the software you need: :ref:`use-scientific-software`.
- Copy your data to the cluster: :ref:`transfer-files`.
- Learn about parallel jobs (OpenMP, MPI) and job arrays: :ref:`submit`.
- After your first real jobs, check what they used, so you request the right
  amount next time: :ref:`check-resource-usage`.

If something goes wrong
-----------------------

See :ref:`frequent-problems`. For anything else, write to
apolo@eafit.edu.co.

Learn more
----------

The Apolo staff offers workshops, talks and consulting on scientific
computing. There are also online resources to learn the basics on your own,
and a set of command-line tools written by the staff to help with Slurm.

.. toctree::
   :maxdepth: 1

   configure_vpn
   educational_resources
   apolo_user_tools
