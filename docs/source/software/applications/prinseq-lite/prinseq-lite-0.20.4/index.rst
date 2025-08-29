.. _prinseq-lite-0.20.4-index:

.. role:: bash(code)
   :language: bash

Prinseq-lite 0.20.4
===================

.. contents:: Table of Contents

Basic information
-----------------
- **Installation Date:** 11/07/2018
- **URL:** http://prinseq.sourceforge.net
- **License:** GNU GENERAL PUBLIC LICENSE Version 3
- **Installed on:** Apolo II & Cronos

Tested on (Requirements)
------------------------

* **Dependencies to run Prinseq-lite:**
    * Perl >= 5.26.1

Installation
------------

#. We get the **Prinseq-lite** binary from the official website.

    .. code-block:: bash

        wget https://sourceforge.net/projects/prinseq/files/standalone/prinseq-lite-0.20.4.tar.gz/download
        mv download prinseq-lite-0.20.4.tar.gz
        tar -xzvf prinseq-lite-0.20.4.tar.gz
        cd prinseq-lite-0.20.4

#. We create the installation folder and copy the script, changing its name

    .. code-block:: bash

        mkdir -p /share/apps/prinseq-lite/0.20.4/bin
        cp prinseq-lite.pl /share/apps/prinseq-lite/0.20.4/bin/prinseq-lite

#. We assign the execution permissions

    .. code-block:: bash

        chmod +x /share/apps/prinseq-lite/0.20.4/bin/prinseq-lite

Module
------

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load prinseq-lite/0.20.4
        ##
        ## /share/apps/modules/prinseq-lite/0.20.4
        ## Written by Juan David Arcila-Moreno
        ##

        proc ModulesHelp {} {
            global version modroot
            puts stderr "Sets the environment for using prinseq-lite 0.20.4\
                \nin the shared directory \
                \n/share/apps/prinseq-lite/0.20.4\
                \nperl script"
        }

        module-whatis "(Name________) prinseq-lite"
        module-whatis "(Version_____) 0.20.4"
        module-whatis "(Compilers___) perl-5.26.1"
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/prinseq-lite/0.20.4
        set         version       0.20.4
        set         sys           x86_64-redhat-linux

        conflict prinseq-lite
        module load perl/5.26.1_gcc-5.5.0


        prepend-path	PATH			$topdir/bin


Mode of Use
-----------

    .. code-block:: bash

        module load prinseq-lite
        prinseq-lite -h

References
----------

- https://sourceforge.net/projects/prinseq/

Authors
-------

- Juan David Arcila Moreno
