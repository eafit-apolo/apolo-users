.. _2.6.4p104-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

Ruby - 2.6.4p104
================

Basic information
-----------------

- **Deploy date:** 28 August 2019
- **Official Website:** https://www.ruby-lang.org/en/
- **License:** https://www.ruby-lang.org/en/about/license.txt
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`


Installation
------------

.. note:: The Intel Compiler will be used to build Ruby.

1. Download the selected version from an official mirror (https://www.ruby-lang.org/en/downloads/).

.. code-block:: bash

    $ wget https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.4.tar.gz
    $ tar -zxvf ruby-2.6.4.tar.gz

2. Load the corresponding modules to set the building environment.

.. code-block:: bash

    $ module purge # Clean predefined environment
    $ module load intel/19.0.4

3. Configure and build the sources.

.. code-block:: bash

    $ cd ruby-2.6.4
    $ mkdir build && cd build
    $ debugflags="" CFLAGS="-O3 -xHost" CXXFLAGS="-O3 -xHost" ../configure --prefix=/share/apps/ruby/2.6.4p104/intel/19.0.4
    $ make
    $ make check
    $ sudo su
    $ module load intel/19.0.4
    $ make install

Module
------

The following is the module used for this version.

.. code-block:: tcl

    #%Module1.0#####################################################################
    ##
    ## modulefile ruby/2.6.4_intel-19.0.4
    ##
    ## Written by Santiago Hidalgo Ocampo and Samuel David Palacios B.
    ##
    proc ModulesHelp { } {
        global version modroot
        puts stderr "\truby - Interpretive, interactive programming language"
    }

    module-whatis "\n\n\tSets the environment for using ruby 2.6.4p104 binaries \
                \n\tprovided by Intel (2019 update 4)\n"

    conflict ruby

    # for Tcl script use only
    set     topdir       /share/apps/ruby/2.6.4p104/intel/19.0.4
    set     version      2.6.4p104
    set     sys          x86_64-redhat-linux

    module load intel/19.0.4

    prepend-path    PATH                            $topdir/bin

    prepend-path    LD_LIBRARY_PATH                 $topdir/lib
    prepend-path    LIBRARY_PATH                    $topdir/lib
    prepend-path    LD_RUN_PATH                     $topdir/lib

    prepend-path    C_INCLUDE_PATH                  $topdir/include
    prepend-path    CXX_INCLUDE_PATH                $topdir/include
    prepend-path    CPLUS_INCLUDE_PATH              $topdir/include

    prepend-path    MANPATH                         $topdir/share/man

    prepend-path    PKG_CONFIG_PATH                 $topdir/lib/pkgconfig




Authors
-------

- Santiago Hidalgo Ocampo <shidalgoo1@eafit.edu.co>
- Samuel David Palacio Bernate <sdpalaciob@eafit.edu.co>
