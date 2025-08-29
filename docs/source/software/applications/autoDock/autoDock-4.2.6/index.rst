.. _autoDock-index:

.. role:: bash(code)
   :language: bash

AutoDock 4.2.6
==============

.. contents:: Table of Contents

Basic information
-----------------
- **Installation Date:** 19/10/2017
- **URL:** http://autodock.scripps.edu/
- **License:** GNU-LPLv2+
- **Installed on:** Apolo II

Installation
------------

Using precompiled files
~~~~~~~~~~~~~~~~~~~~~~~

#. Download the binary for kernel version 2.6.32-504.16.2.el6.x86_64 (obtained by uname -r)

    .. code-block:: bash

        wget http://autodock.scripps.edu/downloads/autodock-registration/tars/dist426/autodocksuite-4.2.6-x86_64Linux2.tar

#. Unzip the binaries

    .. code-block:: bash

        tar -xvf autodocksuite-4.2.6-x86_64Linux2.tar

#. We create the installation folder and move the downloaded binaries

    .. code-block:: bash

        cd x86_64Linux2
        mkdir -p /share/apps/autodock/4.2.6/bin/
        mv autodock4 autogrid4 /share/apps/autodock/4.2.6/bin/


Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load autodock/4.2.6
        ##
        ## /share/apps/modules/autodock/4.2.6
        ## Written by Juan David Arcila Moreno
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using autodock 4.2.6\
                        \nin the shared directory \
                        \n/share/apps/autodock/4.2.6/\
                        \nbuilded with gcc-5.4.0"
        }

        module-whatis "(Name________) autodock"
        module-whatis "(Version_____) 4.2.6"
        module-whatis "(Compilers___) "
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/autodock/4.2.6
        set         version       4.2.6
        set         sys           x86_64-redhat-linux

        conflict autodock


        prepend-path    PATH                    $topdir/bin

Mode of Use
-----------

    .. code-block:: bash

        module load autodock/4.2.6
        autodock4
        autogrid4

References
----------

- http://autodock.scripps.edu/downloads/autodock-registration/autodock-4-2-download-page/%7C

Authors
-------

- Juan David Arcila Moreno
