.. _mafft-7.402-installation:

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

     * :bash:`module load intel/2017_Update-1`

   * In :ref:`Cronos <about_cronos>` was used the Intel Compiler 18.0.2.

     * :bash:`module load intel/18.0.2`

This entry described the installation process of MAFFT with extensions.

#. Get the MAFFT with the extensions package.

   .. code-block:: bash

      wget https://mafft.cbrc.jp/alignment/software/mafft-7.402-with-extensions-src.tgz
      tar xfvz mafft-7.402-with-extensions-src.tgz

#. Edit MAFFT's Makefile with the following lines.

   :bash:`mafft-7.402-with-extensions/core/Makefile`

   From:

   .. code-block:: bash

      PREFIX = /usr/local
      ...
      CC = gcc
      #CC = icc
      CFLAGS = -03
      ...

   To:

   .. code-block:: bash

      PREFIX = /your/path
      ...
      #CC = gcc
      CC = icc
      CFLAGS = -03 -fast
      ...


#. Load the necessary environment and build it.

   .. code-block:: bash

      module load intel/2017_update-1
      make clean
      make
      make install

Extensions
^^^^^^^^^^

This entry described the extension's installation process.

Mxscarna
........

MXSCARNA [1]_. (Multiplex Stem Candidate Aligner for RNAs) is a multiple alignment tool for RNA sequences using progressive alignment based on the pairwise structural alignment algorithm of SCARNA. This software is fast enough for large scale analyses, while the accuracies of the alignments are better than or comparable with the existing algorithms which are computationally much more expensive in time and memory.


#. Edit the Mxcarna's Makefile with the following lines.

   :bash:`mafft-7.402-with-extensions/extensions/mxscarna_src/Makefile`

   :download:`Makefile <src/mxscarna-Makefile>`


   From:

   .. code-block:: bash

      ...
      CXX = g++
      ...

   To:

   .. code-block:: bash

      ...
      CXX = icpc
      ...


#. Load the necessary environment and build it.

   .. code-block:: bash

      cd ../
      module load intel/2017_update-1
      make clean
      make
      make install

#. Move the binaries to libexec MAFFT directory.

   .. code-block:: bash

      cp mxscarna /you/path/to/maft/libexec/mafft/

Foldalign
.........

FOLDALIGN [2]_. an algorithm for local or global simultaneous folding and aligning two or more RNA sequences and is based on the Sankoffs algorithm (SIAM J. Appl. Math., 45:810-825, 1985). Foldalign can make pairwise local or global alignments and structure predictions. FoldalignM makes multiple global alignment and structure prediction.



#. Get the Foldalign package and move it to the MAFFT extension's directory.

   .. code-block:: bash

      wget https://rth.dk/resources/foldalign/software/foldalign.2.5.1.tgz
      tar xfvz foldalign.2.5.1.tgz
      cp foldalign mafft-7.402-with-extensions/extensions/
      cd mafft-7.402-with-extensions/extensions/foldalign

#. Edit Foldalign's Makefile with the following lines.

   :bash:`mafft-7.402-with-extensions/src/mafft-7.402-with-extensions/extensions/foldalign/Makefile`

   :download:`Makefile <src/foldalign-Makefile>`

   from:

      .. code-block:: c++

       ...
       cc = g++
       ...

   To:

      .. code-block:: c++

       ...
       cc = icpc
       ...

#. Load the necessary environment and build it.

   .. code-block:: bash

      module load intel/2017_update-1
      make clean
      make

#. Move the binaries to libexec MAFFT directory.

   .. code-block:: bash

      cp bin/* /you/path/to/maft/libexec/mafft/

Contrafold
..........

CONTRAfold [3]_. is a novel secondary structure prediction method based on conditional log-linear models (CLLMs), a flexible class of probabilistic models that generalize upon SCFGs by using discriminative training and feature-rich scoring. By incorporating most of the features found in typical thermodynamic models, CONTRAfold achieves the highest single sequence prediction accuracies to date, outperforming currently available probabilistic and physics-based techniques.

#. Get the Contrafold package and move it to the MAFFT extension's directory.

   .. code-block:: bash

      wget http://contra.stanford.edu/contrafold/contrafold_v2_02.tar.gz
      tar xfvz contrafold_v2_02
      cp  contrafold_v2_02/contrafold mafft-7.402-with-extensions/extensions/
      cd mafft-7.402-with-extensions/extensions

#. load the necessary environment and build it.

   .. code-block:: bash

      cd contrafold/src/
      module load intel/2017_update-1
      module load openmpi/1.8.8-x86_64_intel-2017_update-1
      make clean
      make intelmulti

#. Move the binaries to libexec MAFFT directory.

   .. code-block:: bash

      cp contrafold /you/path/to/maft/libexec/mafft/

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

#. Edit Utilities.hpp and add the *limits.h* library.

   :bash:`mafft-7.402-with-extensions/extensions/contrafold/src/Utilities.hpp`

   :download:`Utilities.hpp <src/Utilities.hpp>`

   from:

      .. code-block:: c++

       #define UTILITIES_HPP

       #include <algorithm>
       ...

   To:

      .. code-block:: c++

       #define UTILITIES_HPP

       #include <limits.h>
       #include <algorithm>
       ...

#. Repeat step 2.


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

.. [1] MXSCARNA. (n.d.). Retrieved August 10, 2018, from https://www.ncrna.org/softwares/mxscarna/

.. [2] Foldalign: RNA Structure and Sequence Alignment. (n.d.). From https://rth.dk/resources/foldalign/

.. [3] Do, C., & Marina, S. (n.d.). Contrafold: CONditional TRAining for RNA Secondary Structure Prediction. From http://contra.stanford.edu/contrafold/
