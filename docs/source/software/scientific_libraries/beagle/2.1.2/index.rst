.. _beagle-2.1.2-index:


Beagle 2.1.2
============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/beagle-dev/beagle-lib
- **License:** GNU GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II and Cronos
- **Installation date:** 08/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * Intel Parallel Studio XE Cluster Edition (2017-U1)
    * Cuda >= 7.0 (Opcional, soporte aceleradora)
    * Controlador NVIDIA en el Master (Opcional, soporte aceleradora)



Installation
------------

CUDA Support
~~~~~~~~~~~~

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/bpp/intel
        wget https://github.com/beagle-dev/beagle-lib/archive/beagle_release_2_1_2.tar.gz
        tar -zxvf beagle_release_2_1_2.tar.gz


#. After unpacking beagle, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd beagle-lib
        module load intel/2017_update-1
        module load cuda/7.0
        module load java/jdk-1.8.0_112
        ./configure --prefix=/share/apps/beagle-lib/2.1.2/cuda/7.0/intel/2017_update-1 --build=x86_64-redhat-linux --enable-static --with-cuda=/share/apps/cuda/7.0 2>&1 | tee beagle-conf.log
        # Ignorar el comentario de que OpenCL no puede ser detectado
        make 2>&1 | tee beagle-make.log
        sudo mkdir -p /share/apps/beagle-lib/2.1.2/cuda/7.0/intel/2017_update-1
        sudo chown -R mgomezzul.apolo /share/apps/beagle-lib/2.1.2/cuda/7.0/intel/2017_update-1
        make install 2>&1 | tee beagle-make-install.log
        sudo chown -R root.root /share/apps/beagle-lib/2.1.2/cuda/7.0/intel/2017_update-1



CPU Support
~~~~~~~~~~~

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/bpp/intel
        wget https://github.com/beagle-dev/beagle-lib/archive/beagle_release_2_1_2.tar.gz
        tar -zxvf beagle_release_2_1_2.tar.gz


#. After unpacking beagle, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd beagle-lib
        module load intel/2017_update-1
        module load java/jdk-1.8.0_112
        ./configure --prefix=/share/apps/beagle-lib/2.1.2/intel/2017_update-1 --build=x86_64-redhat-linux --enable-static 2>&1 | tee beagle-conf.log
        # Ignorar el comentario de que OpenCL no puede ser detectado
        make 2>&1 | tee beagle-make.log
        sudo mkdir -p /share/apps/beagle-lib/2.1.2/intel/2017_update-1
        sudo chown -R mgomezzul.apolo /share/apps/beagle-lib/2.1.2/intel/2017_update-1
        make install 2>&1 | tee beagle-make-install.log
        sudo chown -R root.root /share/apps/beagle-lib/2.1.2/intel/2017_update-1



Module
------

CUDA
~~~~

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1
        ##
        ## /share/apps/modules/beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1     Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tzlib/1.2.11 - sets the Environment for Beagle-lib in \
            \n\tthe share directory /share/apps/beagle-lib/2.1.2/cuda/7.0/intel/2017_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using Beagle-lib 2.1.2 \
                    \n\tbuilded with Intel Parallel Studio XE 2017 and CUDA 7.0\n"

        # for Tcl script use only
        set       topdir     /share/apps/beagle-lib/2.1.2/cuda/7.0/intel/2017_update-1
        set       version    2.1.2
        set       sys        x86_64-redhat-linux

        module load intel/2017_update-1
        module load java/jdk-1.8.0_112
        module load cuda/7.0

        prepend-path LD_LIBRARY_PATH    $topdir/lib
        prepend-path LIBRARY_PATH       $topdir/lib
        prepend-path LD_RUN_PATH        $topdir/lib

        prepend-path C_INCLUDE_PATH     $topdir/include
        prepend-path CXX_INCLUDE_PATH   $topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include

        prepend-path PKG_CONFIG_PATH    $topdir/lib/pkgconfig


CPU
~~~

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module beagle-lib/2.1.2_intel-2017_update-1
        ##
        ## /share/apps/beagle-lib/2.1.2/intel/2017_update-1     Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\tzlib/1.2.11 - sets the Environment for Beagle-lib in \
            \n\tthe share directory /share/apps/beagle-lib/2.1.2/intel/2017_update-1\n"
        }

        module-whatis "\n\n\tSets the environment for using Beagle-lib 2.1.2 \
                    \n\tbuilded with Intel Parallel Studio XE 2017\n"

        # for Tcl script use only
        set       topdir     /share/apps/beagle-lib/2.1.2/intel/2017_update-1
        set       version    2.1.2
        set       sys        x86_64-redhat-linux

        module load intel/2017_update-1
        module load java/jdk-1.8.0_112

        prepend-path LD_LIBRARY_PATH    $topdir/lib
        prepend-path LIBRARY_PATH       $topdir/lib
        prepend-path LD_RUN_PATH        $topdir/lib

        prepend-path C_INCLUDE_PATH     $topdir/include
        prepend-path CXX_INCLUDE_PATH   $topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include

        prepend-path PKG_CONFIG_PATH    $topdir/lib/pkgconfig

Use
---

CUDA
~~~~

    .. code-block:: bash

        module load beagle-lib/2.1.2_cuda-7.0_intel-2017_update-1


CPU
~~~

    .. code-block:: bash

        module load beagle-lib/2.1.2_intel-2017_update-1



Resources
---------
* https://github.com/beagle-dev/beagle-lib


Author
------
* Mateo Gómez Zuluaga
