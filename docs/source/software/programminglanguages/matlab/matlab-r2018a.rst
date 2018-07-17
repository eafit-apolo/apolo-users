.. _matlab-r2018a:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

Matlab - R2018a
===============

Basic information
-------------------

- **Deploy date:** 9 July 2018
- **Official Website:** https://www.mathworks.com
- **License:** Proprietary commercial software
- **End date:** 30 April 2019
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`, :ref:`Cronos <about_cronos>`

Requirements/Tested on
------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
* **MPI:** Intel MPI :math:`\boldsymbol{\ge}` 17.0.1 (Mandatory to use Infiniband networks)
* **Scheduler:** SLURM :math:`\boldsymbol{\ge}` 16.05.6
* **Application:** Matlab Client (Optional)
* **Extra Libraries:**
   
  * libXtst (:ref:`Troubleshooting <matlab-r2018a-missinglibs>`)

Installation
------------

Module file
-----------

Usage
-----

Troubleshooting
---------------

.. _matlab-r2018a-missinglibs:

#. When you ran the Matlab installer with the command :bash:`./install`, it 
   prints:
  
   .. code-block:: bash
     
      Preparing installation files ...
      Installing ...   
  
   Then a small Matlab window appears and after a while it closes and prints:

   .. code-block:: bash

      Finished

   To solve this problem, you have to find the root cause modifying 
   :bash:`$MATLABINSTALLERPATH/bin/glnxa64/install_unix` script to look the 
   :bash:`stderror` and understand what is happening.

   - At line *918* change this statement :bash:`eval "$java_cmd 2> /dev/null"` 
     to :bash:`eval "$java_cmd"`, by this way you can see the related errors 
     launching the Matlab installer. (i.e. missing library *libXtst.so.6*)
  

Authors
-------

- Mateo Gómez Zuluaga

