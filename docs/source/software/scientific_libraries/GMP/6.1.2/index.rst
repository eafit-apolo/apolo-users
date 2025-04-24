.. _gmp6.1.2-index:

GMP 6.1.2
=========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://gmplib.org/
- **License:** Free Software Foundation’s GNU General Public License
- **Installed on:** Apolo II and Cronos
- **Installation date:** 01/02/2018


Installation
------------

#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash


        cd /home/mgomezzul/apps/gmp/src/
        wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2
        tar -xvf gmp-6.1.2.tar.bz2


#. After unpacking GMP, continue with the following steps for configuration and compilation:

    .. code-block:: bash


        cd gmp-6.1.2
        ./configure --prefix=/share/apps/gmp/6.1.2/gcc-4.4.7-18 --build=x86_64-redhat-linux-gnu --enable-cxx --enable-assert --with-gnu-ld
        make -j 10 2>&1 | tee gmp-make.log
        sudo mkdir -p /share/apps/gmp/6.1.2
        sudo chown -R mgomezzul.apolo /share/apps/gmp/6.1.2
        make install 2>&1 | tee gmp-make-install.log
        sudo chown -R root.root /share/apps/gmp/6.1.2


Module
------

    .. code-block:: bash


        #%Module1.0####################################################################
        ##
        ## module load gmp/6.1.2_gcc-4.4.7-18
        ##
        ## /share/apps/modules/gmp/6.1.2_gcc-4.4.7-18
        ## Written by Mateo Gomez Zuluaga
        ##
        proc ModulesHelp {} {
            global version modroot
            puts stderr "\n\n\tSets the environment for using gmp (GNU Multiple \
                        \n\tPrecision Arithmetic Library) builded gcc 4.4.7-18 version\n"
        }
        module-whatis "(Name________) gmp"
        module-whatis "(Version_____) 6.1.2"
        module-whatis "(Compilers___) gcc-4.4.7-18"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "
        # for Tcl script use only
        set         topdir        /share/apps/gmp/6.1.2/gcc-4.4.7-18
        set         version       6.1.2
        set         sys           x86_64-redhat-linux
        conflict gmp

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib
        prepend-path    GMP_LIBRARIES           $topdir/lib
        prepend-path    GMPXX_LIBRARIES         $topdir/lib
        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include
        prepend-path    GMP_INCLUDE_DIR         $topdir/include
        prepend-path    GMPXX_INCLUDE_DIR       $topdir/include
        prepend-path    INFOPATH                $topdir/share/info


Use
---
    .. code-block:: bash

        module load /share/apps/modules/gmp/6.1.2_gcc-4.4.7-18


Resources
---------

    * https://gmplib.org/#DOWNLOAD


Author
------
 * Tomas Navarro (Translated the document)
