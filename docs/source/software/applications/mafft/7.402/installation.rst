.. _maff-7.402-installation:

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents

   .. contents::
      :depth: 2
      :local:

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- **Compiler:** Intel Parallel Studio XE Compiler Cluster Edition :math:`\boldsymbol{\ge}` 17.0.1.
- **Optional extensions:**

  * `Mxscarna <https://www.ncrna.org/softwares/mxscarna/>`_ (Included in the mafft-7.402-with-extensions-src.tgz package)
    
  * `Foldalign <https://rth.dk/resources/foldalign/>`_ :math:`\boldsymbol{\ge}` 2.5.1
  
  * `Contrafold <http://contra.stanford.edu/contrafold/>`_ :math:`\boldsymbol{\ge}` 2.02

Build process
-------------

.. note::

   * In :ref:`Apolo II <about_apolo-ii>` was used the Intel Compiler 17.0.1.
     :bash:`module load intel/2017_Update-1`
   
   * In :ref:`Cronos <about_cronos>` was used the Intel Compiler 18.0.2.
     :bash:`module load intel/18.0.2`
   

#. Download the package and decompress it.
   
   .. code-block:: bash

      wget https://mafft.cbrc.jp/alignment/software/mafft-7.402-with-extensions-src.tgz
      tar xfvz mafft-7.402-with-extensions-src.tgz

#. Enter in core directory and open the Makefile wit the editor of your choice.
   
   .. code-block:: bash

      cd mafft-7.402-with-extensions/core
      emacs -nw Makefile
   
#. Change the PREFIX (line 1) with the path where you want the program and change the compiler (line 18) and its flags.
   
   :download:`Makefile (Apolo II Intel 17.0.1) <src/apolo-mafft-Makefile>`

   :download:`Makefile (Cronos Intel 18.0.2) <src/cronos-mafft-Makefile>`

   From:

   .. code-block:: bash
   
      PREFIX = /usr/local   
      CC = gcc
      #CC = icc
      CFLAGS = -03
   To:

   .. code-block:: bash
		   
      PREFIX = /your/path
      #CC = gcc
      CC = icc
      CFLAGS = -03 -fast


#. Load the intel compiler, compile it and install.

   .. code-block:: bash

      module load intel/2017_update-1
      make clean
      make
      make install

Extensions
^^^^^^^^^^

Mxscarna
........

#. Edit the make file with the compiler of your choice.

   :download:`Makefile <src/mxscarna-Makefile>`

   :bash:`mafft-7.402-with-extensions/extensions/mxscarna_src/Makefile`

   From:
   
   .. code-block:: bash
      
      CXX = g++
   To:

   .. code-block:: bash

      CXX = icpc


#. Compile and install.

   .. code-block:: bash

      module load intel/2017_update-1
      make clean
      make
      make install
      cd ../
      chmod 755 mxcarna_src/

Foldalign
.........

#. Download and copy in the extensions directory the foldalign package.

   .. code-block:: bash

      wget https://rth.dk/resources/foldalign/software/foldalign.2.5.1.tgz
      tar xfvz foldalign.2.5.1.tgz
      cp foldalign mafft-7.402-with-extensions/extensions/

#. Change the compiler on the makefile (line 113).
   
   :download:`Makefile <src/foldalign-Makefile>`

   :bash:`mafft-7.402-with-extensions/src/mafft-7.402-with-extensions/extensions/foldalign/Makefile`

   .. code-block:: bash

      emacs -nw Makefile
from:

   .. code-block:: c++

      cc = g++
To:

   .. code-block:: c++

      cc = icpc

#. Compile and change permissions.

   .. code-block:: bash

      module load intel/2017_update-1
      make clean
      make
      cd ../
      chmod 755 foldalign/

Contrafold
..........

#. Download and copy in the extensions directory the contrafold package.

   .. code-block:: bash

      wget http://contra.stanford.edu/contrafold/contrafold_v2_02.tar.gz
      tar xfvz contrafold_v2_02
      cp  contrafold_v2_02/contrafold mafft-7.402-with-extensions/extensions/

#. Compile and change permissions.

   .. code-block:: bash

      cd contrafold/src/
      module load intel/2017_update-1
      module load openmpi/1.8.8-x86_64_intel-2017_update-1
      make clean
      make intelmulti
      cd ../..
      chmod 755 contrafold/

Troubleshooting
,,,,,,,,,,,,,,,

.. _mafft-7.402-installation-troubleshooting:

When you try to compile contrafold, it prints:

.. code-block:: bash

   perl MakeDefaults.pl contrafold.params.complementary contrafold.params.noncomplementary contrafold.params.profile
   g++ -O3 -DNDEBUG -W -pipe -Wundef -Winline --param large-function-growth=100000 -Wall  -c Contrafold.cpp
   In file included from LBFGS.hpp:52,
                 from InnerOptimizationWrapper.hpp:12,
                 from OptimizationWrapper.hpp:12,
                 from Contrafold.cpp:16:
   LBFGS.ipp: En la instanciación de ‘Real LBFGS<Real>::Minimize(std::vector<_Tp>&) [con Real = double]’:
   OptimizationWrapper.ipp:260:9:   se requiere desde ‘void OptimizationWrapper<RealT>::LearnHyperparameters(std::vector<int>, std::vector<_Tp>&) [con RealT = double]’
   Contrafold.cpp:451:9:   se requiere desde ‘void RunTrainingMode(const Options&, const std::vector<FileDescription>&) [con RealT = double]’
   Contrafold.cpp:68:54:   se requiere desde aquí
   LBFGS.ipp:110:33: error: ‘DoLineSearch’ no se declaró en este ámbito, y no se encontraron declaraciones en la búsqueda dependiente de argumentos en el punto de la instanciación [-fpermissive]
         Real step = DoLineSearch(x[k%2], f[k%2], g[k%2], d,
                     ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
                                  x[(k+1)%2], f[(k+1)%2], g[(k+1)%2],
                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                  Real(0), std::min(Real(10), MAX_STEP_NORM / std::max(Real(1), Norm(d))));
                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   LBFGS.ipp:110:33: nota: no se encontraron declaraciones en la base dependiente ‘LineSearch<double>’ pur la búsqueda no calificada
   LBFGS.ipp:110:33: nota: use ‘this->DoLineSearch’ en su lugar
   make: *** [Makefile:47: Contrafold.o] Error 1

Or something similar about a compilation error, it appears because in Utilities.hpp is missing an include.

#. Open Utilities.hpp and add the limits.h library.
   
   :download:`Utilities.hpp <src/Utilities.hpp>`

   .. code-block:: bash

      emacs -nw Utilities.hpp

   .. code-block:: c++

      #define UTILITIES_HPP
      
      #include <limits.h> // The library to add
      #include <algorithm>

#. Then compile again.

   .. code-block:: bash

      make intelmulti

Module Files
------------
Apolo II
^^^^^^^^

.. literalinclude:: src/7.402-with-extensions_intel-17.0.1
   :language: tcl
   :caption: :download:`7.402-with-extensions_intel-17.0.1 <src/7.402-with-extensions_intel-17.0.1>`

Cronos
^^^^^^

.. literalinclude:: src/7.402-with-extensions_intel-18.0.2
   :language: tcl
   :caption: :download:`7.402-with-extensions_intel-18.0.2 <src/7.402-with-extensions_intel-18.0.2>`

