.. _SBCL_2.4.0:

************
SBCL 2.4.0
************

- **Installation date:** 2026-10-02
- **Version:** 2.4.0
- **URL:** https://www.sbcl.org
- **Installed on:** Apolo II

.. contents:: Table of Contents

Description
-----------

SBCL (Steel Bank Common Lisp) is a high-performance Common Lisp compiler. It is an open source derivation of CMUCL, providing an interactive environment with a high-performance native compiler, debugger, and profiling support.

Usage
-----

To use SBCL 2.4.0, run the following commands:

.. code-block:: bash

    module load sbcl/2.4.0
    # Check version
    sbcl --version

Installation
------------

1. Download the binary distribution for Linux x86-64 from SourceForge:

.. code-block:: bash

    wget https://sourceforge.net/projects/sbcl/files/sbcl/2.4.0/sbcl-2.4.0-x86-64-linux-binary.tar.bz2
    tar -xjf sbcl-2.4.0-x86-64-linux-binary.tar.bz2
    cd sbcl-2.4.0-x86-64-linux

2. Install SBCL into the target local directory using the environment variable:

.. code-block:: bash

    INSTALL_ROOT=$HOME/sbcl-2.4.0 sh install.sh

3. Create and load the Lmod Lua module:

.. code-block:: bash

    module load sbcl/2.4.0

4. Verify the installation:

.. code-block:: bash

    sbcl --version

References
----------

- https://www.sbcl.org/manual/

Author
------

- Installed by: Emanuell Torres López
