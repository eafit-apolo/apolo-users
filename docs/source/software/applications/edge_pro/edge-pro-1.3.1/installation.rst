.. _edge-pro-1.3.1-installation:

.. role:: bash(code)
	  :language: bash

.. role:: raw-html(raw)
	  :format: html

.. contents:: Contents
	  :local:

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Compiler:** Intel Parallel Studio XE Cluster Edition
  :math:`\boldsymbol{\ge}` 17.0.1


Build process
-------------

#. Get the current **EDGE-pro** version from the **official web page** and enter
   into the source directory.

   .. code-block:: bash

      wget http://ccb.jhu.edu/software/EDGE-pro/EDGE_pro_v1.3.1.tar.gz
      tar -xvf EDGE_pro_v1.3.1.tar.gz
      cd EDGE_pro_v1.3.1

#. You will notice that it just contains a simple source file. Build it.
   ``make`` will use the compiler you have loaded in your environment.

  .. code-block:: bash

     make

  .. note::
     You must load the necessary modules to build (i.e. ``Intel Compiler``).

     In Apolo II:
       .. code-block:: bash

          module load intel/2017_update-1

     In Cronos:
	 .. code-block:: bash

	    module load intel/intel-18.0.2

3. Create the installation directories. Move the built executable and other
   necessary scripts. The main script of **EDGE_pro** is ``edge.pl``, so is
   the only script we need to put in the ``PATH``.

 **Apolo**

 .. code-block:: bash

       mkdir -p /share/apps/edge_pro/1.3.1/intel-2017_update-1/bin
       mkdir -p /share/apps/edge_pro/1.3.1/intel-2017_update-1/scripts
       mv count additionalScripts /share/apps/edge_pro/1.3.1/intel-2017_update-1/scripts
       mv edge.pl /share/apps/edge_pro/1.3.1/intel-2017_update-1/bin

 **Cronos**

 .. code-block:: bash

       mkdir -p /share/apps/edge_pro/1.3.1/intel-18.0.2/bin
       mkdir -p /share/apps/edge_pro/1.3.1/intel-18.0.2/scripts
       mv count additionalScripts /share/apps/edge_pro/1.3.1/intel-18.0.2/scripts
       mv edge.pl /share/apps/edge_pro/1.3.1/intel-18.0.2/bin


4. Finally, we need to put the **bowtie** binaries in the ``scripts`` directory.
   Otherwise **EDGE-pro** will not find it, even if is load in the ``PATH``. To
   do this we use symbolic links:

 **Apolo**

 .. code-block:: bash

       cd /share/apps/edge_pro/1.3.1/intel-2017_update-1/scripts
       ln -s /share/apps/bowtie2/2.3.4.1/2017_update-1/bin/bowtie2-align-l bowtie2-align
       ln -s /share/apps/bowtie2/2.3.4.1/2017_update-1/bin/bowtie2-build bowtie2-build
       ln -s /share/apps/bowtie2/2.3.4.1/2017_update-1/bin/bowtie2 bowtie

 **Cronos**

 .. code-block:: bash

       cd /share/apps/edge_pro/1.3.1/intel-18.0.2/scripts
       ln -s /share/apps/bowtie2/2.3.4.1/intel-18.0.2/bin/bowtie2-align-l bowtie2-align
       ln -s /share/apps/bowtie2/2.3.4.1/intel-18.0.2/bin/bowtie2-build bowtie2-build
       ln -s /share/apps/bowtie2/2.3.4.1/intel-18.0.2/bin/bowtie2 bowtie2


Modulefile
----------

**Apolo II**

.. literalinclude:: src/1.3.1_apolo
       :language: tcl
       :caption: :download:`Module file <src/1.3.1_apolo>`


**Cronos**

.. literalinclude:: src/1.3.1_cronos
	:language: tcl
	:caption: :download:`Module file <src/1.3.1_cronos>`
