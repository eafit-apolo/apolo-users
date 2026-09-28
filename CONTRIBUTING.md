# Contributing to the Apolo documentation

Thank you for helping improve the documentation of the Apolo Scientific
Computing Center. This guide assumes you have **never contributed to this
repository before**. Read it once from top to bottom; afterwards you will only
need the [checklist](#checklist) at the end.

You do not need to be an expert in Git or Sphinx. If you get stuck at any
step, open an issue or ask the Apolo staff (see [Getting help](#getting-help)).

**Contents**

1. [Choose how to contribute](#1-choose-how-to-contribute)
2. [How the repository is organized](#2-how-the-repository-is-organized)
3. [How a page reaches the website](#3-how-a-page-reaches-the-website)
4. [Where does my page go?](#4-where-does-my-page-go)
5. [Your first contribution, step by step](#5-your-first-contribution-step-by-step)
6. [When the build fails](#6-when-the-build-fails)
7. [Checklist](#checklist)
8. [Getting help](#getting-help)

---

## 1. Choose how to contribute

| You want to… | Do this | What you need |
|--------------|---------|---------------|
| Report something wrong or missing | [Open an issue](https://github.com/eafit-apolo/apolo-users/issues/new) saying which page, what is wrong and, if you know it, what it should say | A GitHub account |
| Fix a typo or change a few lines | [Edit the file on GitHub](#quick-fix-edit-on-github), no installation needed | A GitHub account |
| Add a page or change several pages | Follow [the full workflow](#5-your-first-contribution-step-by-step) | Git, Python 3.11 or newer, a GitHub account |

### Quick fix: edit on GitHub

1. Open the page on the [published site](https://apolo-users.readthedocs.io/en/latest/)
   and click **Edit on GitHub** at the top right. This opens the source file.
2. Click the pencil icon (**Edit this file**). If you do not have write access
   to the repository, GitHub makes a personal copy (a *fork*) for you
   automatically.
3. Make the change. Keep the formatting of the surrounding lines.
4. Click **Commit changes…**, write a short description of what you changed,
   choose **Create a new branch** and click **Propose changes**.
5. On the next screen click **Create pull request**. A maintainer reviews it.

For anything larger than a few lines, use the full workflow: it lets you
preview the result and catch errors before anyone reviews it.

## 2. How the repository is organized

Everything that is published lives in `docs/source/`. Everything else is
tooling or help for contributors.

```
apolo-users/
├── CONTRIBUTING.md            ← this guide
├── README.md
├── .readthedocs.yaml          ← how Read the Docs builds the site (rarely changed)
└── docs/
    ├── Makefile               ← lets you run `make -C docs html` to build the site
    ├── requirements.txt       ← the Python packages the build needs
    ├── contributing/          ← help for contributors (not published)
    │   ├── style-guide.md     ←   how to write, name and structure pages
    │   ├── rst-cheatsheet.md  ←   the reStructuredText syntax you will need
    │   └── templates/         ←   ready-to-copy page templates
    └── source/                ← THE PUBLISHED SITE: one .rst file = one web page
        ├── conf.py            ←   Sphinx configuration (rarely changed)
        ├── index.rst          ←   the home page
        ├── gettingstarted/    ←   first steps for new users: accounts, VPN, resources
        ├── supercomputers/    ←   one directory per cluster
        ├── software/          ←   one directory per installed software, by category
        │   ├── applications/          scientific applications (GROMACS, WRF, …)
        │   ├── scientific_libraries/  libraries (NetCDF, FFTW, …)
        │   ├── programminglanguages/  compilers and interpreters (R, Python, …)
        │   ├── managementsoftware/    Slurm, Lmod and cluster tools
        │   ├── accelerators/          GPU-related software
        │   ├── virtualization/        containers and virtual machines
        │   ├── provisioning/          node installation tools (staff)
        │   ├── monitoring/            monitoring tools (staff)
        │   └── operatingsystems/      operating system notes (staff)
        ├── how-to-acknowledge.rst
        ├── report-a-bug.rst
        ├── images/            ←   site-wide images (logos)
        ├── _static/           ←   theme files: CSS and logo (do not edit for content)
        └── _templates/        ←   theme HTML overrides (do not edit for content)
```

Three rules explain the layout:

- **A directory is a section of the site**, and its `index.rst` is the page
  that introduces it and lists its sub-pages.
- **Software gets one directory per program** and one sub-directory per
  installed version: `software/applications/flye/index.rst` introduces Flye,
  `software/applications/flye/2.9.6/index.rst` documents version 2.9.6.
- **Images live next to the page that uses them**, in an `images/` directory.

## 3. How a page reaches the website

The site is written in [reStructuredText](docs/contributing/rst-cheatsheet.md)
(`.rst` files), a plain-text format similar to Markdown. A tool called
[Sphinx](https://www.sphinx-doc.org/) turns those files into HTML.

```
 you write            you list it in           Sphinx builds          after the merge,
 a .rst file   ──►    a toctree of its   ──►   the site; any    ──►   Read the Docs
 in docs/source       parent index.rst         warning = error        publishes it
```

The step people forget is the second one. Sphinx only builds pages that are
listed in a **toctree** (table of contents tree) of some other page. The
parent `index.rst` of a section has one, like this:

```rst
.. toctree::
   :maxdepth: 1

   configure_vpn
   educational_resources
```

Each entry is a file path **relative to that `index.rst` and without the
`.rst` extension**. To publish `gettingstarted/my-new-page.rst`, add
`my-new-page` to the toctree in `gettingstarted/index.rst`.

The build is strict: it runs with `-W`, which turns every warning into an
error. That is deliberate, because it keeps broken links and malformed pages
off the website. It also means your pull request cannot be merged until the
build is clean, so always build locally before you open it.

## 4. Where does my page go?

Find the row that matches what you are writing, and start from its template.
Each template explains at its top how to fill it in.

| You are writing… | Page type | Start from | Put it in |
|------------------|-----------|------------|-----------|
| How a program was installed and how to use it | Software | [`software-overview.rst`](docs/contributing/templates/software-overview.rst) (first version of a program) and [`software-version.rst`](docs/contributing/templates/software-version.rst) | `docs/source/software/<category>/<program>/<version>/index.rst` |
| How a user does one concrete task (connect, transfer files, …) | Guide | [`guide.rst`](docs/contributing/templates/guide.rst) | `docs/source/gettingstarted/` |
| A lesson that teaches something end to end | Tutorial | [`tutorial.rst`](docs/contributing/templates/tutorial.rst) | `docs/source/gettingstarted/` |
| Known problems and their fixes | Troubleshooting | [`troubleshooting.rst`](docs/contributing/templates/troubleshooting.rst) | Next to the page it is about; for software, `troubleshooting.rst` inside the version directory |
| A rule users or staff must follow | Policy | [`policy.rst`](docs/contributing/templates/policy.rst) | Ask the maintainers first |
| Exact steps for an operational task done by staff | Procedure | [`procedure.rst`](docs/contributing/templates/procedure.rst) | Ask the maintainers first |
| Information about a cluster | Reference | Existing pages in `supercomputers/` | `docs/source/supercomputers/<cluster>/index.rst` |

If nothing fits, open an issue describing what you want to add and the
maintainers will suggest a place.

## 5. Your first contribution, step by step

The commands below are for Linux and macOS. On Windows, use
[WSL](https://learn.microsoft.com/windows/wsl/install) and run them inside it.

### Step 1. Install the tools (once)

You need `git`, Python 3.11 or newer and `make`. Check them with:

```bash
git --version
python3 --version
make --version
```

### Step 2. Get a copy of the repository (once)

**If you are a member of the Apolo team with write access**, clone the
repository directly:

```bash
git clone https://github.com/eafit-apolo/apolo-users.git
cd apolo-users
```

**Otherwise**, click **Fork** at the top right of the
[repository page](https://github.com/eafit-apolo/apolo-users) to create your
own copy, then clone your copy (replace `<your-github-user>`):

```bash
git clone https://github.com/<your-github-user>/apolo-users.git
cd apolo-users
git remote add upstream https://github.com/eafit-apolo/apolo-users.git
```

Not sure which one you are? Try the first option; if `git push` is later
refused with a permission error, use a fork.

### Step 3. Prepare the build environment (once)

This creates an isolated Python environment in `.venv/` and installs Sphinx:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r docs/requirements.txt
```

In every new terminal, activate it again with `source .venv/bin/activate`
before building.

### Step 4. Build the site once, before changing anything

```bash
make -C docs html
```

It takes a few minutes the first time. When it finishes without errors, open
`docs/build/html/index.html` in your browser. Now you know your setup works,
so any error you see later comes from your changes.

### Step 5. Create a branch for your change

Always start from an up-to-date `master`:

```bash
git switch master
git pull                      # if you use a fork: git pull upstream master
git switch -c docs/<short-description>
```

Branch names are lowercase words joined by `-`, with a prefix:

| Prefix | Use for | Example |
|--------|---------|---------|
| `docs/` | New pages or new content | `docs/gromacs-2026.1` |
| `fix/` | Corrections to existing pages or to the build | `fix/wrf-module-name` |
| `chore/` | Tooling, configuration, dependencies | `chore/update-sphinx` |

### Step 6. Write your page

1. Find your page type in [Where does my page go?](#4-where-does-my-page-go)
   and copy the template to its place. For example, for Minimap2 2.28:

   ```bash
   mkdir -p docs/source/software/applications/minimap2/2.28
   cp docs/contributing/templates/software-version.rst \
      docs/source/software/applications/minimap2/2.28/index.rst
   ```

2. Each template is a short example page. Replace the example with your
   content: the label on the first line, the title, the metadata block and
   the text. Delete the sections you don't need and the comment at the top.
3. Add the page to the toctree of its parent `index.rst`
   (see [How a page reaches the website](#3-how-a-page-reaches-the-website)).
4. If you are new to reStructuredText, keep the
   [cheat sheet](docs/contributing/rst-cheatsheet.md) open while you write,
   and follow the [style guide](docs/contributing/style-guide.md).

### Step 7. Build and preview

```bash
make -C docs html
```

If it fails, see [When the build fails](#6-when-the-build-fails). When it
passes, refresh `docs/build/html/index.html` in the browser and check your
page: that it appears in the menu, that code blocks and lists look right, and
that images and links work.

If you renamed or deleted files, build from scratch to catch stale
references: `make -C docs clean html`.

### Step 8. Commit

```bash
git status                    # review which files you changed
git add <files>
git commit
```

Keep each commit about one thing. The first line of the message follows the
format used in this repository's history:

```
<type>(docs): <what changed, in the imperative, lowercase>
```

For example:

```
docs: add Flye 2.9.6 page
fix(docs): correct the module name in the WRF 4.7.1 example
```

Below the first line, leave a blank line and explain **why** the change was
needed if it is not obvious.

### Step 9. Push and open a pull request

```bash
git push -u origin <your-branch>
```

Git prints a link to create the pull request; open it (or go to the
repository on GitHub and click **Compare & pull request**). Make sure the
base branch is **`master`** of `eafit-apolo/apolo-users`. In the description,
write:

- **What** you changed and **why**.
- **How you verified it**: at least that `make -C docs html` passes, and what
  you checked on the cluster (for example, that the commands run).
- **Anything the reviewer must decide**, separate from the rest.
- The [checklist](#checklist), with the boxes ticked.

### Step 10. Review and merge

A maintainer reviews the pull request and may ask for changes. To apply them,
edit the files on the same branch, commit and `git push` again: the pull
request updates by itself. **Do not merge your own pull request**; the
maintainer merges it once it is approved, and Read the Docs publishes the new
version a few minutes later.

## 6. When the build fails

Sphinx prints each problem as `file:line: WARNING/ERROR: message`. Go to that
file and line. These are the most common messages, exactly as Sphinx prints
them:

| Message | What it means | How to fix it |
|---------|---------------|---------------|
| `document isn't included in any toctree` | The page exists but no toctree lists it. | Add it to the toctree of its parent `index.rst`. |
| `toctree contains reference to nonexisting document 'x'` | A toctree lists a file that does not exist. | Check the path: relative to that `index.rst`, without `.rst`, same spelling and case. |
| `Title underline too short.` | The line of `=`, `-`, `~` under a heading is shorter than the heading. | Make the underline at least as long as the heading text. |
| `undefined label: 'x'` | A `:ref:` points to a label that does not exist. | Check the spelling against the `.. _label:` line of the target page. |
| `duplicate label x, other instance in y.rst` | Two pages declare the same label. | Rename the label in your page; labels must be unique in the whole site. |
| `image file not readable: images/x.png` | The image path is wrong or the file was not added. | Paths are relative to the `.rst` file; check spelling and case. |
| `Unexpected indentation.` | A line is indented more than the line above, outside a directive. | Remove the extra spaces, or add a blank line before an indented block. |
| `Explicit markup ends without a blank line; unexpected unindent.` | A directive (`.. note::`, `.. code-block::`) is followed by text that is not indented and not separated by a blank line. | Indent the directive's content 3 spaces and leave a blank line after it. |
| `Error in "code-block" directive: maximum 1 argument(s) allowed` | The code starts right under `.. code-block:: bash` with no blank line. | Leave one blank line between the directive (and its options) and the code. |
| `Content block expected for the "note" directive; none found.` | The admonition has no indented content. | Indent the text 3 spaces under `.. note::`, after a blank line. |
| `Unknown directive type "x".` | A misspelled directive, e.g. `code-blok`. | Fix the spelling. |
| `Inline literal start-string without end-string.` | A ` `` ` was opened and never closed. | Close it: ` ``like this`` `. |

The [cheat sheet](docs/contributing/rst-cheatsheet.md#the-three-rules-that-break-the-build)
explains the indentation and blank-line rules behind most of these errors.

## Checklist

Copy this into your pull request description and tick each box:

```markdown
- [ ] `make -C docs html` passes with no warnings
- [ ] New pages start from a template and are listed in a toctree
- [ ] File and directory names are lowercase, with `-` between words
- [ ] Every new page has a unique label and a metadata block
      (Authors, Maintainer, Last reviewed)
- [ ] Every code block declares a language, and the commands were tested on the cluster
- [ ] Slurm job scripts start from the script in the templates
- [ ] Images have alt text
- [ ] No passwords, tokens, personal emails or other sensitive data
```

## Getting help

- **Questions about this process or about where something goes:** open an
  [issue](https://github.com/eafit-apolo/apolo-users/issues) or write to
  apolo@eafit.edu.co.
- **reStructuredText syntax:** the [cheat sheet](docs/contributing/rst-cheatsheet.md).
- **How to write a page:** the [style guide](docs/contributing/style-guide.md).
