.. _ SMOKE-4.8.1-index:

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents

    .. contents::
        :depth: 2
        :local:


SMOKE 4.8.1 Installation
========================

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux (x86_64) :math: `\boldsymbol{\ge}` 8.5
- **Compiler:** GCC 9.3.0
- **Requirements:**

- GCC = 9.3.0
- MPICH = 3.4.2
- Zlib = 1.2.11
- Curl = 7.77.0
- Netcdf-c disable netcdf-4 = 4.8.0
- Netcdf-fortran = 4.5.3
- Zstd = 1.5.2
- ioapi = 3.2.1
- tcsh

Installation
------------

This entry covers the entire process performed for the installation and configuration
of SMOKE 4.8.1 with a GCC compiler

Create a directory for SMOKE and download the source code
---------------------------------------------------------

    .. code-block:: bash

        mkdir SMOKE
        cd SMOKE
        wget https://github.com/CEMPD/SMOKE/releases/download/SMOKEv481_Jan2021/smoke_install_v481.csh
        wget https://github.com/CEMPD/SMOKE/releases/download/SMOKEv481_Jan2021/smoke_v481.Linux2_x86_64ifort.tar.gz
        wget https://github.com/CEMPD/SMOKE/releases/download/SMOKEv481_Jan2021/smoke_v481.nctox.data.tar.gz


Install SMOKE
-------------

From this poin onwards all the commands given have to be executed with tcsh,
since SMOKE only works with tcsh.

Set your SMK_HOME directory for the installation and load libraries.

    .. code-block:: tcsh

        setenv SMK_HOME $cwd

        $ module load gcc/9.3.0
        $ module load mpich/3.4.2_gcc-9.3.0
        $ module load zlib/1.2.11_gcc-9.3.0
        $ module load curl/7.77.0_gcc-9.3.0
        $ module load netcdf-fortran/4.5.3_gcc-9.3.0_disable-netcdf-4



unzip all files with the provided script.

    .. code-block:: tcsh

        source smoke_install.csh

The script will point the possible problems that may arise.

Create the ioapi folder to make the symbolic link to the already compiled ioapi.

    .. code-block:: tcsh

        cd subsys

        mkdir -p ioapi/ioapi

        cd ioapi/ioapi

        ln -s <ioapi_path>/* .

After linking the ioapi folder, we need to link all the files in the lib
folder to the Linux2_x86_64gfort folder.

    .. code-block:: tcsh

        cd <ioapi_path>/Linux2_x86_64gfort

        ln -s <ioapi_path>/lib/* .

After creating the links change the line 25 in of the file in the following path $SMK_HOME/subsys/smoke/assigns/ASSIGNS.nctox.cmaq.cb05_soa.us12-nc

Change

    .. code-block:: tcsh

        setenv BIN    Linux2_x86_64ifort

to

    .. code-block:: tcsh

        setenv BIN    Linux2_x86_64gfort

so that the compilation uses the gfort compiler.

After that, compile.

    .. code-block:: tcsh

        cd $SMK_HOME/subsys/smoke/src

        make
