.. _bamtools-2.5.2-index:

.. role:: bash(code)
   :language: bash

BAMTOOLS 2.5.2
==============

.. contents:: Table of Contents

Basic information
------------------

- **Official Website:** https://github.com/pezmaster31/bamtools/wiki
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
 


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` Rocky Linux (Green Obsidian 8.5)

Installation
------------

The easiest way to get BamTools is to clone the git repository straight from GitHub:

#. Copy the three (3) iso files into a cluster location

   .. code-block:: bash

      $ git clone git://github.com/pezmaster31/bamtools.git



#. Get Dependencies:

BamTools has been migrated to a CMake-based build system. We believe that this should simplify the build process across all platforms, especially with the BamTools API now available primarily as a static or shared library (that you link to instead of compiling lots of source files directly into your application). CMake is available on all major platforms, and indeed comes out-of-the-box with many Linux distributions.

To see if you have CMake (and if so, which version) try this command:

    .. code-block:: bash
          $ cmake --version

BamTools requires CMake (version >= 3.0). If you are missing CMake or have an older version, check your OS package manager (for Linux users) or download it here: http://www.cmake.org/cmake/resources/software.html .

#. Ok, now that you have CMake ready to go, let's build BamTools. A good practice in building applications is to do an out-of-source build, meaning that we're going to set up an isolated place to hold all the intermediate installation steps. In the top-level directory of BamTools, type the following commands:.

    .. code-block:: bash

        $ mkdir build
        $ cd build
        $ cmake -DCMAKE_INSTALL_PREFIX=/share/apps/bamtools/2.5.2/gcc-11.2.0/



#. After running cmake, just run:

  
    .. code-block:: bash
        $ make install







References
----------

.. [1] Bamtools Github Repository.
       Retrieved June 18, 2024, from https://github.com/pezmaster31/bamtools 



Authors
-------

- Isis Amaya <icamayaa@eafit.edu.co>
- Santiago Arias <sariash@eafit.edu.co>
