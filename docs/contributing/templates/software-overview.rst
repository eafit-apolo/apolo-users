.. ------------------------------------------------------------------------
   SOFTWARE OVERVIEW TEMPLATE

   The page that introduces a program and lists its installed versions.
   Create it only once per program: when you document a new version of a
   program that already has this page, just add the version to its
   toctree.

   How to use:
   1. Create the program directory, in lowercase:
         docs/source/software/<category>/<program>/
      and copy this file into it as index.rst.
   2. Add "<program>/index" to the toctree of
         docs/source/software/<category>/index.rst
   3. Change the label below to "<program>" (lowercase, "-" between words).
   4. Replace every [bracketed text] and delete these comment blocks.
   5. Document each version from software-version.rst, in a sub-directory
      named exactly like the version (for example 2.9.6/index.rst).
   ------------------------------------------------------------------------

.. _program-replace-me:

[Program name]
==============

[Two to four sentences: what the program does, in which field it is used,
and what kind of problem it solves. Avoid copying marketing text from the
official website.]

- **Official website:** `[Program name] <https://example.org>`_
- **License:** [License name, e.g. GPL-3.0 | proprietary, licensed by EAFIT]

.. toctree::
   :caption: Installed versions
   :maxdepth: 1

   [version]/index
