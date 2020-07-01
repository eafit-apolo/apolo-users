.. _MPC-1.0.3:

MPC 1.0.3
==========

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 01/02/2018
- **Official Website:** http://www.multiprecision.org/mpc/
- **Supercomputer:** Cronos
- **License:** Free Software Foundation’s GNU General Public License

Prerequisites
-------------

- GMP 6.1.2
- MPFR 3.1.6

Installation
------------



1. Download the desired version of the software (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/mgomezzul/apps/mpc/src/
        $ wget https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
        $ tar -xvf mpc-1.0.3.tar.gz

2. After decompressing **MPC**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $  cd mpc-1.0.3

        $ ./configure --prefix=/share/apps/mpc/1.0.3/gcc-4.4.7-18 --build=x86_64-redhat-linux-gnu --with-mpfr=/share/apps/mpfr/3.1.6/gcc-4.4.7-18 --with-gmp=/share/apps/gmp/6.1.2/gcc-4.4.7-18 --with-gnu-ld

        $ make -j 10 2>&1 | tee mpc-make.log
        $ sudo mkdir -p /share/apps/mpc/1.0.3/gcc-4.4.7-18
        $ sudo chown -R mgomezzul.apolo /share/apps/mpc/1.0.3/gcc-4.4.7-18
        $ make install 2>&1 | tee mpc-make-install.log
        $ sudo chown -R root.root /share/apps/mpc/1.0.3/gcc-4.4.7-18


Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load mpc/1.0.3_gcc-4.4.7-18
        ##
        ## /share/apps/modules/mpc/1.0.3_gcc-4.4.7-18
        ## Written by Mateo Gomez-Zuluaga
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using MPC 1.0.3\
                        \nin the shared directory  /share/apps/mpc/1.0.3/gcc-4.4.7-18\
                        \nbuilded with gcc-4.4.7-18."
        }

        module-whatis "(Name________) mpc"
        module-whatis "(Version_____) 1.0.3"
        module-whatis "(Compilers___) gcc-4.4.7-18"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/mpc/1.0.3/gcc-4.4.7-18
        set         version       1.0.3
        set         sys           x86_64-redhat-linux

        conflict mpc
        module load gmp/6.1.2_gcc-4.4.7-18
        module load mpfr/3.1.6_gcc-4.4.7-18

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

        $ module load mpc/1.0.3_gcc-4.4.7-18

References
----------

.. [1] https://www.ece.uvic.ca/~frodo/jasper/#download
