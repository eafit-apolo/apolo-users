.. _ga-14:

************
GAMESS 2014
************

- **Installation date:** 02/09/2016
- **URL:** http://www.msg.ameslab.gov/GAMESS/
- **Apolo version:** Apolo I
- **License:** ACADEMIC LICENSE

.. contents:: Table of Contents

Dependencies
--------------

- FORTRAN compiler

Installation
------------

#. First download the tar from the main page, then:

.. code-block:: bash

    $ tar -zxvf gamess-current.tar.gz
    $ cd gamess/2014-R1

#. Gamess configuration

.. code-block:: bash

    $ ./config

#. The above command is interactive, so it will ask several questions in the following

.. code-block:: bash

    GAMESS can compile on the following 32 bit or 64 bit machines? linux64
    GAMESS directory? [/share/apps/gamess/2014-R1]
    GAMESS build directory? [/share/apps/gamess/2014-R1]
    Version? [00]
    Please enter your choice of FORTRAN? ifort
    Version? 15
    Enter your choice of 'mkl' or 'atlas' or 'acml' or 'none'? mkl
    MKL pathname? /share/apps/intel/15/mkl
    MKL version (or 'skip')? skip
    Communication library ('sockets' or 'mpi')? sockets (Esta elección obedece a que la versión de MPI solo puede usarse si se cuenta con Infiniband)
    Do you want to try LIBCCHEM? (yes/no)? no

then

.. code-block:: bash

    $ cd ddi
    $ ./compddi 2>&1 | tee compddi.log
    $ mv ddikick.x ..
    $ cd ..
    $ ./compall 2>&1 | tee compall.log
    $ ./lked gamess 00 2>&1 | tee lked.log


Module
---------

.. code-block:: bash

   #%Module1.0#####################################################################
    ##
    ## modules gamess/dec-5-2014-R1
    ##
    ## /share/apps/modules/gamess/dec-5-2014-R1  Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp { } {
        puts stderr "\tgamess/dec-5-2014-R1 - sets the Environment for gamess in \
        \n\tthe share directory /share/apps/gamess/dec-5-2014-R1/intel-15/mkl-15\n"
    }

    module-whatis "\n\n\tSets the environment for gamess assembler \
                  \n\tbuilded with Intel 15 and MKL 15 version\n"

    # for Tcl script use only
    set       topdir     /share/apps/gamess/dec-5-2014-R1/intel-15/mkl-15
    set       version    1.2.10
    set       sys        x86_64-redhat-linux

    conflict gamess

    module load intel/15.1.10.380555
    module load mkl/15.1.10.380555

    prepend-path    PATH			$topdir

References
------------

- http://www.mothur.org/
- https://github.com/mothur/mothur
- https://github.com/mothur/mothur/releases
- http://www.mothur.org/wiki/Makefile_options
- http://www.mothur.org/wiki/Main_Page

Author
------

- Mateo Gómez Zuluaga
