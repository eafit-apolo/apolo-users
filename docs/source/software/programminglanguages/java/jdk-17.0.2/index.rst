.. _jdk-17.0.2-index:

JDK-17.0.2
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.oracle.com/java/
- **License:**  https://www.oracle.com/downloads/licenses/no-fee-license.html
- **Installed on:** Apolo II
- **Instalation date:** 14/03/2022

Prerequisites
-------------

Installation
------------

1. Create the folder for java

    .. code-block:: bash

        $ mkdir -p /share/apps/java/17.0.2

2. Download the software

    .. code-block:: bash

        $ wget https://download.oracle.com/java/17/archive/jdk-17.0.2_linux-x64_bin.tar.gz
        $ tar xvzf jdk-17.0.2_linux-x64_bin.tar.gz


Module
------

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modules java/jdk-17.0.2
        ##
        ## /share/apps/modules/java/jdk-17.0.2  Written by Jacobo Monsalve
        ##
        ##

        proc ModulesHelp { } {
            puts stderr "\tThe Java Development Kit (JDK) is an implementation of \
                        \n\teither one of the Java Platform.\n"
        }

        module-whatis "\n\n\tSets the environment for using JDK-17.0.2\n"

        # for Tcl script use only
        set       topdir     /share/apps/java/jdk-17.0.2
        set       version    jdk-17.0.2
        set       sys        x86_64-redhat-linux
        set       JAVA_HOME  $topdir

        conflict java

        setenv              JAVA_HOME          $topdir

        #setenv             JAVA_JRE           $topdir/jre

        prepend-path        PATH               $topdir/bin

        prepend-path        LD_LIBRARY_PATH    $topdir/lib
        prepend-path        LIBRARY_PATH       $topdir/lib
        prepend-path        LD_RUN_PATH        $topdir/lib

        prepend-path        C_INCLUDE_PATH     $topdir/include
        prepend-path        CXX_INCLUDE_PATH   $topdir/include
        prepend-path        CPLUS_INCLUDE_PATH $topdir/include

        append-path         CLASSPATH          "."
        #append-path        CLASSPATH          $JAVA_HOME/lib/dt.jar
        #append-path        CLASSPATH          $JAVA_HOME/lib/tools.jar

        #prepend-path       MANPATH            $topdir/man

How to use
----------

    .. code-block:: bash

        $ module load java/jdk-17.0.2

:Authors:

- Jacobo Monsalve Guzman
