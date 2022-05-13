.. _mpfr4.1.0-index:


MPFR 4.1.0
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.mpfr.org/mpfr-current/#download
- **License:**  Free Software Foundation’s GNU General Public License
- **Installed on:** Apolo II
- **Installation date:** 03/03/2022

Tested on (Requirements)
------------------------

* **OS base:** Rocky Linux 8.5 (x86_64)
* **Dependencies:**
    * GMP 6.2.1



Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget https://www.mpfr.org/mpfr-current/mpfr-4.1.0.tar.gz
        $ tar -xvf mpfr-4.1.0.tar.gz



#. After unpacking MPFR, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd mpfr-4.1.0

        $ ./configure --prefix=/share/apps/mpfr/4.1.0/gcc-8.5.0 --build=x86_64-redhat-linux-gnu --enable-thread-safe --with-gmp=/share/apps/gmp/6.2.1/gcc-8.5.0 --enable-assert --with-gnu-ld

        $ make -j 10 2>&1 | tee mpfr-make.log
        $ sudo mkdir -p /share/apps/mpfr/4.1.0
        $ make install 2>&1 | tee mpfr-make-install.log


Module
------

    .. code-block:: bash

        #%Module1.0####################################################################
        ##
        ## module load mpfr/4.1.0_gcc-8.5.0
        ##
        ##/share/apps/mpfr/4.1.0/gcc-8.5.0
        ## Written by Bryan Lopez Parra
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using MPFR 4.1.0\
                        \nin the shared directory /share/apps/mpfr/4.1.0/gcc-8.5.0\
                        \nbuilded with gcc-8.5.0"
        }

        module-whatis "(Name________) mpfr"
        module-whatis "(Version_____) 8.5.0"
        module-whatis "(Compilers___) gcc-8.5.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) gmp-6.2.1"

        # for Tcl script use only
        set         topdir        /share/apps/mpfr/4.1.0/gcc-8.5.0
        set         version       3.1.6
        set         sys           x86_64-redhat-linux

        conflict mpfr
        module load gmp/6.2.1_gcc-8.5.0

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

        module load mpfr/4.1.0_gcc-8.5.0



Resources
---------
    *  https://www.mpfr.org/mpfr-current


:Autor:

- Bryan López Parra <blopezp@eafit.edu.co>
