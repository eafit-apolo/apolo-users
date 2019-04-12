.. _opensees-3.0.0-index:

.. role:: bash(code)
   :language: bash

OpenSees 3.0.0
==============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://opensees.berkeley.edu/
- **License:** 	http://opensees.berkeley.edu/OpenSees/copyright.php
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
  , :ref:`Cronos <about_cronos>`


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Compiler:** Intel MPI Library :math:`\boldsymbol{\ge}` 17.0.1 (Apolo)
* **Math Library:** ScaLAPACK :math:`\boldsymbol{\ge}` 2.0.2 and MUMPS :math:`\boldsymbol{\ge}` 5.0.2


Installation
------------

The following procedure present the way to compile OpenSeesMP and its dependencies
for distributed computing using Intel MPI.

#. Download the latest version of OpenSees from Github

   .. code-block:: bash

      $ wget https://github.com/OpenSees/OpenSees/archive/v3.0.0.tar.gz
      $ tar xf v3.0.0.tar.gz

#. Inside the folder, on the top create a :file:`Makefile.def` file using. You can copy one of the examples from the
   MAKES folder depending of your architecture and adapt it.

    .. code-block:: bash

        $ cp MAKES/Makefile.def.INTEL2 ./Makefile.def

    .. note::

        We recommend to use our :file:`Makefile.def` which has been simplified for OpenSeesMP and Intel MPI. :download:`Makefile.def <src/Makefile.def>`

#. Modify the following lines in the :file:`Makefile.def`

    .. code-block:: make

        # The location where the OpenSees folder is placed. It is expected for the sake of simplicity that the OpenSees'
        # folder is named just **OpenSees** because of the Makefile.def will look for this name in the HOME folder in all
        # defined paths.
        HOME  = /home/jyepesr1/source

        # The location of the final binary. NOTE: create the bin folder previously.
        OpenSees_PROGRAM = $(HOME)/OpenSees/bin/OpenSeesMP

        # Ensure you have the tcl library installed and check its version, in that case 8.5. libtcl8.5 is located in
        # an standard location /usr/lib64/libtcl8.5.so, after the package installation.
        TCL_LIBRARY = -ltcl8.5

        # MUMPS dir where it was compiled.
        MUMPS_DIR = /home/jyepesr1/source/mumps

        # MUMPS has some dependencies scotch, ptscotch, metis and parmetis which are the serial and parallel versions
        # scotch and ptscoth are in the same folder because they are compiled together.
        SCOTCHDIR  = /home/jyepesr1/apps/scotch/6.0.6
        METISDIR = /home/jyepesr1/apps/metis/5.1.0
        PARMETISDIR = /home/jyepesr1/apps/parmetis/4.0.3

        # Parallel lib, we can use ScaLAPACK or MKL, in that case we will the first one because there are some routines
        # in OpenSees NOT well supported with MKL and your code could fail.
        PARALLEL_LIB = -L/home/jyepesr1/apps/scalapack/2.0.2-impi_18.0.2/lib -lscalapack -lreflapack -lrefblas -ltmg

#. Create the :file:`lib/` and :file:`bin/` directories in the OpenSees top folder, where the compilation will place
   its files.

   .. code-block:: bash

      $ mkdir OpenSees/{bin,lib}

.. note:: Remember to load the Intel MPI module for all compilations. :bash:`module load impi/2017_update-1`

