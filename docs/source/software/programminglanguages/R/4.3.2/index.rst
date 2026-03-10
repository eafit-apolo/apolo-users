.. _R_4.3.2:

***
R 4.3.2
***

- **Installation date:** 2025-12-01
- **Version:** 4.3.2
- **URL:** https://www.r-project.org

.. contents:: Table of Contents

Description
-----------

R is a language and environment for statistical computing and graphics.
It provides a wide variety of statistical and graphical techniques, and is
highly extensible through packages.

Usage
-----

To use R 4.3.2, run the following commands:

.. code-block:: bash

   module load R/4.3.2

   # Start R interactive session
   R

   # Run R script
   Rscript script.R

   # Check version
   R --version

Installation
------------

1. Load the necessary modules:

.. code-block:: bash

   module load gnu14

2. Download and compile the software:

.. code-block:: bash

   # Create installation directory
   mkdir -p ~/R
   cd ~/R

   # Download source code
   wget https://cran.r-project.org/src/base/R-4/R-4.3.2.tar.gz
   tar -xzvf R-4.3.2.tar.gz
   cd R-4.3.2

   # Configure without Java and X11 support
   ./configure --prefix=$HOME/R/local \
               --enable-R-shlib \
               --with-readline=no \
               --with-x=no \
               --without-cairo \
               --without-tcltk \
               --without-java

   # Compile and install
   make
   make install

References
----------

- R Project: https://www.r-project.org
- CRAN: https://cran.r-project.org
- R Documentation: https://www.rdocumentation.org

Author
------

- Installed by: Emanuell Torres Lòpez
