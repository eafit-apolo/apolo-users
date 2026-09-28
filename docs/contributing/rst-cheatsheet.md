# reStructuredText in 5 minutes

Pages are written in reStructuredText (`.rst`). It looks like Markdown, but
it is stricter about blank lines and indentation. This is all you need for
an Apolo page.

## A complete page

An example software page (not a real one) that uses almost everything you
will need. Copy it and change the content.

```rst
.. _flye-2.9.6:

Flye 2.9.6
==========

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo 3

Flye assembles genomes from long sequencing reads. See the
`official website <https://github.com/fenderglass/Flye>`_.

Usage
-----

#. Load the module:

   .. code-block:: bash

      module load flye/2.9.6

#. Check that it works:

   .. code-block:: console

      $ flye --version
      2.9.6-b1802

Running example
~~~~~~~~~~~~~~~

Save this script as :file:`flye-job.sh`:

.. code-block:: bash
   :caption: flye-job.sh

   #!/bin/bash
   #SBATCH --job-name=flye-test            # Job name
   #SBATCH --partition=longjobs            # Partition
   #SBATCH --time=0-01:00:00               # Time limit (D-HH:MM:SS)
   #SBATCH --output=%x-%j.out              # Output (%x = job name, %j = job ID)
   #SBATCH --error=%x-%j.err               # Errors

   ##### ENVIRONMENT #####
   module purge
   module load flye/2.9.6

   ##### JOB COMMANDS #####
   srun flye --nano-raw reads.fastq.gz --out-dir assembly

Submit it with ``sbatch flye-job.sh``.

.. warning::

   Flye needs a lot of memory for large genomes. If the job runs out of
   memory, use the ``bigmem`` partition.

.. image:: images/assembly-graph.png
   :alt: Assembly graph produced by Flye
   :width: 500px

References
----------

- :ref:`report-a-bug`
- `Flye manual <https://github.com/fenderglass/Flye/blob/flye/docs/USAGE.md>`_
```

## The three rules that break the build

**1. Blank lines around everything.** Before and after every paragraph,
list, heading, code block and box.

**2. Content of a `..` block goes 3 spaces in, after a blank line.** The
options (`:caption:`, `:alt:`) go right under the `..` line, without a
blank line.

```rst
.. code-block:: bash
   :caption: job.sh
                                  ← blank line
   echo "3 spaces in"
```

Inside a numbered step, indent everything 3 more spaces, to line up with the
text of the step (see *Usage* in the example above).

**3. Heading underlines at least as long as the heading.**

```rst
Running example
~~~~~~~~~~~~~~~        ← 15 characters, like the text: OK
Running example
~~~~~~~~               ← too short: the build fails
```

## Quick lookup

| I want | I write |
|--------|---------|
| Title / section / subsection | Underline with `=` / `-` / `~` |
| **Bold** | `**bold**` |
| Code inside a sentence | ` ``module avail`` ` (two backticks, not one) |
| A path inside a sentence | `` :file:`/home/{username}` `` |
| Bullet list | `- item` |
| Numbered steps | `#. step` |
| Link to another page of the site | `` :ref:`label` `` or `` :ref:`my text <label>` `` |
| Link to a website | `` `text <https://…>`_ `` |
| Code block | `.. code-block:: bash`, blank line, code indented 3 spaces |
| Box | `.. note::`, `.. tip::`, `.. important::`, `.. warning::` |
| Image | `.. image:: images/name.png` with `:alt:` |
| Table | `.. list-table::` (copy one from an existing page) |
| A comment nobody sees | `.. text` |

If the build fails, the error table in
[CONTRIBUTING.md](../../CONTRIBUTING.md#6-when-the-build-fails) says what
each message means.
