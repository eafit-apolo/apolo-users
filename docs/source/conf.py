# -*- coding: utf-8 -*-

import os
import sys

# -- General configuration ------------------------------------------------

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.doctest',
    'sphinx.ext.todo',
    'sphinx.ext.coverage',
    'sphinx.ext.mathjax',
    'sphinx.ext.ifconfig',
    'sphinx.ext.viewcode',
    'sphinx.ext.githubpages'
]

templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'

# Project information
project = 'apolo-docs'
copyright = 'Creative Commons Attribution-NonCommercial 4.0 International License'
author = 'Centro de Computacion Cientifica Apolo - Universidad EAFIT'

version = '0.1'
release = '0.1'

language = 'en'
exclude_patterns = []
pygments_style = 'sphinx'
todo_include_todos = True

# -- Options for HTML output ----------------------------------------------

html_theme = 'sphinx_rtd_theme'

html_theme_options = {
    'logo_only': True,
    'style_nav_header_background': '#003d82',
}

html_static_path = ['_static']
html_css_files = ['css/theme_overrides.css']

html_context = {
    'display_github': True,
    'github_user': 'Emanuell117',
    'github_repo': 'apolo-users',
}

html_logo = '_static/apolo-white.png'

# -- Options for HTMLHelp output ------------------------------------------

htmlhelp_basename = 'apolo-docsdoc'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {}

latex_documents = [
    (
        master_doc,
        'apolo-docs.tex',
        'Apolo Scientific Computing Center Documentation',
        'The Apolo Team',
        'manual'
    ),
]

# -- Options for manual page output ---------------------------------------

man_pages = [
    (master_doc, 'apolo-docs', 'apolo-docs Documentation', [author], 1)
]

# -- Options for Texinfo output -------------------------------------------

texinfo_documents = [
    (
        master_doc,
        'apolo-docs',
        'apolo-docs Documentation',
        author,
        'apolo-docs',
        'One line description of project.',
        'Miscellaneous'
    ),
]

# -- Options for Epub output ----------------------------------------------

epub_title = project
epub_author = author
epub_publisher = author
epub_copyright = copyright
epub_exclude_files = ['search.html']

# -- Options for the linkcheck builder ------------------------------------

linkcheck_ignore = [r'https://leto.eafit.edu.co']
