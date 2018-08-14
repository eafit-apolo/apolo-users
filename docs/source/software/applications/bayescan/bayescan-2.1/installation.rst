.. _bayescan-2.12-installation:

.. role:: bash(code)
	  :language: bash

.. role:: raw-html(raw)
	  :format: html

.. contents:: Contents
	  :local:

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Compiler:** Intel Parallel Studio XE Cluster Edition :math:`\boldsymbol{\ge}` 17.0.1


Build process
-------------
							       							
#. Get the current **BayeScan** version from the Official Page and get into source directory.

   .. code-block:: bash

      wget http://cmpg.unibe.ch/software/BayeScan/files/BayeScan2.1.zip
      upzip BayesScan2.1.zip
      cd BayeScan/source

#. Modifie the ``Makefile`` in order to use *icpc* ``Intel Compiler``, instead of *g++*.

   .. literalinclude:: src/Makefile
	:language: bash
	:caption: :download:`Makefile <src/Makefile>`


#. Compile **BayeScan**
		     
    .. code-block:: bash

	make

    .. note::
	You must load in your current environment a version of ``Intel Compiler`` with ``OpenMP``
        suport.
       
        In the case of Apolo:

	.. code-block:: bash

	     module load intel/2017_update-1

	In the case of Cronos:     

	.. code-block:: bash

	     module load intel/intel-18.0.2


#. Finally, create the installation directory and move the produced executable
		
   **Apolo**
   
	.. code-block:: bash

	       mkdir -p /share/apps/bayescan/2.1_intel-2017_update-1/bin
	       mv bayescan_2.1 /share/apps/bayescan/2.1_intel-2017_update-1/bin/bayescan

   **Cronos**
   
	.. code-block:: bash

		mkdir -p /share/apps/bayescan/2.1_intel-18.0.2/bin
		mv bayescan_2.1 /share/apps/bayescan/2.1_intel-18.0.2/bin/bayescan

					
Modulefile
----------

**Apolo II**

.. literalinclude:: src/2.1_apolo
       :language: tcl
       :caption: :download:`Module file <src/2.1_apolo>`


**Cronos**

.. literalinclude:: src/2.1_cronos
	:language: tcl
	:caption: :download:`Module file <src/2.1_cronos>`
							  
					 
