.. _racket-8.16-index:


RACKET 8.16
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://racket-lang.org/
- **Downloads page:** https://download.racket-lang.org/
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

- **Compiler** GCC 8.5.0

Installation
-------------

#. First of all, we need to create a directory where we will build the software. In this case, we will create a directory called ``build_racket``

    .. code-block:: bash
        $ mkdir build_racket

#. Then, we need to download the source code of Racket. We can do this by using the `wget` command to download the installer script from the official website

    .. code-block:: bash
        $ wget https://download.racket-lang.org/releases/8.16/installers/racket-8.16-x86_64-linux-cs.sh

#. Then, we can execute the installer script to install Racket and follow the prompts to complete the installation, specifying the installation directory as `~/build_racket`

    .. code-block:: bash
        $ sh racket-8.16-x86_64-linux-cs.sh

#. Finally, we can add racket to our PATH environment variable

    .. code-block:: bash
        $ export PATH=$PATH:~/build_racket/bin

Author
------
 - Juan Manuel Gomez Piedrahita
