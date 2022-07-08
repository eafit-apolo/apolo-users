.. _MPC-1.2.1:

MPC 1.2.1
==========

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 03/03/2022
- **Official Website:** http://www.multiprecision.org/mpc/
- **Supercomputer:** Apolo II
- **License:** Free Software Foundation’s GNU General Public License

Prerequisites
-------------

- GMP 6.2.1
- MPFR 4.1.0

Installation
------------



1. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/blopezp
        $ wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz
        $ tar -zxvf mpc-1.2.1.tar.gz

2. After decompressing **MPC**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $  cd mpc-1.2.1

        $ ./configure --prefix=/share/apps/mpc/1.2.1/gcc-8.5.0 --build=x86_64-redhat-linux-gnu --with-mpfr=/share/apps/mpfr/4.1.0/gcc-8.5.0 --with-gmp=/share/apps/gmp/6.2.1/gcc-8.5.0 --with-gnu-ld

        $ make -j 10 2>&1 | tee mpc-make.log
        $ sudo mkdir -p /share/apps/mpc/1.2.1
        $ make install 2>&1 | tee mpc-make-install.log


Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load mpc/1.2.1_gcc.8.5.0
        ##
        ## /share/apps/mpc/1.2.1/gcc-8.5.0
        ## Written by Bryan Lopez Parra
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using MPC 1.2.1\
                        \nin the shared directory  /share/apps/mpc/1.2.1/gcc-8.5.0\
                        \nbuilded with gcc-8.5.0"
        }

        module-whatis "(Name________) mpc"
        module-whatis "(Version_____) 1.2.1"
        module-whatis "(Compilers___) gcc-8.5.0"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/mpc/1.2.1/gcc-8.5.0
        set         version       1.2.1
        set         sys           x86_64-redhat-linux

        conflict mpc
        module load gmp/6.2.1_gcc-8.5.0
        module load mpfr/4.1.0_gcc-8.5.0

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include



Mode of use
-----------

    .. code-block:: bash

        $ module load mpc/1.2.1_gcc-8.5.0

:Author:

- Bryan López Parra <blopezp@eafit.edu.co>

References
----------

.. [1] http://www.multiprecision.org/mpc/
