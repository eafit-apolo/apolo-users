.. _gurobi.7:

.. contents:: Table of Contents

************
GUROBI 7.5.0
************

- **Installation date:**
- **URL:** http://www.gurobi.com/
- **Apolo version:** Cronos
- **License:** ACADEMIC LICENSE

Installation
------------

#. First download the tar from the main page, then:

.. code-block:: bash

    $ tar xvfz gurobi7.5.2_linux64.tar.gz -C <installdir>

Module
---------

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## module gurobi/7.5.2
    ##
    ## /share/apps/modules/gurobi/7.5.2 Written by Juan David Pineda-Cárdenas
    ##

    proc ModulesHelp { } {
        puts stderr "\tgurobi/7.5.2 - sets the Environment for gurobi \
        \n\tin the share directory /share/apps/gurobi/7.5.2\n"
    }

    module-whatis "\n\n\tSets the environment for using gurobi \
                  \n\tbuilded with python/2.7.13_intel-18_u1\n"

    # for Tcl script use only
    set   	  topdir     /share/apps/gurobi/7.5.2
    set	  version    7.5.2
    set       sys	     linux-x86_64
    set       user	     [exec bash -c "echo \$USER"]
    set       hostname   [exec bash -c "echo \$HOSTNAME"]
    set 	  host	     [string map {".local" ""} $hostname ]

    conflict gurobi

    module load python/2.7.13_intel-18_u1
    module load java/jdk-8_u152

    setenv GUROBI_HOME		$topdir
    setenv GUROBI_LICENSE_HOME	/home/$user/gurobi-licenses
    setenv GRB_LICENSE_FILE		/home/$user/gurobi-licenses/$host/gurobi.lic

    prepend-path PATH		$topdir/bin
    prepend-path LD_LIBRARY_PATH 	$topdir/lib
    prepend-path LIBRARY_PATH 	$topdir/lib
    prepend-path LD_RUN_PATH 	$topdir/lib

    prepend-path CXX_INCLUDE_PATH	$topdir/include
    prepend-path CPLUS_INCLUDE_PATH $topdir/include
    prepend-path C_INCLUDE_PATH 	$topdir/include

    prepend-path CLASSPATH		$topdir/lib/gurobi.jar

References
------------

- http://www.gurobi.com/documentation/7.5/quickstart_linux.pdf

Author
------

- Andrés Felipe Zapata Palacio
