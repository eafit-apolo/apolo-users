.. _Cloog-0.18.4:

Cloog 0.18.4
============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 01/02/2018
- **Official Website:**  https://www.cloog.org/
- **Supercomputer:** Cronos
- **License:** Free Software Foundation’s GNU General Public License


Dependencies
------------

- GMP >= 6.0.0

Installation
------------

1.. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/mgomezzul/apps/cloog/src/
        $ wget https://www.bastoul.net/cloog/pages/download/cloog-0.18.4.tar.gz
        $ tar -xvf cloog-0.18.4.tar.gz

2. After unzipping **Cloog**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $cd cloog-0.18.4

        $ ./configure --prefix=/share/apps/cloog/0.18.4/gcc-4.4.7-18 --build=x86_64-redhat-linux-gnu -with-isl=bundled --with-gmp-prefix=/share/apps/gmp/6.1.2/gcc-4.4.7-18 --with-osl=bundled --with-gnu-ld

        $ make -j 10 2>&1 | tee cloog-make.log
        $ sudo mkdir -p /share/apps/cloog/0.18.4/gcc-4.4.7-18
        $ sudo chown -R mgomezzul.apolo /share/apps/cloog/0.18.4/gcc-4.4.7-18
        $ make install 2>&1 | tee cloog-make-install.log
        $ sudo chown -R root.root /share/apps/cloog/0.18.4/gcc-4.4.7-18

It is important to leave the flags that include isl and osl in the installation as they are dependencies of R

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load cloog/0.18.4_gcc-4.4.7-18
        ##
        ## /share/apps/modules/cloog/0.18.4_gcc-4.4.7-18
        ## Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using CLooG 0.18.4\
                        \nin the shared directory /share/apps/cloog/0.18.4/gcc-4.4.7-18\
                        \nbuilded with gcc-4.4.7-18."
        }

        module-whatis "(Name________) cloog"
        module-whatis "(Version_____) 0.18.4"
        module-whatis "(Compilers___) gcc-4.4.7-18"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) gmp-6.1.2"

        # for Tcl script use only
        set         topdir        /share/apps/cloog/0.18.4/gcc-4.4.7-18
        set         version       0.18.4
        set         sys           x86_64-redhat-linux

        conflict cloog
        module load gmp/6.1.2_gcc-4.4.7-18

        prepend-path    PATH                    $topdir/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    PKG_CONFIG_PATH         $topdir/lib/pkgconfig


Mode of use
-----------

    .. code-block:: bash

        $ module load /share/apps/modules/cloog/0.18.4_gcc-4.4.7-18

References
----------

.. [1] https://www.cloog.org/
