.. _flye_2.9.6:

***
Flye 2.9.6
***

- **Installation date:** 2025-05-11
- **URL:** https://github.com/fenderglass/Flye

.. contents:: Table of Contents

Prerequisites
-------------

- Python 2.7 or 3.5+ (with setuptools package installed)
- C++ compiler with C++11 support (GCC 4.8+ / Clang 3.3+ / Apple Clang 5.0+)
- GNU make
- Git
- Core OS development headers (zlib, etc.)

Usage
-----

To use Flye 2.9.6, run the following commands:

.. code-block:: bash

   module load flye
   # To verify if Flye was installed correctly
   flye --version

Installation
------------

1. Load the necessary modules:

.. code-block:: bash

   module load python cmake gcc

2. Download and compile the software:

.. code-block:: bash

   git clone https://github.com/fenderglass/Flye
   cd Flye
   make

References
----------

- https://github.com/fenderglass/Flye
- https://github.com/fenderglass/Flye/blob/flye/docs/INSTALL.md

Author
------

- Emanuell Torres Lopez
