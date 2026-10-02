.. _Maxima_5.43.2:

**************
Maxima 5.43.2
**************

- **Installation date:** 2026-10-02
- **Version:** 5.43.2
- **URL:** https://maxima.sourceforge.io
- **Installed on:** Apolo II

.. contents:: Table of Contents

Dependencies
------------

- **SBCL (Steel Bank Common Lisp):** Version 2.4.0 (configured as the underlying Lisp engine).
- **GNU Make & GCC:** Standard compilation toolchain available on Rocky Linux 9.8.

Usage
-----

To use Maxima 5.43.2, run the following commands:

.. code-block:: bash

    module load maxima/5.43.2
    # Check version
    maxima --version

Installation
------------

1. Download the source code of Maxima from SourceForge:

.. code-block:: bash

    wget https://sourceforge.net/projects/maxima/files/Maxima-source/5.43.2-source/maxima-5.43.2.tar.gz
    tar -xzf maxima-5.43.2.tar.gz
    cd maxima-5.43.2

2. Configure Maxima using SBCL as the Lisp engine:

.. code-block:: bash

    ./configure --prefix=$DIR --enable-sbcl --with-sbcl=$SBCL_PATH

3. Compile and install Maxima:

.. code-block:: bash

    LANG=C make
    sudo LANG=C make install

4. Verify the installation:

.. code-block:: bash

    maxima --version

References
----------

- https://maxima.sourceforge.io/es/documentation.html

Author
------

- Installed by: Emanuell Torres López