#. Compile ScaLAPACK as follow

    ScaLAPACK integrates a python script which can configure and install in a quick way all the requirements and the library
    itself, so we strongly recommend use this method.

    .. code-block:: bash

      $ wget http://www.netlib.org/scalapack/scalapack_installer.tgz
      $ tar xf scalapack_installer.tgz
      $ cd scalapack_installer/

    Edit the :file:`netlib.py` file changing the :bash:`cc` and :bash:`fc` variables to use the Intel compiler.

    .. code-block:: python

        cc          = "icc"          # the C compiler for plasma
        fc          = "ifort"        # the Fortran compiler for core_lapack

    Create the folder where the build will be placed and execute the :file:`setup.py` command. Check what options
    are the best choice for your architecture.

    .. code-block:: bash

        $  mkdir -p /home/jyepesr1/source/apolo/scalapack/2.0.2-impi_17.0.1
        $ ./setup.py --prefix=/home/jyepesr1/source/apolo/scalapack/2.0.2-impi_17.0.1 \
          --mpibindir=/share/apps/intel/ps_xe/2017_update-1/compilers_and_libraries/linux/mpi/bin64 \
          --mpicc=mpiicc --mpif90=mpiifort \
          --mpiincdir=/share/apps/intel/ps_xe/2017_update-1/compilers_and_libraries/linux/mpi/include64 \
          --ccflags="-xHost -O3" --fcflags="-xHost -O3" --downall --ldflags_fc="-nofor_main"

    .. note:: When compiling with Intel the configuration will require the :bash:`-nofor_main` flag in the
              fortran linker because the compiler will try to look for the main function in the fortran files
              by default.

    .. note:: The program will try to execute some examples to test MPI in C and Fortran. In our case these
             examples will fail because in our architecture MPI cannot run without :bash:`srun --mpi=pmi2` command

    .. warning:: The following steps are optional and will be executed due to the restriction of our current architecture

    Edit the :file:`scripts/framework.py` file to avoid execution halt due to mpirun restrictions. Go to the
    functions :bash:`def check_mpicc()` and  :bash:`def check_mpif90()`, and comment out the lines for that checks the mpirun
    execution.

    .. code-block:: python

        def check_mpicc(self):
            .
            .
            .
            # run
            # comm = self.config.mpirun + ' ./tmpc'
            # (output, error, retz) = runShellCommand(comm)
            # if retz:
            #     print '\n\nCOMMON: mpirun not working! aborting...'
            #     print 'error is:\n','*'*40,'\n',error,'\n','*'*40
            #     sys.exit()

            .
            .
            .

        def check_mpif90(self):
            .
            .
            .
            # run
            # comm = self.config.mpirun + ' ./tmpf'
            # (output, error, retz) = runShellCommand(comm)
            # if retz:
            #     print '\n\nCOMMON: mpif90 not working! aborting...'
            #     print 'error is:\n','*'*40,'\n',error,'\n','*'*40
            #     sys.exit()

    .. warning:: Sometimes depending of your architecture the different tests could fail, in such case you can ignore
                  them and continue checking that all libraries have been placed in the destination folder.

    The final step is checking that the libraries are placed in the destination folder.

    ::

        $ tree /home/jyepesr1/source/apolo/scalapack/2.0.2-impi_17.0.1/lib/

        /home/jyepesr1/source/apolo/scalapack/2.0.2-impi_17.0.1/lib/
        ├── librefblas.a
        ├── libreflapack.a
        ├── libscalapack.a
        └── libtmg.a


