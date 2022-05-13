.. _ioapi-3.2.1:

.. contents:: Table of Contents

***********
IOAPI 3.2.1
***********

- **Installation date:** 03/03/2022
- **URL:** https://github.com/cjcoats/ioapi-3.2
- **Apolo version:** Apolo II


Dependencies
-------------

- GCC = 9.3.0
- MPICH = 3.4.2
- Zlib = 1.2.11
- Curl = 7.77.0
- Netcdf-c disable netcdf-4 = 4.8.0
- Netcdf-fortran = 4.5.3
- Zstd = 1.5.2

Installation
-------------

After solving the aforementioned dependencies, you can proceed with the installation.

1. Download the binaries

.. code-block:: bash

    $ cd /home/blopezp
    $ mkdir ioapi
    $ cd ioapi
    $ git clone https://github.com/cjcoats/ioapi-3.2.git

2. Define the architecture to use and create the directory with the same name of the architecture, in our case "Linux2_x86_64gfort".

.. code-block:: bash

    $ export BIN=Linux2_x86_64gfort
    $ mkdir Linux2_x86_64gfort
    $ ln -sf /share/apps/netcdf-fortran/4.5.3_disable-netcdf-4/gcc-9.3.0/lib/* Linux2_x86_64gfort/

3. Units and files.

.. code-block:: bash

    $ module load gcc/9.3.0
    $ module load mpich/3.4.2_gcc-9.3.0
    $ module load zlib/1.2.11_gcc-9.3.0
    $ module load curl/7.77.0_gcc-9.3.0
    $ module load netcdf-fortran/4.5.3_gcc-9.3.0_disable-netcdf-4

    $ cp ioapi/Makefile.nocpl ioapi/Makefile
    $ cp m3tools/Makefile.nocpl m3tools/Makefile
    $ cp Makefile.template Makefile

4. Add the lines in the Makefile.

.. code-block:: bash

    $ Vim Makefile

    CPLMODE    = nocpl
    PVMINCL    = /dev/null
    LIBINST   = /home/blopezp/ioapi/lib
    BININST   = /home/blopezp/ioapi/bin
    VERSION    = 3.2-${CPLMODE}
    BASEDIR    = ${PWD}
    NCFLIBS    = -L/share/apps/netcdf-fortran/4.5.3_disable-netcdf-4/gcc-9.3.0/lib -lnetcdff -lnetcdf -lcurl -lzstd -lz
    IODIR      = $(BASEDIR)/ioapi
    FIXDIR     = $(IODIR)/fixed_src
    HTMLDIR    = $(BASEDIR)/HTML
    TOOLDIR    = $(BASEDIR)/m3tools
    OBJDIR     = $(BASEDIR)/$(BIN)

5. Add the lines in the ioapi/Makefile.

.. code-block:: bash

    $ vim ioapi/Makefile

    BASEDIR = /home/blopezp/ioapi
    INSTDIR = /home/blopezp/ioapi/lib
    IODIR  = ${BASEDIR}/ioapi

5. Add the lines in the ioapi/Makeinclude.Linux2_x86_64gfort

.. code-block:: bash

    $ vim ioapi/Makeinclude.Linux2_x86_64gfort

    OMPFLAGS  =
    OMPLIBS   =
    -DIOAPI_NO_STDOUT=1 -DIOAPI_NCF4=1

6. Add the lines in the m3tools/Makefile.

.. code-block:: bash

    BASEDIR = /home/blopezp/ioapi
    SRCDIR  = ${BASEDIR}/m3tools
    IODIR   = ${BASEDIR}/ioapi
    OBJDIR  = ${BASEDIR}/${BIN}
    INSTDIR = /home/blopezp/ioapi/bin

7. Compile Makefile

.. code-block:: bash

    $ make |& tee make.log
    $ make install |& tee make-install.log

8. Test.

.. code-block:: bash

    $ ./Linux2_x86_64gfort/juldate

.. note::
    Users need IOAPI in their respective home for the compilation of WRF-CMAQ, as they need to change data.


References
-----------

- https://github.com/cjcoats/ioapi-3.2.1

:Author:

- Bryan López Parra <blopezp@eafit.edu.co>
