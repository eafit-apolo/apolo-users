.. _gsl2.4-index:


GSL 2.4
=======

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.gnu.org/software/gsl/
- **License:**    GNU General Public License
- **Installed on:** Apolo II and Cronos
- **Installation date:** 19/09/2017

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GNU GCC >= 5.4.0



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/gsl/src
        wget http://mirror.cedia.org.ec/gnu/gsl/gsl-2.4.tar.gz
        tar -zxvf gsl-2.4.tar.gz
        cd gsl-2.4


#. After unpacking GSL, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        module load gcc/5.4.0
        ./configure --prefix=/share/apps/gsl/2.4/gcc-5.4.0 --build=x86_64-redhat-linux --enable-shared --enable-static 2>&1 | tee gsl-config.log
        make 2>&1 | tee make-gsl.log


#. Installation of compiled binaries

    .. code-block:: bash

        sudo mkdir -p /share/apps/gsl/2.4/gcc-5.4.0
        sudo chown -R mgomezzul.apolo /share/apps/gsl/2.4/gcc-5.4.0
        make install 2>&1 | tee make-install-gsl.log
        make installcheck 2>&1 | tee make-check-gsl.log
        sudo chown -R root.root /share/apps/gsl/2.4/gcc-5.4.0



Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load gsl/2.4_gcc-5.4.0
        ##
        ## /share/apps/modules/gsl/2.4_gcc-5.4.0
        ##
        ## Written by Mateo Gómez Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using GSL 2.4\
                \nin the shared directory /share/apps/gsl/2.4/gcc-5.4.0\
                \nbuilded with gcc-5.4.0."
        }

        module-whatis "(Name________) gsl"
        module-whatis "(Version_____) 2.4"
        module-whatis "(Compilers___) gcc-5.4.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/gsl/2.4/gcc-5.4.0
        set         version       2.4
        set         sys           x86_64-redhat-linux

        conflict gsl
        module load gcc/5.4.0


        prepend-path	PATH			$topdir/bin

        prepend-path	LD_LIBRARY_PATH		$topdir/lib
        prepend-path	LIBRARY_PATH		$topdir/lib
        prepend-path	LD_RUN_PATH		$topdir/lib

        prepend-path	C_INCLUDE_PATH		$topdir/include
        prepend-path	CXX_INCLLUDE_PATH	$topdir/include
        prepend-path	CPLUS_INCLUDE_PATH	$topdir/include

        prepend-path	PKG_CONFIG_PATH		$topdir/lib/pkgconfig

        prepend-path	MANPATH			$topdir/share/man




Use
---

    .. code-block:: bash

        module load gsl/2.4_gcc-5.4.0
        gcc -I/share/apps/gsl/2.4/gcc-5.4.0/include -L/share/apps/gsl/2.4/gcc-5.4.0/lib main.c -o main -lgsl -lgslcblas -lm



Resources
---------
    * https://www.gnu.org/software/gsl/manual/html_node/Linking-programs-with-the-library.html


Author
------
    * Mateo Gómez Zuluaga
