.. _gurobi.13:

.. contents:: Table of Contents

************
GUROBI 13.0.1
************

- **Installation date:** 12/03/2026
- **URL:** http://www.gurobi.com/
- **Apolo version:** Apolo II
- **License:** ACADEMIC LICENSE

Installation
------------

#. First download the tar from the main page, then:

.. code-block:: bash

    $ tar -xvzf gurobi13.0.1_linux64.tar.gz -C <installdir>



Module
---------

.. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module gurobi/13.0.1
        ##
        ## /share/apps/modules/gurobi/13.0.1
        ##
        ## Written by Laura Sanchez Cordoba 
        ##
        
        proc ModulesHelp { } {
            puts stderr "\tgurobi/13.0.1 - sets the Environment for gurobi 13.0.1"
        }
        
        module-whatis "\n\n\tSets the environment for using gurobi, \
                      \n\tpython/3.12_miniconda-24.7.1"
        
        # for Tcl script use only
        set   	  topdir     /share/apps/gurobi/13.0.1/gurobi1301/linux64
        set	  version    13.0.1
        set       sys	     linux-x86_64
        set       user	     [exec bash -c "echo \$USER"]
        set       hostname   [exec bash -c "echo \$HOSTNAME"]
        set 	  host	     [string map {".local" ""} $hostname ]
        
        conflict gurobi
        
        module load python/3.12_miniconda-24.7.1
        module load java/jdk-17.0.2
        
        setenv GUROBI_HOME		$topdir
        setenv GUROBI_LICENSE_HOME	/home/$user/gurobi-licenses/v1301
        setenv GRB_LICENSE_FILE		/home/$user/gurobi-licenses/v1301/$host/gurobi.lic
        
        prepend-path PATH		$topdir/bin
        prepend-path LD_LIBRARY_PATH 	$topdir/lib
        prepend-path LIBRARY_PATH 	$topdir/lib
        prepend-path LD_RUN_PATH 	$topdir/lib
        
        prepend-path CXX_INCLUDE_PATH	$topdir/include
        prepend-path CPLUS_INCLUDE_PATH $topdir/include
        prepend-path C_INCLUDE_PATH 	$topdir/include
        
        prepend-path CLASSPATH		$topdir/lib/gurobi.jar


Load the module

.. code-block:: bash

        $ module load gurobi/13.0.1

References
------------

- https://www.gurobi.com/documentation/13.0/quickstart_linux/index.html

:Author:

- David Julian Oviedo Betancur

:Auditor:

- Laura Sanchez Cordoba
