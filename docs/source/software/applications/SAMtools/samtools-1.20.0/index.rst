.. _samtools-1.20.0-index:

.. role:: bash(code)
   :language: bash

Samtools 1.20.0
==============

.. contents:: Table of Contents

Basic information
------------------

- **Installation Date:** 17/06/2024
- **Official Website:** https://github.com/samtools/samtools
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **License:** GPL

Dependencies
------------

- gcc-11.2.0
- htslib


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` Rocky Linux (Green Obsidian 8.5)

Installation
------------

The easiest way to get Samtools is to clone the git repository straight from GitHub:

#. Copy the  files into a cluster location

   .. code-block:: bash

      $ git clone https://github.com/samtools/samtools



#. Get Dependencies:

At least the following are required:

    GNU make
    C compiler (e.g. gcc or clang)

In addition, building the configure script requires:

    autoheader
    autoconf
    autoreconf

Running the configure script uses awk, along with a number of
standard UNIX tools (cat, cp, grep, mv, rm, sed, among others).  Almost
all installations will have these already.


HTSlib uses the following external libraries.  Building requires both the
library itself, and include files needed to compile code that uses functions
from the library.  Note that some Linux distributions put include files in
a development ('-dev' or '-devel') package separate from the main library.

    zlib       (required)
    libbz2     (required, unless configured with --disable-bz2)
    liblzma    (required, unless configured with --disable-lzma)
    libcurl    (optional, but strongly recommended)
    libcrypto  (optional for Amazon S3 support; not needed on MacOS)
    libdeflate (optional, but strongly recommended for faster gzip)




htslib requires CMake (version >= 3.0). If you are missing CMake or have an older version, check your OS package manager (for Linux users) or download it here: http://www.cmake.org/cmake/resources/software.html .
    .. code-block:: bash
        $ cmake --version

#. Ok, now that you have CMake ready to go, let's build Hts. A good practice in building applications is to do an out-of-source build, meaning that we're going to set up an isolated place to hold all the intermediate installation steps. In the top-level directory of BamTools, type the following commands:.

    .. code-block:: bash

        $ ./configure
        $ cd /share/apps/samtools/1.20.0/gcc-11.2.0/
        $ cmake



#. After running cmake, just run:


    .. code-block:: bash
        $ sudo make prefix=/share/apps/samtools/1.20.0/gcc-11.2.0/ install







References
----------

.. [1] Twelve years of SAMtools and BCFtools
Petr Danecek, James K Bonfield, Jennifer Liddle, John Marshall, Valeriu Ohan, Martin O Pollard, Andrew Whitwham, Thomas Keane, Shane A McCarthy, Robert M Davies, Heng Li
GigaScience, Volume 10, Issue 2, February 2021, giab008, https://doi.org/10.1093/gigascience/giab008



Authors
-------

- Isis Amaya <icamayaa@eafit.edu.co>
- Santiago Arias <sariash@eafit.edu.co>
