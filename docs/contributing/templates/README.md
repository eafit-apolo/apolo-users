# Templates

Each file here is a short **example page**. Copy the one that matches what
you want to write, and replace the example with your content.

| I want to write about… | Copy | Example inside |
|------------------------|------|----------------|
| A program that is not documented yet | [`software-overview.rst`](software-overview.rst) **and** [`software-version.rst`](software-version.rst) | Minimap2, version 2.28 |
| A new version of a program already documented | [`software-version.rst`](software-version.rst) | Minimap2 2.28 |
| How to do one task | [`guide.rst`](guide.rst) | Compress results before downloading them |
| Teaching something from scratch | [`tutorial.rst`](tutorial.rst) | Job arrays |
| Problems and their fixes | [`troubleshooting.rst`](troubleshooting.rst) | Minimap2 errors |
| A rule users must follow | [`policy.rst`](policy.rst) | Use of the login nodes |
| Steps the staff follows | [`procedure.rst`](procedure.rst) | Take a node out of service |

## How to use one

For example, to document version 2.28 of Minimap2:

**1. Copy** the template to where the page goes (the first comment of each
template says where):

```bash
mkdir -p docs/source/software/applications/minimap2/2.28
cp docs/contributing/templates/software-version.rst \
   docs/source/software/applications/minimap2/2.28/index.rst
```

**2. Replace** the example with your content: the label on the first line,
the title, the `:Authors:`/`:Maintainer:`/`:Last reviewed:` block and the
text. Delete the sections you don't need and the comment at the top.

**3. Add the page to the menu** by listing it in the toctree of the
`index.rst` one level up, and build the site
(see [CONTRIBUTING.md](../../../CONTRIBUTING.md#step-7-build-and-preview)).