#. Compile MUMPS as follow

   Before compile MUMPS its dependencies have to be installed, therefore perform the following steps.

    - Download and build **scotch** and **ptscotch**

        .. code-block:: bash

            $ wget https://gforge.inria.fr/frs/download.php/file/37622/scotch_6.0.6.tar.gz
            $ tar xf scotch_6.0.6.tar.gz
            $ cd scotch_6.0.6/src
            $ ln -s Make.inc/Makefile.inc.x86-64_pc_linux2.icc.impi Makefile.inc

        Edit the :file:`Makefile.inc` adding the directive :bash:`-DINTSIZE64` at the end of the :bash:`CFLAGS` variable
        to support integers of 64 bits.

        Finally, compile the lib **ptesmumps**.

        .. code-block:: bash

            $ make -j10 ptesmumps

        .. note:: The built libraries will be located in the :file:`lib/` folder under the :file:`scotch_6.0.6` folder

    - Download and build **ParMETIS** and **METIS**

        .. code-block:: bash

            $ wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz
            $ tar xf parmetis-4.0.3.tar.gz
            $ cd parmetis-4.0.3

        Edit the file :file:`metis/include/metis.h` and specify 64 bits integers in the **IDXTYPEWIDTH** and
        **REALTYPEWIDTH** constants.

        After, configure the ParMETIS installation as follow:

        .. code-block:: bash

            $ module load cmake/3.7.1
            $ make config openmp=-qopenmp cc=mpiicc cxx=mpiicpc prefix=<install folder>
            $ make -j10
            $ make install

        To build METIS, go to the :file:`metis/` folder and execute the following:

        .. code-block:: bash

            $ make config openmp=-qopenmp cc=mpiicc prefix=<install folder>
            $ make -j10
            $ make install

   Go to the MUMPS folder and copy an example of a Makefile from the :file:`Make.inc/` folder to edit its content

   .. code-block:: bash

        $ wget http://mumps.enseeiht.fr/MUMPS_5.0.2.tar.gz
        $ tar xf MUMPS_5.0.2.tar.gz
        $ cd MUMPS_5.0.2
        $ ln -s Make.inc/Makefile.INTEL.PAR Makefile.inc

   Edit the following lines in the :file:`Makefile.inc`.

   .. code-block:: make
      :caption: :download:`Makefile.inc <src/Makefile.inc>`

        # Change and uncomment the location of the Scotch installation folder and its include dir
        SCOTCHDIR  = /home/jyepesr1/source/apolo/opensees-3.0.0_install/scotch_6.0.6
        ISCOTCH    = -I$(SCOTCHDIR)/include

        # Uncomment the parallel scotch libraries
        LSCOTCH    = -L$(SCOTCHDIR)/lib -lptesmumps -lptscotch -lptscotcherr -lscotch

        # Change and uncomment the location of the METIS installation folder and its include dir
        LMETISDIR = /home/jyepesr1/source/apolo/opensees-3.0.0_install/parmetis-4.0.3/metis
        IMETIS    = $(LMETISDIR)/include

        # Add the location of the ParMETIS folder
        LPARMETISDIR = /home/jyepesr1/source/apolo/opensees-3.0.0_install/parmetis-4.0.3/
        IPARMETIS    = $(LMETISDIR)/include

        # Uncomment the METIS and parMETIS libraries
        LMETIS    = -L$(LMETISDIR)/lib -lmetis
        LPARMETIS = -L$(LPARMETISDIR)/lib -lparmetis

        # Uncomment the following line and delete the next one
        ORDERINGSF = -Dscotch -Dmetis -Dpord -Dptscotch -Dparmetis

        # Modify the following variables adding the ParMETIS option
        LORDERINGS = $(LPARMETIS) $(LMETIS) $(LPORD) $(LSCOTCH)
        IORDERINGSC = $(IPARMETIS) $(IMETIS) $(IPORD) $(ISCOTCH)

        # Edit the LIBPAR variable to link against Intel MKL.
        # REMEMBER to load the module. module load mkl/2017_update-1
        # You can delete the other variables in that section, we will just need LIBPAR.
        LIBPAR =  $(MKLROOT)/lib/intel64/libmkl_blas95_ilp64.a $(MKLROOT)/lib/intel64/libmkl_lapack95_ilp64.a \
        -L$(MKLROOT)/lib/intel64 -lmkl_scalapack_ilp64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core \
        -lmkl_blacs_intelmpi_ilp64 -lpthread -lm -ldl

        # At the end in the compiler flags for C and Fortran change -openmp for -qopenmp
        OPTF    = -O -DALLOW_NON_INIT -nofor_main -qopenmp
        OPTL    = -O -nofor_main -qopenmp
        OPTC    = -O -qopenmp


   .. note:: If you want to use scaLAPACK instead of Intel MKL, set the :bash:`LIBPAR` variable as:

      .. code-block:: bash

          -L/home/jyepesr1/source/apolo/scalapack/2.0.2-impi_17.0.1/lib -lscalapack -lreflapack -lrefblas -ltmg

References
----------

Authors
-------

- Johan Sebastián Yepes Ríos <jyepesr1@eafit.edu.co>
