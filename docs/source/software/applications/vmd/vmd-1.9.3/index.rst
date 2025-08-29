.. _vmd-1.9.3-index:

.. role:: bash(code)
   :language: bash

VMD 1.9.3
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.ks.uiuc.edu/Research/vmd/
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **License:**  UIUC Open Source License - http://www.ks.uiuc.edu/Research/vmd/current/LICENSE.html

Dependencies
------------

* Cuda 8.0
* GCC 5.4.0
* Python 2.7.15
* TCL 8.5

Installation
------------

#. Get source code from https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD.

   .. note:: Yo hould register before download it.

#. Create a folder for VMD and decompress tar file. It will take out two folders (vmd-1.9.3 and plugins)

   .. code-block:: bash


      $ tar -xvf vmd-1.9.3.src.tar.gz

#. Go to vmd-1.9.3 folder and create a new directory called plugins and save the path to it because it will be used in the following step.

   .. code-block:: bash

      $ cd vmd-1.9.3
      $ mkdir plugins

#. Before starting the compilation of vmd, we should compile plugins in the following way in the folder called plugins that was extracted in the first step.

   .. code-block:: bash

      $ cd plugins
      $ module load netcdf/4.5.0_intel-17.0.1
      $ module load gcc/7.4.0
      $ export PLUGINDIR=<path_to_new_folder_plugins>
      $ make LINUXAMD64 TCLINC=/usr/include TCLLIB=/usr/lib64/libtcl.so
      $ make distrib

#. Return to vmd-1.9.3 folder and edit configure.options file according to the tools and dependencies to use during the compilation.

   .. code-block:: bash

      $ vim configure.options
      $ LINUXAMD64 CUDA TCL PYTHON PTHREADS NUMPY ICC

#. Edit configure file and change the path of **$install_bin_dir** and **$install_library_dir** with the location bin and lib directories of vmd.

   .. code-block:: bash

      $ vim configure
      $ $install_bin_dir="<path_to_bin_vmd_dir>";
      $ $install_library_dir="<path_to_lib_vmd_dir>";

#. Run configure script.

   .. code-block:: bash

      $ ./configure

#. Go to src folder and edit the Makefile.

   .. code-block:: bash

      $ cd src
      $ vim Makefile

   .. note:: This file has a lot of paths that are not compatible because they are burned into the file.

   * Put the correct path for the following variables: INCDIRS and LIBDIRS.

   .. code-block:: bash

      INCDIRS = -I/share/apps/python/2.7_miniconda-4.5.4/include/python2.7 -I/share/apps/python/2.7_miniconda-4.5.4/lib/python2.7/site-packages/numpy/core/include -I/usr/include -I../plugins/include -I../plugins/LINUXAMD64/molfile -I.
      LIBDIRS     = -L/share/apps/cuda/8.0/lib64 -L/share/apps/python/2.7_miniconda-4.5.4/lib/python2.7/config -L/usr/lib64 -L../plugins/LINUXAMD64/molfile

   * Change NVCC binary with the correct path.

   .. code-block:: bash

      NVCC = /share/apps/cuda/8.0/bin/nvcc

   * Put the correct architecture of Apolo in NVCCFLAGS, it is important to notice that the maximum verion of cuda that VMD supports is 8.0 so it is not compatible with Tesla V100 GPUs in Apolo. K80 GPUS is architecture compute_37 and sm_37 for arch and code variables.

   .. code-block:: bash

      NVCCFLAGS   = --ptxas-options=-v -gencode arch=compute_37,code=sm_37 --ftz=true  --machine 64 -O3  -DARCH_LINUXAMD64 $(DEFINES) $(INCDIRS)

   * Also, change the GPU arthitecture in **.cu.ptx** section.

   .. code-block:: bash

      $(NVCC) $(DEFINES) --use_fast_math -I-L/share/apps/cuda/8.0/include -gencode arch=compute_37,code=sm_37 -ptx $< -o ../LINUXAMD64/$@

   * Change python version in LIBS, by default it will have python2.5.

   .. code-block:: bash

      LIBS = -Wl,-rpath -Wl,$$ORIGIN/ -lcudart_static -lpython2.7 -lpthread -lpthread  -ltcl8.5  -lmolfile_plugin -ll -lm -ldl -lutil -lrt $(VMDEXTRALIBS)

#. Load modules needed for compilation and check dependencies.

   .. code-block:: bash

      $ module load python/2.7.15_miniconda-4.5.4
      $ module load gcc/5.4.0
      $ module load cuda/8.0
      $ make depend

#. Finish with compilation and installation. Notice that in the process you should create folders for bin and lib specified in step 6.

   .. code-block:: bash

      $ mkdir -p /share/apps/vmd/1.9.3/bin
      $ mkdir -p /share/apps/vmd/1.9.3/lib
      $ make
      $ sudo make install

#. Create the corresponding module of VMD 1.9.3.

    .. code-block:: bash

       $ mkdir /share/apps/modules/vmd/
       $ vim /share/apps/modules/vmd/1.9.3

       #%Module1.0####################################################################
       ##
       ## module load vmd/1.9.3
       ##
       ## /share/apps/modules/vmd/1.9.3
       ## Written by Manuela Carrasco Pinzon
       ##

       proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using vmd 1.9.3\
                         \nin the shared directory /share/apps/vmd/1.9.3/"
       }

       module-whatis "(Name________) vmd"
       module-whatis "(Version_____) 1.9.3"
       module-whatis "(Compilers___) intel-17.0.1"
       module-whatis "(System______) x86_64-redhat-linux"
       module-whatis "(Libraries___) "

       # for Tcl script use only
       set         topdir        /share/apps/vmd/1.9.3
       set         version       1.9.3
       set         sys           x86_64-redhat-linux

       module load gcc/5.4.0
       module load cuda/8.0
       module load python/2.7.15_miniconda-4.5.4

       prepend-path    PATH                    $topdir/bin

       prepend-path    MANPATH                 $topdir/lib/doc

Authors
-------

- Juan Diego Ocampo García <jocamp18@eafit.edu.co>
