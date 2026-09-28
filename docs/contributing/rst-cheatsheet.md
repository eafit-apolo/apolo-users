# reStructuredText cheat sheet

The pages of this site are written in reStructuredText (RST). This sheet
covers everything you need to write a typical page. For the full reference,
see the [Sphinx RST primer](https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html).

**Contents**

- [The three rules that cause most errors](#the-three-rules-that-cause-most-errors)
- [If you know Markdown](#if-you-know-markdown)
- [Page skeleton](#page-skeleton)
- [Headings](#headings)
- [Text formatting](#text-formatting)
- [Lists](#lists)
- [Code blocks](#code-blocks)
- [Links](#links)
- [Admonitions (notes and warnings)](#admonitions-notes-and-warnings)
- [Images](#images)
- [Tables](#tables)
- [Table of contents (toctree)](#table-of-contents-toctree)
- [Comments](#comments)

---

## The three rules that cause most errors

**1. Blank lines separate everything.** Put a blank line before and after
every paragraph, list, heading, code block and directive.

**2. Directive content is indented 3 spaces, after a blank line.** A
*directive* is anything that starts with `.. name::`. Its options go on the
next lines, indented; then a blank line; then the content, indented.

```rst
.. code-block:: bash
   :caption: example.sh

   echo "Content: indented 3 spaces, after a blank line"

This paragraph is back at column 0, after a blank line.
```

**3. Indentation means something.** Never indent a line "for looks": to RST,
an indented line is either part of the element above or a block quote. Use
spaces, never tabs.

## If you know Markdown

| You want | Markdown | reStructuredText |
|----------|----------|------------------|
| Heading | `# Title` | `Title` with a line of `=` underneath (see [Headings](#headings)) |
| Bold | `**bold**` | `**bold**` |
| Italic | `*italic*` | `*italic*` |
| Inline code | `` `code` `` | ` ``code`` ` (**two** backticks) |
| External link | `[text](https://x.org)` | `` `text <https://x.org>`_ `` |
| Link to another page | `[text](page.md)` | `` :ref:`text <page-label>` `` |
| Code block | three backticks and `bash`, code, three backticks | `.. code-block:: bash` + blank line + indented code |
| Numbered list | `1.` | `#.` (numbers itself) or `1.` |
| Image | `![alt](img.png)` | `.. image:: img.png` + `:alt: text` |

The one that catches everyone: single backticks in RST do **not** make code.
Use double backticks.

## Page skeleton

```rst
.. _my-page-label:

My page title
=============

:Authors: Jane Doe
:Maintainer: Jane Doe
:Last reviewed: 2026-09-28

One to three sentences saying what this page is about.

First section
-------------

Text.
```

The first line is the page's **label**, which other pages use to link to it.
The block of `:Field: value` lines is the page's metadata (see
[the style guide](style-guide.md#6-page-metadata-review-date-and-maintainer)).

## Headings

A heading is a line of text with a line of punctuation underneath, **at least
as long as the text**. The character sets the level:

```rst
Page title
==========

Section
-------

Subsection
~~~~~~~~~~

Sub-subsection
^^^^^^^^^^^^^^
```

Use this order in every page. Each page has exactly one `=` title.

## Text formatting

```rst
**bold**, *italic*, ``inline code``

Paths: :file:`/home/{username}/project`   ({username} is shown as a placeholder)
Keys: :kbd:`Ctrl+C`
Buttons and menus: :guilabel:`Connect`
```

Formatting cannot be nested (no bold inside a link, no code inside bold), and
the markers must touch the text: `** bold**` does not work.

## Lists

```rst
- A bullet item.
- Another item. To continue an item on the next line,
  indent the continuation to line up with the text.

#. First numbered step.
#. Second numbered step.

   A paragraph or code block that belongs to step 2 is indented
   to line up with the step text (3 spaces for "#. "), after a blank line.

   .. code-block:: bash

      module avail

#. Third step.
```

A list needs a blank line before and after it.

## Code blocks

```rst
.. code-block:: bash

   module load gcc/11.2.0
   gcc --version
```

Always write the language after `code-block::`. The usual ones are:

| Language | Use for |
|----------|---------|
| `bash` | Commands the reader copies and runs (no `$` prompt) |
| `console` | A command **and** its output; command lines start with `$ ` |
| `text` | Plain output, logs, error messages |
| `python`, `r`, `lua`, `tcl`, `yaml`, `ini`, `make` | Files in those languages |

To show a file name above the block, add `:caption: name.sh` on the line
after the directive (see rule 2 above).

To include a long script stored in a file next to the page:

```rst
.. literalinclude:: job.sh
   :language: bash
```

## Links

```rst
External: `Slurm documentation <https://slurm.schedmd.com/>`_

To another page of this site, using its label:
:ref:`report-a-bug`                      (shows the page title)
:ref:`how to report a bug <report-a-bug>` (shows your text)
```

Never link to another page of this site with its full readthedocs.io URL: use
`:ref:`, so the link keeps working when a page moves.

To make a label point at a section instead of a whole page, put it right
above the section heading, followed by a blank line:

```rst
.. _vpn-linux:

Linux
-----
```

## Admonitions (notes and warnings)

```rst
.. note::

   Text of the note, indented 3 spaces.

.. warning::

   Text of the warning.
```

Which one to use is defined in the
[style guide](style-guide.md#8-admonitions): `note`, `tip`, `important`,
`warning`, `danger`, `seealso`, or `admonition` with your own title.

## Images

```rst
.. image:: images/vpn-login.png
   :alt: The VPN client login window
   :width: 500px
```

With a caption:

```rst
.. figure:: images/vpn-login.png
   :alt: The VPN client login window
   :width: 500px

   The caption goes here, after a blank line.
```

The path is relative to the `.rst` file. `:alt:` is required.

## Tables

The easiest kind to write and edit is a list table:

```rst
.. list-table::
   :header-rows: 1

   * - Partition
     - Use it for
   * - longjobs
     - General jobs
   * - bigmem
     - Jobs that need a lot of memory
```

Each `* -` starts a row and each `-` under it is a cell. Every row must have
the same number of cells.

## Table of contents (toctree)

Each section's `index.rst` lists its sub-pages. A page that is not listed in
any toctree is not built, and the build fails.

```rst
.. toctree::
   :maxdepth: 1

   configure_vpn
   2.9.6/index
```

Entries are paths relative to the current file, without `.rst`.

## Comments

```rst
.. This is a comment. It is not shown on the website.
   It can continue on indented lines.
```

The templates use comments for their instructions. Delete them when you are
done.
