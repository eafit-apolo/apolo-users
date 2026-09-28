# Apolo documentation style guide

This guide defines how pages in `docs/source/` are written, named and
structured, so that the site reads as one consistent whole no matter who
wrote each page.

- **New here?** Read [CONTRIBUTING.md](../../CONTRIBUTING.md) first: it
  explains the workflow and where each file goes. Come back here while you
  write.
- **Existing pages** that predate this guide do not need to be rewritten just
  to comply. Bring a page in line when you are already making substantial
  changes to it.

**Contents**

1. [Language](#1-language)
2. [Writing style](#2-writing-style)
3. [File and directory naming](#3-file-and-directory-naming)
4. [Page types](#4-page-types)
5. [Standard page structure](#5-standard-page-structure)
6. [Page metadata: review date and maintainer](#6-page-metadata-review-date-and-maintainer)
7. [Headings](#7-headings)
8. [Admonitions](#8-admonitions)
9. [Commands, variables, paths and modules](#9-commands-variables-paths-and-modules)
10. [Slurm job examples](#10-slurm-job-examples)
11. [Links](#11-links)
12. [Images](#12-images)
13. [Sensitive information](#13-sensitive-information)

---

## 1. Language

**Write everything in English**: page content, file and directory names,
labels, branch names and commit messages.

Why English, and not Spanish or a mix of both:

- The whole site is already in English (about 440 pages), and the Sphinx
  configuration declares it (`language = 'en'`).
- A site that mixes languages is harder to use than one in either language:
  readers cannot predict which language a page is in, search results split
  across two vocabularies, and the menus read inconsistently.
- Apolo serves external collaborators as well as EAFIT users, and most of what
  it documents (upstream software manuals, compiler and Slurm error messages)
  is in English. Quoting error messages verbatim, in a page written in the
  same language, makes them easy to search.

If Spanish content becomes a requirement, add it as a complete translation
with Sphinx's internationalization support and a separate Read the Docs
translation project, never by mixing languages page by page.

## 2. Writing style

- **Start with the reader's goal.** The first one to three sentences say what
  the page covers and who it is for.
- **Address the reader as "you"**, and write steps in the imperative:
  "Load the module", not "The module should be loaded".
- **Use the present tense and the active voice.**
- **One action per numbered step.** If the step needs a command, put the code
  block directly under the step.
- **Show the expected result** after any step whose outcome is not obvious.
- **Prefer short sentences and common words.** Many readers are not native
  English speakers.
- **Spelling**: American English ("behavior", "optimize").
- **Dates**: ISO 8601, `2026-09-28`. Never `09/22/2025`, which readers
  interpret differently depending on their country.
- **Units**: a space between number and unit, SI prefixes: `16 GB`, `2 h`.
- **Names**: use the official spelling: Slurm (not SLURM), Apolo II, Apolo 3,
  GROMACS, OpenMPI, Python.
- **Normative words**, in policies and procedures only: *must* (mandatory),
  *should* (recommended), *may* (optional).
- **Line length**: there is no hard limit, but prefer lines under 100
  characters or one sentence per line; both make changes easier to review.
  Do not re-wrap paragraphs you are not otherwise changing.

## 3. File and directory naming

| Item | Rule | Good | Bad |
|------|------|------|-----|
| Directories | lowercase, words joined by `-` | `lotos-euros/` | `Lotos_Euros/`, `lotosEuros/` |
| Files | lowercase, words joined by `-`, extension `.rst` | `configure-vpn.rst` | `Configure_VPN.rst` |
| Page that introduces a directory | always `index.rst` | `slurm/index.rst` | `slurm/slurm.rst` |
| Program directory | the program's name, lowercased | `alphafold3/`, `beast2/` | `AlphaFold3/` |
| Version directory | exactly the upstream version, nothing else | `2.9.6/`, `2022.01a/`, `r2019a/` | `flye2.9.6-b1802/`, `Cloog-0.20.0/` |
| Build variant | version, `-`, variant | `4.8.0-disable-netcdf-4/`, `1.2.11-gcc/` | `4.5.3_disable-netcdf-4/` |
| Sub-pages of a version | fixed names | `installation.rst`, `usage.rst`, `troubleshooting.rst` | `install_guide.rst` |
| Images | `images/` next to the page; describe the content | `images/vpn-login-window.png` | `images/Captura1.PNG` |
| Labels | lowercase, `-`, unique in the whole site | `flye-2.9.6`, `configure-vpn` | `flye_2.9.6`, `Flye` |

Use only `a-z`, `0-9` and `-` in names, plus `.` inside version numbers. No
spaces, capital letters, underscores, accents or `ñ`.

**Do not rename existing files** just to follow these rules. A file's path is
its public web address, so renaming it breaks bookmarks, search results and
links from other sites. If a rename is worth it, do it in a separate pull
request and ask a maintainer to add a redirect in Read the Docs.

## 4. Page types

Every page is one of these types. The type decides the template, the sections
and where the file goes (see
[Where does my page go?](../../CONTRIBUTING.md#4-where-does-my-page-go)).

| Type | Answers the question | Audience | Template |
|------|----------------------|----------|----------|
| **Software** | "Is program X installed, and how do I use it?" | Users and staff | [`software-overview.rst`](templates/software-overview.rst), [`software-version.rst`](templates/software-version.rst) |
| **Guide** | "How do I do X?" (one concrete task) | Users | [`guide.rst`](templates/guide.rst) |
| **Tutorial** | "Teach me X from scratch" | New users | [`tutorial.rst`](templates/tutorial.rst) |
| **Troubleshooting** | "X fails, what do I do?" | Users | [`troubleshooting.rst`](templates/troubleshooting.rst) |
| **Policy** | "What am I allowed or required to do?" | Users and staff | [`policy.rst`](templates/policy.rst) |
| **Procedure** | "What exact steps does staff follow for X?" | Staff | [`procedure.rst`](templates/procedure.rst) |
| **Reference** | "What are the facts about X?" (a cluster, a list of partitions) | Everyone | none; follow the existing pages of that section |

Guide, tutorial and procedure are easy to confuse:

- A **guide** gets a user through one task as quickly as possible: "Transfer
  files to Apolo". It assumes the reader knows what they want.
- A **tutorial** teaches: it explains why at each step and is meant to be
  followed once, in order, while learning: "Run your first Slurm job".
- A **procedure** is a checklist for staff that must be followed exactly the
  same way every time, with roles, verification and rollback: "Create a user
  account".

## 5. Standard page structure

Every page, of any type, has the same frame. The templates already follow it.

```rst
.. _page-label:                  ← 1. label, used by other pages to link here

Page title                       ← 2. title
==========

:Authors: Jane Doe               ← 3. metadata block (section 6)
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28

One to three sentences: what     ← 4. summary
this page covers, who it is for.

.. contents:: On this page       ← 5. local table of contents,
   :local:                          only if the page has 4 or more sections
   :depth: 1

<body>                           ← 6. body: the sections of the page type

See also                         ← 7. closing sections, only if they have
--------                            content, in this order:
                                    Troubleshooting, See also, References
```

## 6. Page metadata: review date and maintainer

Every new page has a metadata block **right under the title**. It is shown on
the page, so readers can tell how current it is and who is responsible.

```rst
:Authors: Jane Doe, John Roe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28
:Applies to: Apolo 3
```

| Field | Required | Meaning |
|-------|----------|---------|
| `Authors` | yes | Everyone who wrote the page. Add your name when you make a substantial change; never remove names. |
| `Maintainer` | yes | The one person currently responsible for keeping the page correct. When they leave the center, a maintainer assigns the page to someone else. |
| `Last reviewed` | yes | The date someone last checked the **whole** page against the cluster (not just the date of the last edit). |
| `Applies to` | if relevant | Cluster(s), version or audience the page is valid for. |

Policies add three more fields: `Version`, `Effective date` and `Approved by`.
The snippet to copy is [`templates/page-metadata.rst`](templates/page-metadata.rst).

**Review cycle.** Re-check a page and update `Last reviewed` at least this
often:

| Type | Re-review at least every |
|------|--------------------------|
| Policy | 12 months, and whenever the rule changes |
| Procedure | 6 months, and after any change to the system it operates on |
| Guide, tutorial, troubleshooting | 12 months, and after any change to the cluster that affects it |
| Software | When the module is upgraded or removed |

To list pages from the oldest review date to the newest:

```bash
grep -r ':Last reviewed:' docs/source | sort -t: -k4
```

Older pages record their authors in an `Authors` section at the end. When you
make substantial changes to one of them, move that into the metadata block.

## 7. Headings

The character under the heading sets its level. The underline must be at least
as long as the heading text, or the build fails.

| Level | Underline | Example |
|-------|-----------|---------|
| Page title (one per page) | `=` | `Flye 2.9.6` / `==========` |
| Section | `-` | `Installation` / `------------` |
| Subsection | `~` | `Compiling` / `~~~~~~~~~` |
| Sub-subsection | `^` | `Options` / `^^^^^^^` |

Do not use overlines, and do not go deeper than four levels: split the page
instead. Write headings in sentence case ("Check your results"), except for
proper names.

## 8. Admonitions

Admonitions are the colored boxes (`.. note::`, `.. warning::`, …). They draw
the eye away from the text, so use them only when the content would otherwise
be missed. At most one per section, never two in a row, and never put a
required step inside one.

| Directive | Use it for | Example |
|-----------|------------|---------|
| `note` | Useful context the reader can skip without harm. | "This module is also available on Apolo II." |
| `tip` | A better or faster way to do something that already works. | "Use a job array to submit 100 similar jobs at once." |
| `important` | Something the reader must know or do for the task to succeed. | "You must be connected to the VPN before you log in." |
| `warning` | An action that can cause errors, lost work or wasted time, and how to avoid it. | "Jobs that exceed their time limit are stopped, and unsaved results are lost." |
| `danger` | Irreversible loss of data or access. Rare. | "This command deletes every file in the directory and cannot be undone." |
| `seealso` | Links to related pages or external documentation. | "See also: :ref:`report-a-bug`." |
| `admonition` | A box with your own title, when none of the above fits, such as differences between clusters. The title must be specific. | `.. admonition:: Differences on Apolo 3` |

Do not use `caution`, `attention`, `hint` or `error`: they overlap with the
set above. Use `warning` instead of `caution`, and `tip` instead of `hint`.

```rst
.. warning::

   Jobs that exceed their ``--time`` limit are stopped, and unsaved results
   are lost. Request 10 to 20 % more time than your test run needed.
```

## 9. Commands, variables, paths and modules

### Inside a sentence

| What | Write | Example |
|------|-------|---------|
| Command or program | ` ``sbatch`` ` | Submit the job with ``sbatch``. |
| Short full command | ` ``module avail gcc`` ` | Run ``module avail gcc`` to list the versions. |
| Option | ` ``--ntasks`` ` | |
| Environment variable | ` ``SLURM_JOB_ID`` ` to name it, ` ``$SLURM_JOB_ID`` ` for its value | |
| Module | ` ``gcc/11.2.0`` ` | Load ``gcc/11.2.0``. |
| File or directory | `` :file:`/home/{username}/data` `` (the part in `{}` is shown as a placeholder) | |
| Button or menu | `` :guilabel:`Connect` `` | |
| Keyboard keys | `` :kbd:`Ctrl+C` `` | |

Many older pages declare a `:bash:` role at the top for inline commands. It
still works, but new pages use double backticks, which need no declaration.

### Code blocks

- **Always declare the language.** A bare `.. code-block::` is not allowed.
- **`bash`** for commands the reader copies and runs. Do not include the `$`
  prompt, so the block can be pasted as it is.
- **`console`** to show a command together with its output. Start the
  command lines with `$ `.
- **`text`** for program output, logs and error messages. Copy error messages
  exactly, without paraphrasing, so readers can search for them.
- **File contents** get a caption with the file name (`:caption: job.sh`).
- **Scripts longer than about 40 lines** go in a file next to the page and are
  shown with `.. literalinclude::`, so readers can also download them.

### Placeholders

Values the reader must replace are written `<lowercase-with-hyphens>` in code
blocks, and explained right after the block:

```rst
.. code-block:: bash

   scp <local-file> <username>@<cluster-address>:~/

Replace ``<username>`` with your Apolo username and ``<cluster-address>``
with the address of your cluster.
```

Inside `:file:`, write placeholders as `{username}` instead.

### Modules

- **Always load an explicit version**: `module load gcc/11.2.0`, never
  `module load gcc`. The default version changes over time, and a script that
  silently starts using a different version can give different results.
- **Start job scripts with `module purge`**, so they do not depend on what the
  user had loaded in their terminal.
- **If a module needs `module use <path>` first**, as some Apolo 3 modules
  do, show that line too.

## 10. Slurm job examples

Every Slurm job script in the documentation has this layout:

```bash
#!/bin/bash
#SBATCH --job-name=flye-assembly        # Job name
#SBATCH --partition=<partition>         # Partition (queue)
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks=1                      # Number of tasks (MPI processes)
#SBATCH --cpus-per-task=16              # Threads per task
#SBATCH --mem=64G                       # Memory per node
#SBATCH --time=0-04:00:00               # Time limit (D-HH:MM:SS)
#SBATCH --output=%x-%j.out              # Standard output (%x = job name, %j = job ID)
#SBATCH --error=%x-%j.err               # Standard error
#SBATCH --mail-type=END,FAIL            # When to send email
#SBATCH --mail-user=<email>             # Where to send email

##### ENVIRONMENT #####
module purge
module load flye/2.9.6

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

##### JOB COMMANDS #####
srun flye --nano-raw reads.fastq.gz --out-dir assembly --threads "$SLURM_CPUS_PER_TASK"
```

- **Long option names with `=`** (`--ntasks=4`, not `-n 4`), one per line, in
  the order above. Leave out lines that do not apply.
- **A comment on every `#SBATCH` line**, aligned, saying what it controls.
- **`--time` is always `D-HH:MM:SS` or `HH:MM:SS`.** Slurm reads
  `--time=1:00` as one *minute*, not one hour.
- **Output files are named `%x-%j.out` and `%x-%j.err`**, so each run writes
  to new files.
- **Never write a real email address** in `--mail-user`; use `<email>`.
- **Use a partition that exists on the cluster the page is for**, and say
  which cluster that is. Use `<partition>` only in templates. If the example
  runs on more than one cluster with different settings, show one version per
  cluster.
- **Request only what the example needs.** A tutorial should run on the
  smallest allocation that works, so it starts quickly and does not waste
  resources.
- **Two marked blocks**: `##### ENVIRONMENT #####` (module purge, module
  loads, exports) and `##### JOB COMMANDS #####`.
- **Launch the program with `srun`.**

After the script, show how to submit it and what the reader should see:

```console
$ sbatch flye-job.sh
Submitted batch job 123456
```

## 11. Links

- **To another page of this site**, use its label: `` :ref:`flye-2.9.6` ``
  or `` :ref:`your text <flye-2.9.6>` ``. Never use the full
  readthedocs.io address: it breaks when a page moves.
- **Every page starts with a label**, and labels are unique in the whole site.
  The build fails if two pages declare the same one.
- **External links**: `` `Flye documentation <https://github.com/fenderglass/Flye>`_ ``.
- **Link text says where the link goes**; never "click here".
- Numbered footnotes (`[1]_`) are fine for citing sources in a References
  section.

## 12. Images

- Put images in an `images/` directory next to the page, with names that
  describe the content (`slurm-job-states.png`).
- Use PNG for screenshots and SVG for diagrams. Crop screenshots to the part
  that matters and keep them under about 500 KB.
- Every image has `:alt:` text describing what it shows, for readers who use
  screen readers or cannot load the image.

```rst
.. figure:: images/vpn-login-window.png
   :alt: GlobalProtect login window with the username and password fields
   :width: 500px

   GlobalProtect login window.
```

## 13. Sensitive information

The documentation is public. Never include:

- passwords, tokens, API keys, private keys or license server secrets;
- real personal email addresses or usernames (use `<email>`, `<username>`);
- screenshots that show another person's name, username, files or session;
- configuration details the center has not decided to publish.

If you find something like this in an existing page, remove it and tell the
maintainers: it is still in the Git history, and they may need to change the
exposed credential.
