# Style guide

The rules every new page follows. If you start from a
[template](templates/), most of them are already done for you: fill it in,
then check this page before you open your pull request.

Pages written before this guide don't need to be rewritten. Apply it when you
are already making big changes to one.

---

## Language

Write in **English**: content, file names, labels and commit messages. The
whole site is in English, and error messages from Slurm and compilers are
too, so pages and errors match when users search.

## Names

Lowercase, words joined by `-`, no spaces, accents or underscores.

```
docs/source/software/applications/flye/index.rst          ← the program
docs/source/software/applications/flye/2.9.6/index.rst    ← one version
docs/source/software/applications/flye/2.9.6/images/     ← its images
```

- The version directory is **exactly the upstream version**: `2.9.6/`, not
  `flye-2.9.6/` or `Flye2.9.6/`.
- The label of a page is its name: `.. _flye-2.9.6:`. It must be unique in
  the whole site.
- **Don't rename existing files.** The path is the page's web address, and
  renaming it breaks every link to it.

## Page skeleton

Every page starts like this:

```rst
.. _flye-2.9.6:

Flye 2.9.6
==========

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo 3

How to use Flye 2.9.6 on Apolo 3, and how it was installed.
```

| Field | What to write |
|-------|---------------|
| `Authors` | Everyone who wrote the page. Add your name; never remove one. |
| `Maintainer` | The one person who keeps the page correct now. |
| `Last reviewed` | The date someone last checked the **whole** page on the cluster. Update it when you do. |
| `Applies to` | `Apolo II`, `Apolo 3`, or both. |

Headings use `=` for the title, then `-`, `~` and `^`. The line underneath
must be at least as long as the text, or the build fails.

## Writing

- Talk to the reader: "Load the module", not "The module should be loaded".
- One action per numbered step. The command goes right under its step.
- After a step whose result isn't obvious, show what the reader should see.
- Dates as `2026-09-28`. Names as **Slurm**, **Apolo II**, **Apolo 3**.

## Commands and code

| You want to show | Write |
|------------------|-------|
| A command, option, module or variable inside a sentence | ` ``sbatch`` `, ` ``--time`` `, ` ``gcc/11.2.0`` `, ` ``$SLURM_JOB_ID`` ` |
| A file or directory inside a sentence | `` :file:`/home/{username}/data` `` |
| Commands the reader copies and runs | `.. code-block:: bash`, **without** `$` |
| A command and its output | `.. code-block:: console`, command lines start with `$ ` |
| Output or an error message | `.. code-block:: text`, copied exactly |

Values the reader must change go in angle brackets, and you explain them
right after the block:

```rst
.. code-block:: bash

   scp results.csv <username>@apolo-3.eafit.edu.co:~/

Replace ``<username>`` with your Apolo username.
```

## Modules

- Always with a version: `module load gcc/11.2.0`, never `module load gcc`.
  The default version changes over time, and so would the results.
- In job scripts, start with `module purge`.
- If the module needs a `module use <path>` line first (some Apolo 3
  modules do), include it.

## Slurm scripts

Every job script in the documentation looks like this:

```bash
#!/bin/bash
#SBATCH --job-name=flye-test            # Job name
#SBATCH --partition=longjobs            # Partition
#SBATCH --nodes=1                       # Nodes
#SBATCH --ntasks=1                      # Tasks (MPI processes)
#SBATCH --cpus-per-task=4               # Cores per task
#SBATCH --mem=8G                        # Memory per node
#SBATCH --time=0-01:00:00               # Time limit (D-HH:MM:SS)
#SBATCH --output=%x-%j.out              # Output (%x = job name, %j = job ID)
#SBATCH --error=%x-%j.err               # Errors

##### ENVIRONMENT #####
module purge
module load flye/2.9.6

##### JOB COMMANDS #####
srun flye --nano-raw reads.fastq.gz --out-dir assembly --threads "$SLURM_CPUS_PER_TASK"
```

- **A real partition of the cluster in `Applies to`.** `longjobs` exists on
  both clusters. Apolo 3 has no `debug` partition.
- **`--time` as `D-HH:MM:SS`.** `--time=1:00` means one *minute*.
- **The smallest resources that work**, so the example starts quickly.
- **No real email addresses.** If you use `--mail-user`, write `<email>`.
- Leave out lines that don't apply, but keep the order.

## Notes and warnings

Use a box only if the reader would otherwise miss something. At most one
per section.

| Box | When |
|-----|------|
| `.. note::` | Useful, but safe to skip. |
| `.. tip::` | A better way to do something that already works. |
| `.. important::` | Required for the task to work. |
| `.. warning::` | Can cause errors or lost work. Say how to avoid it. |

## Links and images

- To another page of this site, use its label: `` :ref:`report-a-bug` ``.
  Never paste its readthedocs.io address.
- To another website: `` `Flye on GitHub <https://github.com/fenderglass/Flye>`_ ``.
- Images go in `images/` next to the page and always have `:alt:` text.
  Crop screenshots to what matters.

## Never publish

The site is public. Never include passwords, tokens, license keys, real
email addresses or usernames, or screenshots showing someone's session or
files. If you find one in an existing page, remove it and tell the
maintainers.
