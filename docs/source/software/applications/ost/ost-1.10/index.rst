.. _ost_1.10-index:

.. role:: bash(code)
   :language: bash

Openstructure 1.10
==================

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://openstructure.org
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Dependencies
------------

* Cmake 3.7.1
* Boost 1.62.0
* Zlib 1.2.11
* FFTW 3.3.5
* Python 2.7.15
* Sqlite 3.30.1
* Libtiff 4.1.0
* Libpng 1.6.37
* Eigen 3.3.7
* GCC 5.4.0

Installation
------------

#. Get source code.

   .. code-block:: bash

      $ git clone https://git.scicore.unibas.ch/schwede/openstructure.git

#. Load the dependences of Openstructure (It varies depending on the user's needs).

   .. code-block:: bash

      $ module load cmake/3.7.1
      $ module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64
      $ module load zlib/1.2.11_gcc-5.4.0
      $ module load fftw/3.3.5_gcc-5.4.0_openmpi-1.8.8-x86_64
      $ module load python/2.7.15_miniconda-4.5.4
      $ module load sqlite/3.30.1
      $ module load libtiff/4.1.0_intel-19.0.4
      $ module load libpng/1.6.37
      $ module load eigen/3.3.7_intel-19.0.4

#. Run the cmake according to the dependencies needed during the compilation.

   .. code-block:: bash

      $ CXXFLAGS="-fPIC -O3" cmake .. -DENABLE_GFX=OFF -DENABLE_INFO=OFF -DENABLE_IMG=ON -DPYTHON_ROOT=/share/apps/python/2.7_miniconda-4.5.4 -DPYTHON_LIBRARIES=/share/apps/python/2.7_miniconda-4.5.4/lib -DFFTW_LIBRARY=$FFTW_LIBRARY/libfftw3f.so -DFFTW_INCLUDE_DIR=$FFTW_INCLUDE_DIR -DBOOST_ROOT=$BOOST_ROOT -DEIGEN3_INCLUDE_DIR=$EIGEN_HOME/include/eigen3 -DSQLITE3_LIBRARY=$SQLITE_HOME/lib/libsqlite3.so.0.8.6 -DSQLITE3_INCLUDE_DIR=$SQLITE_HOME/include -DTIFF_LIBRARY=$LIBTIFF_HOME/lib/libtiff.so -DTIFF_INCLUDE_DIR=$LIBTIFF_HOME/include -DPNG_LIBRARY=$LIBPNG_HOME/lib/libpng.so -DPNG_INCLUDE_DIR=$LIBPNG_HOME/include -DZLIB_LIBRARY=$ZLIB_HOME/lib/libz.so -DZLIB_INCLUDE_DIR=$ZLIB_HOME/include -DPREFIX=/share/apps/openstructure/1.10/gcc-5.4.0

#. Compile and install openstructure

   .. code-block:: bash

      $ make
      $ make install

#. Create the corresponding module of Openstructure 1.10.

    .. code-block:: bash

      $ mkdir /share/apps/modules/openstructure
      $ vim /share/apps/modules/openstructure/1.10_gcc-5.4.0

      #%Module1.0#####################################################################
      ##
      ## modulefile /share/apps/openstructure/1.10/gcc-5.4.0/
      ##

      proc ModulesHelp { } {
           global version modroot
                puts stderr "\t Openstructure 1.10"
      }

      module-whatis "\n\n\tSets the environment for using Openstructure 1.10 \n"


      set     topdir          /share/apps/openstructure/1.10/gcc-5.4.0
      set     version         1.10
      set     sys             x86_64-redhat-linux

      module load cmake/3.7.1
      module load boost/1.62.0_gcc-5.4.0_openmpi-1.8.8-x86_64
      module load zlib/1.2.11_gcc-5.4.0
      module load fftw/3.3.5_gcc-5.4.0_openmpi-1.8.8-x86_64
      module load python/2.7.15_miniconda-4.5.4
      module load sqlite/3.30.1
      module load libtiff/4.1.0_intel-19.0.4
      module load libpng/1.6.37
      module load eigen/3.3.7_intel-19.0.4

      prepend-path PATH                       $topdir/bin
      prepend-path PYTHONPATH                 $topdir/lib64/python2.7/site-packages

      prepend-path C_INCLUDE_PATH             $topdir/include
      prepend-path CXX_INCLUDE_PATH           $topdir/include
      prepend-path CPLUS_INCLUDE_PATH         $topdir/include

      prepend-path LD_LIBRARY_PATH            $topdir/lib64
      prepend-path LIBRARY_PATH               $topdir/lib64
      prepend-path LD_RUN_PATH                $topdir/lib64

Authors
-------

- Juan Diego Ocampo García <jocamp18@eafit.edu.co>
