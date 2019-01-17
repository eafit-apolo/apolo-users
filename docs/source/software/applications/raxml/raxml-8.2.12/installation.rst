.. _raxml-8.2.12-installation:

.. role:: bash(code)
    :language: bash

.. role:: raw-html(raw)
   :format: html

.. role:: matlab(code)
   :language: matlab

.. contents:: Contents
   :local:

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Compiler:** Intel Parallel Studio XE Cluster Edition
  :math:`\boldsymbol{\ge}` 17.0.1
* **MPI:** Intel MPI :math:`\boldsymbol{\ge}` 17.0.1
* **Scheduler:** SLURM :math:`\boldsymbol{\ge}` 16.05.6


Build process
-------------

#. Get source code from the github repository
   (`RAxML Releases <https://github.com/stamatak/standard-RAxML/releases>`_).

   .. code-block:: bash

      cd ~/apps/raxml/src/intel
      wget https://github.com/stamatak/standard-RAxML/archive/v8.2.12.tar.gz
      tar -zxvf v8.2.12.tar.gz

#. To build RAxML follow next steps:

   **Apolo II**

   #. Create a new Makefile for your particular environment

      (i.e. *AVX2* instruction set and the supported MPI implementation)

      .. code-block:: bash

         # Go to source directory
         cd standard-RAxML-8.2.12
         # Load the necessary environment
         module load impi/2017_update-1
         # Create a new Makefile
         cp Makefile.AVX2.HYBRID.gcc Makefile.AVX2.HYBRID.icc

   #. Add Intel MPI support editing the *Makefile* (**Makefile.AVX2.HYBRID.icc**)

      .. code-block:: bash

         # From
         CC = mpicc
         # To
         CC = mpiicc

   #. Build RAxML and deploy it

      .. code-block:: bash

         make -f Makefile.AVX2.HYBRID.icc 2>&1 | tee raxml-make.log
         sudo mkdir -p /share/apps/raxml/8.2.12/intel-17.0.1/bin
         sudo cp raxmlHPC-HYBRID-AVX2 /share/apps/raxml/8.2.12/intel-17.0.1/bin

      .. note::

         If something goes wrong, check the **raxml-make.log** file to review
         the build process.

|

   **Cronos**


   #. Create a new Makefile for your particular environment

      (i.e. *AVX* instruction set and the supported MPI implementation)

      .. code-block:: bash

         # Go to source directory
         cd standard-RAxML-8.2.12
         # Load the necessary environment
         module load impi/18.0.2
         # Create a new Makefile
         cp Makefile.AVX.HYBRID.gcc Makefile.AVX.HYBRID.icc

   #. Add Intel MPI support editing the *Makefile* (**Makefile.AVX.HYBRID.icc**)

      .. code-block:: bash

         # From
         CC = mpicc
         # To
         CC = mpiicc

   #. Build RAxML and deploy it

      .. code-block:: bash

         make -f Makefile.AVX.HYBRID.icc 2>&1 | tee raxml-make.log
         sudo mkdir -p /share/apps/raxml/8.2.12/intel-18.0.2/bin
         sudo cp raxmlHPC-HYBRID-AVX /share/apps/raxml/8.2.12/intel-18.0.2/bin

      .. note::

         If something goes wrong, check the **raxml-make.log** file to review
         the build process.


Modulefile
----------

**Apolo II**

.. literalinclude:: src/8.2.12_intel-17.0.1_apolo-ii
   :language: tcl
   :caption: :download:`Module file <src/8.2.12_intel-17.0.1_apolo-ii>`


**Cronos**

.. literalinclude:: src/8.2.12_intel-18.02_cronos
   :language: tcl
   :caption: :download:`Module file <src/8.2.12_intel-18.02_cronos>`
