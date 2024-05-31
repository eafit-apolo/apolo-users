.. _go-1.4-index:

Go-1.4
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Instalation date:** 03/05/2024
- **Official Website:** https://go.dev/
- **License:** https://go.dev/LICENSE
- **Installed on:** Apolo II

Installation
------------

1. Create the folder for go

    .. code-block:: bash

        $ mkdir -p /share/apps/go/

2. Create the folder for version 1.4

    .. code-block:: bash

        $ mkdir -p /share/apps/go/1.4

3. Create the folder for the compiler (in this case intel_oneAPI_2022)

    .. code-block:: bash

        $ mkdir -p /share/apps/go/1.4/intel_oneAPI_2022


4. Go to the compiler folder
    .. code-block:: bash

        $ cd /share/apps/go/1.4/intel_oneAPI_2022/



5. Download and decompress the software

    .. code-block:: bash

        $ wget  https://dl.google.com/go/go1.4-bootstrap-20171003.tar.gz
        $ tar xvzf go1.4-bootstrap-20171003.tar.gz

6. Go to the descompressed folder and go to src/

    .. code-block:: bash

        $ cd go
        $ cd src

7. Set CGO variable in the environment:

    .. code-block:: bash

        $ export CGO_ENABLED=0

8. Run make:

    .. code-block:: bash

        $ ./make.bash
        # May have to be executed with sudo (sudo ./make.bash).


Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modules go1.4_intel_oneAPI_2022
        ##
        ## /share/apps/go/1.4/intel_oneAPI_2022
        ##

        proc ModulesHelp { } {
        puts stderr "\t1.4intel_oneAPI_2022 - sets the Enviroment for GO in \
        \n\tthe share directory /share/apps/modules/go/1.4_intel_oneAPI_2022\n"
        }

        module-whatis "\n\n\tSets the enviroment for GO\
              \n\tbuilt with Intel_oneAPI-2022_update-1\n"

        #for TCL script use only
        set       topdir     /share/apps/go/1.4/intel_oneAPI_2022
        set       version    1.4
        set       sys        x86_64-redhat-linux

        #conflict go

        module load intel/2022_oneAPI-update1

        prepend-path    C_INCLUDE_PATH          $topdir/go/include
        prepend-path    CXX_INCLUDE_PATH        $topdir/go/include
        prepend-path    CPLUS_INCLUDE_PATH      $topdir/go/include

        prepend-path    LD_LIBRARY_PATH         $topdir/go/lib
        prepend-path    LD_RUN_PATH             $topdir/go/lib
        prepend-path    LIBRARY_PATH            $topdir/go/lib

        prepend-path    PATH                    $topdir/go/misc/nacl/testdata/bin

        prepend-path    LD_LIBRARY_PATH         $topdir/go/src/compress/zlib
        prepend-path    LD_RUN_PATH             $topdir/go/src/compress/zlib
        prepend-path    LIBRARY_PATH            $topdir/go/src/compress/zlib

        prepend-path    PATH                    $topdir/go/bin

        prepend-path 	GOROOT_BOOTSTRAP 	/share/apps/go/1.4/intel_oneAPI_2022/go
        prepend-path 	GOROOT 			/share/apps/go/1.4/intel_oneAPI_2022/go


.. note:: The last two pretend-path have to be added manually.

.. code-block:: bash

        prepend-path 	GOROOT_BOOTSTRAP 	/share/apps/go/1.4/intel_oneAPI_2022/go
        prepend-path 	GOROOT 			/share/apps/go/1.4/intel_oneAPI_2022/go



How to use
----------

    .. code-block:: bash

        $ module load go/1.4_intel_oneAPI_2022

:Authors:

- Santiago Rodriguez Mojica
