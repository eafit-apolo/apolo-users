.. _use-scientific-software:

Use or install scientific software
==================================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

Most scientific software on Apolo is already installed and is made available
with **modules**: you load a module, and the program and its libraries become
available in your session or job. This guide shows how to find and load a
program, and what to do when the one you need is not installed.

Before you start
----------------

- You can :ref:`log in to Apolo <connect-to-apolo>`.

.. _find-software:

Find the program
----------------

#. **Look for it in this documentation.** The :ref:`software` section has one
   page per program, with the installed versions, the cluster they are on,
   the exact module to load and an example job. Use the search box at the top
   of the menu.

#. **Search the modules on the cluster.** ``module spider`` searches every
   module, including those that only appear after you load a compiler or MPI
   library:

   .. code-block:: bash

      module spider <program>

   It lists the versions it finds. To see how to load one of them:

   .. code-block:: bash

      module spider <program>/<version>

   If the output says the module needs other modules to be loaded first,
   load them before it.

Load and use it
---------------

#. Load the module, always with its version:

   .. code-block:: bash

      module load <program>/<version>

   Loading a module without a version loads whatever the default is today,
   which can change and silently change your results.

#. Check what you have loaded:

   .. code-block:: bash

      module list

#. In a job script, load the same modules in the ``ENVIRONMENT`` block,
   after ``module purge``:

   .. code-block:: bash

      ##### ENVIRONMENT #####
      module purge
      module load <program>/<version>

   By default a job inherits whatever you had loaded in your terminal when
   you submitted it, which may not be what the job needs. Loading the
   modules in the script makes the job behave the same every time.

.. note::

   On Apolo 3, some software pages show a ``module use <path>`` line before
   ``module load``. Run it as shown, in your terminal and in your job script.

For more about modules, see :ref:`lmod-index`.

.. _software-not-installed:

If the program is not installed
-------------------------------

You have two options:

**Ask the Apolo staff to install it.** Write to apolo@eafit.edu.co with:

- the program's name, the version you need and its official website,
- its license (free, or a license that you or EAFIT have),
- the cluster you use (Apolo II or Apolo 3).

This is the best option for software that several people will use, that
needs a license, or that must be compiled for good performance.

**Install it yourself in your home directory.** You do not need
administrator rights to install software for your own use. For example:

- Python packages, in a virtual environment:

  .. code-block:: bash

     python3 -m venv ~/venvs/<name>
     source ~/venvs/<name>/bin/activate
     pip install <package>

- Programs compiled from source, with an installation prefix in your home
  directory:

  .. code-block:: bash

     ./configure --prefix=$HOME/apps/<program>/<version>
     make
     make install

Load the compiler and library modules you need before compiling, and load the
same ones in the job scripts that use the program.

.. tip::

   Before installing something yourself, check the program's page in the
   :ref:`software` section: it may be installed under a different name.

If something goes wrong
-----------------------

- ``Lmod has detected the following error: The following module(s) are
  unknown``: the name or version is wrong, or the module needs other modules
  loaded first. Use ``module spider`` as shown above.
- More problems: :ref:`frequent-problems`.
