.. TEMPLATE: a guide shows how to do ONE task, step by step.
   Copy to: docs/source/gettingstarted/<task>.rst (name it with a verb).
   Everything below is an example: replace it with your task, then delete
   this comment.

.. _compress-results:

Compress your results before downloading them
=============================================

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

Downloading one compressed file is much faster than downloading thousands
of small ones. This guide shows how to pack a results directory into a
single file, and how to unpack it on your computer.

Before you start
----------------

- You are logged in to the cluster.

Compress a directory
--------------------

#. Go to the directory that contains your results:

   .. code-block:: bash

      cd ~/project

#. Pack the ``results`` directory into :file:`results.tar.gz`:

   .. code-block:: bash

      tar -czf results.tar.gz results/

#. Check the size of the file:

   .. code-block:: console

      $ ls -lh results.tar.gz
      -rw-r--r-- 1 <username> <group> 1.2G Sep 28 10:00 results.tar.gz

Extract it on your computer
---------------------------

After downloading it, run:

.. code-block:: bash

   tar -xzf results.tar.gz

This recreates the ``results`` directory with all its files.
