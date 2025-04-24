.. _mpfr3.1.6-index:


MPFR 3.1.6
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.mpfr.org/mpfr-3.1.6/
- **License:**  Free Software Foundation’s GNU General Public License
- **Installed on:** Apolo II and Cronos
- **Installation date:** 01/02/2018

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies:**
    * GMP 6.1.2



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/mgomezzul/apps/mpfr/src/
        wget http://www.mpfr.org/mpfr-3.1.6/mpfr-3.1.6.tar.gz
        tar -xvf mpfr-3.1.6.tar.gz



#. After unpacking MPFR, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        cd mpfr-3.1.6

        ./configure --prefix=/share/apps/mpfr/3.1.6/gcc-4.4.7-18 --build=x86_64-redhat-linux-gnu --enable-thread-safe --with-gmp=/share/apps/gmp/6.1.2/gcc-4.4.7-18 --enable-assert --with-gnu-ld

        make -j 10 2>&1 | tee mpfr-make.log
        sudo mkdir -p /share/apps/mpfr/3.1.6/gcc-4.4.7-18
        sudo chown -R mgomezzul.apolo /share/apps/mpfr/3.1.6/gcc-4.4.7-18
        make install 2>&1 | tee mpfr-make-install.log
        sudo chown -R root.root /share/apps/mpfr/3.1.6/gcc-4.4.7-18


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load mpfr/3.1.6_gcc-4.4.7-18
        ##
        ## /share/apps/modules/mpfr/3.1.6_gcc-4.4.7-18
        ## Written by Mateo Gomez Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using MPFR 3.1.6\
                        \nin the shared directory /share/apps/mpfr/3.1.6/gcc-4.4.7-18\
                        \nbuilded with gcc-4.4.7-18"
        }

        module-whatis "(Name________) mpfr"
        module-whatis "(Version_____) 3.1.6"
        module-whatis "(Compilers___) gcc-4.4.7-18"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) gmp-6.1.2"

        # for Tcl script use only
        set         topdir        /share/apps/mpfr/3.1.6/gcc-4.4.7-18
        set         version       3.1.6
        set         sys           x86_64-redhat-linux

        conflict mpfr
        module load gmp/6.1.2_gcc-4.4.7-18

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    INFOPATH                $topdir/share/info



Use
---

    .. code-block:: bash

        module load mpfr/3.1.6_gcc-4.4.7-18



Resources
---------
    * http://www.mpfr.org/mpfr-3.1.6/


Author
------
    * Tomas Navarro (Translated document)
