.. _Zstd-1.5.2:

Zstd 1.5.2
===========

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 03/03/22022
- **Official Website:** https://github.com/facebook/zstd
- **Supercomputer:** Apolo II
- **License:** Zstd License



Installation
------------

1. Load the necessary modules for compilation

    .. code-block:: bash

        $ module load gcc/11.2.0

2. Download the desired version of the software (Source code) [1]_

    .. code-block:: bash

        $ cd /home/blopezp
        $ git clone https://github.com/facebook/zstd.git

3. After unzipping **Zstd**, continue with the following steps for configuration and compilation:

    .. code-block:: bash

        $ cd zstd-1.5.2

        $ ./configure --prefix=/share/apps/zstd/1.5.2/gcc-11.2.0

        $ make --prefix=/share/apps/zstd/1.5.2/gcc-11.2.0 |& tee make.log
        $sudo prefix=/share/apps/zstd/1.5.2/gcc-11.2.0  make install |& make-install.log

Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modulefile /share/apps/zstd/1.5.2/gcc-11.2.0
        ##

        proc ModulesHelp { } {
             global version modroot
                  puts stderr "\t Zstd 1.5.2"
        }

        module-whatis "\n\n\tSets the environment for using Zstd 1.5..2 \n"


        set     topdir          /share/apps/zstd/1.5.2/gcc-11.2.0
        set     version         1.5.2
        set     sys             x86_64-redhat-linux

        module load gcc/11.2.0

        prepend-path PATH                       $topdir/bin

        prepend-path    C_INCLUDE_PATH          $topdir/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

        prepend-path    LD_LIBRARY_PATH         $topdir/lib
        prepend-path    LIBRARY_PATH            $topdir/lib
        prepend-path    LD_RUN_PATH             $topdir/lib

        prepend-path    MANPATH                 $topdir/share

        setenv          ZSTD_HOME               $topdir



Mode of use
-----------

    .. code-block:: bash

        $ module load zstd/gcc-11.2.0

References
----------

.. [1] https://github.com/facebook/zstd

:Author:

Bryan López Parra <Bryan López Parra>
