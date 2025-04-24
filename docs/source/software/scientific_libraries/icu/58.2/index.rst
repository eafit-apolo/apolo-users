.. _icu-58.2-index:


ICU 58.2
========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://site.icu-project.org/
- **License:**   Unicode license
- **Installed on:** Apolo II and Cronos
- **Installation date:** 21/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GNU GCC >= 5.4.0



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/icu/gcc/5.4.0
        wget http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz
        tar -zxvf icu4c-58_2-src.tgz


#. After unpacking ICU, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd icu/source
        module load gcc/5.4.0
        ./configure --prefix=/share/apps/icu/58.2/gcc/5.4.0 --build=x86_64-redhat-linux --enable-static --with-library-bits=64 2>&1 | tee icu-conf.log
        make 2>&1 | tee icu-make.log
        sudo mkdir -p /share/apps/icu/58.2/gcc/5.4.0
        sudo chown -R mgomezzul.apolo /share/apps/beagle-lib/2.1.2/intel/2017_update-1
        make install 2>&1 | tee icu-make-install.log
        sudo chown -R root.root /share/apps/icu/58.2/gcc/5.4.0



Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module icu/58.2_gcc-5.4.0
        ##
        ## /share/apps/modules/icu/58.2_gcc-5.4.0 Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp { } {
            puts stderr "\ticu/58.2_gcc-5.4.0 - sets the Environment for ICU in \
            \n\tthe share directory /share/apps/icu/58.2/gcc/5.4.0\n"
        }

        module-whatis "\n\n\tSets the environment for using ICU-58.2 \
                    \n\tbuilded with GNU GCC 5.4.0\n"

        # for Tcl script use only
        set       topdir     /share/apps/icu/58.2/gcc/5.4.0
        set       version    58.2
        set       sys        x86_64-redhat-linux

        module load gcc/5.4.0

        prepend-path PATH               $topdir/bin
        prepend-path PATH               $topdir/sbin

        prepend-path LD_LIBRARY_PATH    $topdir/lib
        prepend-path LIBRARY_PATH       $topdir/lib
        prepend-path LD_RUN_PATH        $topdir/lib

        prepend-path C_INCLUDE_PATH     $topdir/include
        prepend-path CXX_INCLUDE_PATH   $topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include

        prepend-path PKG_CONFIG_PATH    $topdir/lib/pkgconfig

        prepend-path MANPATH 		$topdir/share/man



Use
---

    .. code-block:: bash

        module load icu/58.2_gcc-5.4.0



Resources
---------
 * http://site.icu-project.org/


Author
------
    * Mateo Gómez Zuluaga
