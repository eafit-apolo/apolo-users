.. _parallel-20260522-index:

.. role:: bash(code)
   :language: bash

.. role:: lua(code)
   :language: lua

========================
 GNU Parallel 20260522
========================

This documentation page describes the compilation and installation process of GNU Parallel using the ``gnu15`` toolchain on the Apolo cluster master node, following the OpenHPC module hierarchy convention.

.. contents::


Directory Hierarchy
===================

===================================  =================================================================
Description                          Path
===================================  =================================================================
Installation prefix                  /opt/ohpc/pub/libs/gnu15/parallel/20260522/
Executables                          /opt/ohpc/pub/libs/gnu15/parallel/20260522/bin/
Documentation (HTML, PDF, TEXI, RST) /opt/ohpc/pub/libs/gnu15/parallel/20260522/share/doc/parallel/
Man pages (section 1)                /opt/ohpc/pub/libs/gnu15/parallel/20260522/share/man/man1/
Man pages (section 7)                /opt/ohpc/pub/libs/gnu15/parallel/20260522/share/man/man7/
Bash completion                      /opt/ohpc/pub/libs/gnu15/parallel/20260522/share/bash-completion/completions/
Zsh completion                       /opt/ohpc/pub/libs/gnu15/parallel/20260522/share/zsh/site-functions/
Modulefile (Lmod, Lua)               /opt/ohpc/pub/moduledeps/gnu15/parallel/20260522.lua
===================================  =================================================================

.. note:: GNU Parallel is written in Perl. The ``configure``/``make``/``make install`` cycle does not generate compiled native binaries; it installs the Perl scripts, documentation, and man pages into the target prefix.

.. note:: The modulefile was placed under ``moduledeps/gnu15`` instead of directly under ``modulefiles/``, so that it is only visible once the ``gnu15`` module has been loaded. [1]_

Basic Information
=================

- **Deployment date:** July 22, 2026
- **Installed software version:** 20260522 ("Hantavirus")
- **Official website:** https://www.gnu.org/software/parallel
- **License:** GPLv3+
- **Toolchain:** gnu15

Concepts
========

* **Hierarchical modules (moduledeps):** OpenHPC convention where compiler-dependent software packages reside under :bash:`/opt/ohpc/pub/moduledeps/<compiler>/`, making them available via ``module avail`` only after loading the corresponding compiler module.

Installation
============

#. Download the official source tarball:

   .. code-block:: bash

      $ cd /tmp
      $ wget https://ftp.gnu.org/gnu/parallel/parallel-20260522.tar.bz2

#. Verify integrity before extracting:

   .. code-block:: bash

      $ file parallel-20260522.tar.bz2
      $ bzip2 -tvv parallel-20260522.tar.bz2

#. Extract the source code:

   .. code-block:: bash

      $ tar xjf parallel-20260522.tar.bz2
      $ cd parallel-20260522

#. Load the ``gnu15`` toolchain:

   .. code-block:: bash

      $ module load gnu15

#. Configure the build with the versioned installation prefix:

   .. code-block:: bash

      $ ./configure --prefix=/opt/ohpc/pub/libs/gnu15/parallel/20260522

#. Compile and install:

   .. code-block:: bash

      $ make
      $ make install

Configuration
=============

Module System (Lmod)
--------------------

Since ``gnu15`` already prepends its own dependency tree to ``MODULEPATH``:

.. code-block:: lua

   prepend_path("MODULEPATH", "/opt/ohpc/pub/moduledeps/gnu15")

the ``parallel`` modulefile does not need to explicitly declare ``depends_on("gnu15")``; visibility is guaranteed purely by the directory hierarchy.

#. Create the modulefile:

   .. literalinclude:: src/parallel-20260522.lua
      :language: lua

#. Load and validate:

   .. code-block:: bash

      $ module purge
      $ module load gnu15
      $ module avail parallel
      $ module load parallel/20260522
      $ which parallel
      $ parallel --version

Silence the Citation Notice (Optional)
--------------------------------------

By default, GNU Parallel prints an academic citation notice on the first execution for each user. To silence it globally across the cluster:

.. code-block:: bash

   $ mkdir -p /opt/ohpc/pub/libs/gnu15/parallel/20260522/etc
   $ touch /opt/ohpc/pub/libs/gnu15/parallel/20260522/etc/will-cite

and add to the modulefile:

.. code-block:: lua

   setenv("PARALLEL_HOME", "/opt/ohpc/pub/libs/gnu15/parallel/20260522/etc")


Troubleshooting
===============

Corrupt or Incomplete Tarball
-----------------------------

**ISSUE:** Extracting the downloaded tarball fails with:

.. code-block:: bash

   bzip2: Compressed file ends unexpectedly;
   perhaps it is corrupted?

**SOLUTION:** The download was incomplete or intercepted by a proxy/firewall on the master node. Re-download and verify the size and integrity before extracting:

.. code-block:: bash

   $ ls -lh parallel-20260522.tar.bz2
   $ file parallel-20260522.tar.bz2
   $ bzip2 -tvv parallel-20260522.tar.bz2

If the master node lacks direct internet access, download the tarball on a local machine and transfer it via :bash:`scp`, verifying the checksum on both ends using :bash:`sha256sum`.

404 Error when Downloading .tar.gz
----------------------------------

**ISSUE:** Downloading ``parallel-<version>.tar.gz`` returns ``HTTP 404``.

**SOLUTION:** GNU Parallel is distributed exclusively in ``.tar.bz2`` format on the GNU FTP server; there is no ``.tar.gz`` version available for this package. Use the ``.tar.bz2`` file, or ``parallel-latest.tar.bz2`` to always reference the most recent stable release.

``file`` Reports the Modulefile as ``ASCII text``
--------------------------------------------------

**ISSUE:** Running :bash:`file 20260522.lua` reports ``ASCII text``, whereas modulefiles for other packages (TCL format) report as ``modulefile``.

**SOLUTION:** This is expected and harmless. ``file`` recognizes the ``#%Module1.0`` header specific to classic Environment Modules in TCL; Lua-based Lmod modulefiles do not carry this header and are thus classified generally as plain text. Both formats are fully supported and parsed correctly by Lmod.
