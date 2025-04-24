.. _qt4.8.7-index:


Qt 4.8.7
========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.qt.io/
- **License:**    LGPL
- **Installed on:** Apolo II and Cronos
- **Installation date:** 27/02/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GNU GCC >= 5.5.0



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/qt/intel/
        wget https://download.qt.io/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz
        tar -zxvf qt-everywhere-opensource-src-4.8.7.tar.gz



#. After unpacking Qt, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        module purge
        module load gcc/5.5.0
        cd qt-everywhere-opensource-src-4.8.7
        configure -prefix /share/apps/qt/4.8.7/gcc-5.5.0 -release -system-zlib -no-gui -no-webkit -opensource -nomake examples -nomake demos -nomake tests -optimized-qmake -confirm-license -platform linux-g++ -no-qt3support
        make 2>&1 | tee make-qt.log
        make check 2>&1 | tee make-check-qt.log

#. Installation of compiled binaries

    .. code-block:: bash

        sudo mkdir -p /share/apps/qt/4.8.7/gcc-5.5.0
        sudo chmod -R mgomezzul.apolo /share/apps/qt/4.8.7/gcc-5.5.0
        make install 2>&1 | tee make-install-qt.log



Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load qt/4.8.7_gcc-5.5.0
        ##
        ## /share/apps/modules/qt/4.8.7_gcc-5.5.0
        ## Written by Mateo G;ómez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using QT 4.8.7\
                \nin the shared directory /share/apps/qt/4.8.7/gcc-5.5.0\
                \nbuilded with gcc-5.4.0."
        }

        module-whatis "(Name________) qt"
        module-whatis "(Version_____) 4.8.7"
        module-whatis "(Compilers___) gcc-5.5.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/qt/4.8.7/gcc-5.5.0
        set         version       4.8.7
        set         sys           x86_64-redhat-linux

        conflict qt
        module load gcc/5.5.0

        setenv		QTDIR			$topdir
        setenv	    	QTINC			$topdir/include
        setenv		QTLIB			$topdir/lib

        prepend-path	PATH			$topdir/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib

        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLUDE_PATH	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include

        prepend-path	PKG_CONFIG_PATH		$topdir/lib/pkgconfig




Use
---

    .. code-block:: bash

        module load qt/4.8.7_gcc-5.5.0



Resources
---------
    * https://raw.githubusercontent.com/OpenFOAM/ThirdParty-2.4.x/master/makeQt
    * https://openfoamwiki.net/index.php/Installation/Linux/OpenFOAM-4.0/CentOS_SL_RHEL
    * http://www.linuxfromscratch.org/blfs/view/7.8/x/qt4.html
    * https://software.intel.com/en-us/articles/build-qt-libraries-with-intel-compiler-linux


Author
------
    * Mateo Gómez Zuluaga
