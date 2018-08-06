.. _bayescan-2.1-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

BayeScan-2.1
===============

Basic information
-----------------

- **Deploy date:** 23 July 2018
- **Official Website:** http://cmpg.unibe.ch/software/BayeScan/index.html
- **License:** GNU General Public License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`


Installation
------------
#. Get the current **BayeScan** version from the Official Page and get into source directory.
   
   .. code-block:: bash
		
      wget http://cmpg.unibe.ch/software/BayeScan/files/BayeScan2.1.zip
      upzip BayesScan2.1.zip
      cd BayeScan/source
		   
#. Modifie the ``Makefile`` inorder to use *icpc* ``Intel Compiler``, instead of *g++*.

.. literalinclude:: scr/Makefile
   :language: bash
   :caption: :download:`Makefile <scr/Makefile>`

#. Compile **BayeScan**

   .. code-block:: bash
		
      make -j4  

   .. note::
      Remember to load in your current environment the newest version of ``Intel Compiler``.
      In this case, is important to use an ``Intel Compiler`` with ``OpenMP`` suport. For example, we do this in Apolo:

      .. code-block:: bash
 
	  module load intel/2017_update-1

#. Finally, create the installation directory and move the produced executable
	     
    .. code-block:: bash
		
        mkdir -p /share/apps/bayescan/2.1_intel-2017_update-1/bin     
        mv bayescan_2.1 /share/apps/bayescan/2.1_intel-2017_update-1/bin/bayescan

	
Usage
-----

.. code-block:: bash
		
   module load bayescan
   bayescan -h

Module file
-----------

.. literalinclude:: scr/2.1
   :language: tcl
   :caption: :download:`Module file <scr/2.1>`

	  
Authors
-------

- Juan David Arcila-Moreno <jarcil13@eafit.edu.co>
		       
