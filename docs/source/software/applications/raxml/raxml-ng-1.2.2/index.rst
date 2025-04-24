.. _raxml-ng-1.2.2:


.. contents:: Table of Contents

*****
RAxML-ng-1.2.2
*****

- **Installation date:** 15/04/2025
- **URL:** https://github.com/amkozlov/raxml-ng

Dependencies
------------

- CMake 3.0.2 or higher
- gcc 6.4.0 or higher
- unzip


Installation
------------

After installing the dependencies we can proceed with the  installation

1. Download the MPI version of the software (https://github.com/amkozlov/raxml-ng/blob/master/README.md):

.. code-block:: bash

    unzip raxml-ng_v1.2.2_linux_x86_64_MPI.zip

2. For configuration and compilation, simply write:

.. code-block:: bash

    ./install.sh

3. The executable programs will be installed to a bin subdirectory, so you may wish to acces this directory:

.. code-block:: bash

   cd bin/
   ./raxml-ng-mpi -h

After running the command you must see the available commands.

Module
------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## modules raxml-ng1.2.2_gcc-11.2.0
    ##
    ## /share/apps/raxml-ng/1.2.2
    ##

    proc ModulesHelp { } {
        puts stderr "\traxml-ng1.2.2 - sets the Enviroment for RAXML-NG in \
        \n\tthe share directory /share/apps/modules/raxml-ng/1.2.2_gcc-11.2.0\n"
    }

    module-whatis "\n\n\tSets the enviroment for RAXML-NG\
                 \n\tbuilt with gcc-11.2.0\n"

    #for TCL script use only
        set       topdir     /share/apps/raxml-ng/1.2.2
        set       version    1.2.2
        set       sys        x86_64-redhat-linux

     conflict raxml-ng

     module load gcc cmake

     prepend-path    LD_LIBRARY_PATH         $topdir/localdeps/lib
     prepend-path    LD_RUN_PATH             $topdir/localdeps/lib
     prepend-path    LIBRARY_PATH            $topdir/localdeps/lib

     prepend-path    C_INCLUDE_PATH          $topdir/localdeps/include
     prepend-path    CXX_INCLUDE_PATH        $topdir/localdeps/include
     prepend-path    CPLUS_INCLUDE_PATH      $topdir/localdeps/include

     prepend-path    PATH                    $topdir/build/bin

     prepend-path    PATH                    $topdir/bin


Mode of use
-----------

Load the necessary environment through the **module:**

.. code-block:: bash

    module load raxml-ng/1.2.2_gcc-11.2.0

References
----------

- https://github.com/amkozlov/raxml-ng
- INSTALL.txt

Author
------

- Emanuell Torres López
