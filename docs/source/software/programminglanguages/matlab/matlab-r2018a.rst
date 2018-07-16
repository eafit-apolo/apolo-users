.. _matlab-r2018a:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

Matlab - R2018a
===============

.. contents:: Contents

Description
-----------

- **Deploy date:** 9 July 2018
- **Official Website:** https://www.mathworks.com
- **License:** Proprietary commercial software
- **End date:** 30 April 2019

Requirements
------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
* **MPI:** Intel MPI :math:`\ge` 17.0.1 (Mandatory to use Infiniband networks)
* **Scheduler:** SLURM :math:`\ge` 16.05.6
* **Application:** Matlab Client (Optional)
* **Extra Libraries:**  X11 Libs (details)
  
  * oe

Installation
------------

Module file
-----------

Usage
-----

Troubleshooting
---------------
.. _matlab-r2018a-missinglibs:

- When you ran the Matlab installer with the command :bash:`./install`, it
  prints:
  
  .. code-block:: bash
     
     Preparing installation files ...
     Installing ...   
  
  Then a small Matlab windows appears and immediately:

  .. code-block:: bash

     Finished


Authors
-------

- Mateo Gómez Zuluaga

