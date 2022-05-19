.. _gurobi.9:

.. contents:: Table of Contents

************
GUROBI 9.5.0
************

- **Installation date:** 17/02/2022
- **URL:** http://www.gurobi.com/
- **Apolo version:** Apolo II
- **License:** ACADEMIC LICENSE

Installation
------------

#. First download the tar from the main page, then:

.. code-block:: bash

    $ tar -xvf gurobi9.5.0_linux64.tar.gz -C <installdir>



Module
---------

.. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module gurobi/9.5.0
        ##
        ## /share/apps/modules/gurobi/9.5.0
        ##
        ## Written by Laura Sanchez Cordoba
        ##

        proc ModulesHelp { } {
            puts stderr "\tgurobi/9.5.0 - sets the Environment for gurobi 9.5.0"
        }

        module-whatis "\n\n\tSets the environment for using gurobi, \
                      \n\tminiconda3-4.10.3-gcc-11.2.0-vcglj27"

        # for Tcl script use only
        set   	  topdir     /share/apps/gurobi/9.5.0/gurobi950/linux64
        set	  version    9.5.0
        set       sys	     linux-x86_64
        set       user	     [exec bash -c "echo \$USER"]
        set       hostname   [exec bash -c "echo \$HOSTNAME"]
        set 	  host	     [string map {".local" ""} $hostname ]

        conflict gurobi

        module load miniconda3-4.10.3-gcc-11.2.0-vcglj27

        setenv GUROBI_HOME		$topdir
        setenv GUROBI_LICENSE_HOME	/home/$user/gurobi-licenses/v950
        setenv GRB_LICENSE_FILE		/home/$user/gurobi-licenses/v950/$host/gurobi.lic

        prepend-path PATH		$topdir/bin
        prepend-path LD_LIBRARY_PATH 	$topdir/lib
        prepend-path LIBRARY_PATH 	$topdir/lib
        prepend-path LD_RUN_PATH 	$topdir/lib

        prepend-path CXX_INCLUDE_PATH	$topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include
        prepend-path C_INCLUDE_PATH 	$topdir/include

        prepend-path CLASSPATH		$topdir/lib/gurobi.jar

        prepend-path PYTHONPATH		$topdir

Load the module

.. code-block:: bash

        $ module load gurobi/9.5.0

References
------------

- https://www.gurobi.com/documentation/9.5/quickstart_linux/index.html

:Author:

- Laura Sánchez Córdoba
