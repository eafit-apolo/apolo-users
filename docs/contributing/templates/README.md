# Page templates

Ready-to-copy starting points for new pages. They are outside
`docs/source/`, so they are never published.

**Which one do I need?** See
[Where does my page go?](../../../CONTRIBUTING.md#4-where-does-my-page-go)
in CONTRIBUTING.md.

| Template | Page type | Use it for |
|----------|-----------|------------|
| [`software-overview.rst`](software-overview.rst) | Software | The page that introduces a program and lists its versions (once per program) |
| [`software-version.rst`](software-version.rst) | Software | One installed version of a program: usage, example job, installation |
| [`guide.rst`](guide.rst) | Guide | One concrete user task, as directly as possible |
| [`tutorial.rst`](tutorial.rst) | Tutorial | Teaching something from scratch, step by step |
| [`troubleshooting.rst`](troubleshooting.rst) | Troubleshooting | Known problems and their fixes, organized by symptom |
| [`policy.rst`](policy.rst) | Policy | Rules users or staff must follow |
| [`procedure.rst`](procedure.rst) | Procedure | Exact steps staff follow for an operational task |
| [`page-metadata.rst`](page-metadata.rst) | (snippet) | The metadata block every page has under its title |

## How to use a template

1. **Copy** it to its place under `docs/source/` with its new name
   (lowercase, `-` between words).
2. **Read the comment at the top** of the file: it says exactly what to do
   for that type of page.
3. **Change the label** on the first line after the comment
   (`.. _guide-replace-me:` and so on) to a unique one.
4. **Replace** every `[bracketed text]`, `<placeholder>` and `YYYY-MM-DD`.
   Anything left in brackets appears on the published page.
5. **Delete** the instruction comments (the lines starting with `..` that
   explain what to write) and any optional section you do not need.
6. **Add the page to a toctree** and build the site
   (steps 6 and 7 of [CONTRIBUTING.md](../../../CONTRIBUTING.md#step-6-write-your-page)).

## What the markers mean

| Marker | Meaning | Example |
|--------|---------|---------|
| `[text in brackets]` | Write your own content here | `[Program name]` → `Flye` |
| `<text in angle brackets>` | A value the **reader** replaces; keep it in the published page | `<username>` |
| `YYYY-MM-DD` | A date, in this format | `2026-09-28` |
| `[A \| B]` | Pick one (or several) of the options | `[Apolo II \| Apolo 3]` → `Apolo 3` |
