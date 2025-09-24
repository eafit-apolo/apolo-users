.. _ NCAR_NCL_6.6.2-index:

.. role:: bash(code)
    :language: bash

.. sidebar:: contents

    .. contents::
        :depth: 2
        :local:


NCAR NCL 6.6.2 installation
===========================

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux (x86_64) :math: `\boldsymbol{\ge}` 8.5
- **Compiler:** GCC 9.3.0
- **Requirements:**

- GCC = 9.3.0
- pixman = 0.38.0
- libpng = 1.6.37
- cairo = 1.16.0
- libportablexdr = 4.9.1
- libjpeg = 9e
- libtirpc = 1.3.3
- HDF-4 = 4.2.15
- szip = 2.1.1
- HDF-5 = 1.10.4
- zlib = 1.2.11
- curl = 7.77.0
- netcdf = 4.8.1
- freetype = 2.9.1
- expat = 2.5.0
- gperf = 3.1
- libfontconfig = 2.14.2
- bzip2 = 1.0.8
- libflex = 2.6.4
- java = jdk-17.0.2

Installation
____________

This entry covers the entire process performed for the installation and configuration
of NCL 6.6.2 with a GCC compiler

Download the source code and extract it.
----------------------------------------

    .. code-block:: bash

        wget https://www.earthsystemgrid.org/dataset/ncl.662.src/file/ncl_ncarg-6.6.2.tar.gz
        tar xvzf ncl_ncarg-6.6.2.tar.gz


Create the basic configuration
------------------------------

    .. code-block::bash

        cd ncl_ncarg-6.6.2/config
        make -f Makefile.ini
        ./ymake -config `pwd`


if you get the following message: ::

            ymake: system unknown

Refer to the following `link <https://www.ncl.ucar.edu/Download/build_from_src.shtml#AppendixA>`__ for instructions on how to make the script recognize your system.

Get the name of the configuration file to be used
-------------------------------------------------

    .. code-block::bash

        grep SYSTEM_INCLUDE Makefile


this will give you the name of the file to be used for the configuration of NCL, in this case the file to be used will be LINUX.


.. warning::

    From this point onwards the configuration shown here has only been done and tested on the Apolo II supercomputer,
    this configuration may or may not apply for other systems, however, it may be used as a guide in what steps should be done
    in order to compile NCL.

    For more specific errors not shown here, it is adviced to search on your own or write to the developers on the following `link <https://mailman.ucar.edu/mailman/listinfo/ncl-install>`__ , however,
    steps that can be followed to find the specific problem or solve a problem similar to those shown here will be given throught this documentation.


Modify the configuration file
-----------------------------

Since the Makefile cannot be modified whithout changing it's permissions, we need to modify the configuration file which you can find in the ncl_ncarg-6.6.2/config.

* Adding the flags


    Add the following flags::

            #define CtoFLibraries   -lgfortran -lm -lportablexdr -lhdf5_hl -lhdf5

    in addittion, also check that the following flags correspond to the compiler that is being used::

            #define CCompiler   gcc
            #define FCompiler   gfortran


    .. note::

        The flags in ``#define CtoFLibraries`` may change depending on errors while compiling, hence if an error occurs the recommended way to debug the error is
        to first check what library or dependency is the source of the error, check if it has include flags, add them and recompile.

        This proccess may not resolve the issue, however is a good place to start the debugging process.


* Adding the include paths


    Add the following paths::

        -I/usr/include -I/share/apps/cairo/1.16.0/gcc-9.3.0/include -I/share/apps/pixman/0.38.0/gcc-9.3.0/include
        -I/share/apps/libpng/1.6.37/gcc-9.3.0/include -I/share/apps/szip/2.1.1/gcc-9.3.0/include -I/share/apps/hdf5/1.10.4/gcc-9.3.0/include
        -I/share/apps/netcdf/4.8.1/gcc-9.3.0/include -I/share/apps/libportablexdr/4.9.1/gcc-9.3.0/include -I/share/apps/zlib/1.2.11/gcc-9.3.0/include
        -I/share/apps/libjpeg/9e/gcc-9.3.0/include -I/share/apps/hdf4/4.2.15/gcc-9.3.0/include -I/share/apps/freetype/2.9.1/gcc-9.3.0/include/freetype2
        -I/share/apps/expat/2.5.0/gcc-9.3.0/include -I/share/apps/libfontconfig/2.14.2/gcc-9.3.0/include -I/share/apps/bzip2/1.0.8/gcc-9.3.0/include
        -I/share/apps/libflex/2.6.4/gcc-9.3.0/include


    to the following variables::

        #define IncSearchUser
        #define ArchRecIncSearch

    This way NCL will be able to recognize where all the files to include are.

    .. note::

        A particular problem that may arise is that it wont be able to find ft2build.h, in this case look for where the file is and add the path to
        the variables no matter if there is already an include for this particular library.

        This same process can be replicated for other include files that may throw errors in the compilation.


* Adding the library paths


    Add the following paths::

        -L/usr/lib64 -L/share/apps/cairo/1.16.0/gcc-9.3.0/lib -L/share/apps/pixman/0.38.0/gcc-9.3.0/lib -L/share/apps/libpng/1.6.37/gcc-9.3.0/lib
        -L/share/apps/szip/2.1.1/gcc-9.3.0/lib -L/share/apps/hdf5/1.10.4/gcc-9.3.0/lib -L/share/apps/netcdf/4.8.1/gcc-9.3.0/lib -L/share/apps/libportablexdr/4.9.1/gcc-9.3.0/lib
        -L/share/apps/zlib/1.2.11/gcc-9.3.0/lib -L/share/apps/libjpeg/9e/gcc-9.3.0/lib -L/share/apps/hdf4/4.2.15/gcc-9.3.0/lib -L/share/apps/freetype/2.9.1/gcc-9.3.0/lib
        -L/share/apps/expat/2.5.0/gcc-9.3.0/lib -L/share/apps/libfontconfig/2.14.2/gcc-9.3.0/lib -L/share/apps/bzip2/1.0.8/gcc-9.3.0/lib -L/share/apps/libflex/2.6.4/gcc-9.3.0/lib


    to the following variables::

        #define LibSearchUser
        #define ArchRecLibSearch


    .. warning::

        For other systems and compilers, these paths may not be the same so remember to always check that the paths correspond to were the files are located in your
        system.

Generate the makefile
---------------------

.. code-block:: bash

        cd ncl_ncarg-6.6.2
        ./Configure -v


And configure based on your needs, for this specific configuration the options chosen were the following::

    Build NCL (y)?
    Enter Return (default), y(yes), n(no), or q(quit) > y

    Parent installation directory : /usr/local/ncarg
    Enter Return (default), new directory, or q(quit) > /share/apps/ncl/6.6.2/gcc-9.3.0

    System temp space directory   : /tmp
    Enter Return (default), new directory, or q(quit) > /tmp

    Build NetCDF4 feature support (optional)? (y)
    Requires the NetCDF version 4.1.2 or later.
    Enter Return (default), y(yes), n(no), or q(quit) > y

    Build HDF4 support (optional) into NCL? (y)
    Informational note: HDF4 is no longer required to build NCL,
    but it is a prerequisite if you need HDF-EOS2 support.
    (Requires external HDF-4 libraries available from
    http://www.hdfgroup.org/release4/obtain.html)
    Please see the instructions at
    http://www.ncl.ucar.edu/Download/build_from_src.shtml#HDF-4
    to make sure your HDF software is built according to NCL requirements.
    Enter Return (default), y(yes), n(no), or q(quit) > y

    Also build HDF4 support (optional) into raster library? (y)
    Enter Return (default), y(yes), n(no), or q(quit) > y

    Did you build HDF4 with szip support? (n)
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build Triangle support (optional) into NCL (y)
    Requires 'triangle.c' and 'triangle.h' code from
    http://www.cs.cmu.edu/~quake/triangle.html
    You must agree to the license restrictions in the above URL,
    download these two files, and put them in ni/src/lib/hlu
    Enter Return (default), y(yes), n(no), or q(quit) > n

    If you are using NetCDF V4.x, did you enable NetCDF-4 support (y)?
    (Requires compiling NetCDF-4 library available from
    http://www.unidata.ucar.edu/software/netcdf/
    and building with '--enable-netcdf-4')
    Enter Return (default), y(yes), n(no), or q(quit) > y

    Did you build NetCDF with OPeNDAP support (y)?
    (OPeNDAP support is only available for NetCDF 4.1 or later)
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build GDAL support (optional) into NCL? (n)
    (Requires GDAL and PROJ4 from http://www.gdal.org/ and
    http://trac.osgeo.org/proj/)
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build EEMD support (optional) into NCL? (y)
    (Requires GSL ftp://ftp.gnu.org/gnu/gsl/
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build Udunits-2 support (optional) into NCL (y)
    (Requires the external V2.x Udunits [not V1.x] library available from
    http://www.unidata.ucar.edu/software/udunits/udunits-2/udunits2.html)
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build Vis5d+ support (optional) into NCL (n)
    (Requires the external Vis5d+ software available from
    http://vis5d.sourceforge.net/)
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build HDF-EOS2 support (optional) into NCL (y)
    (Requires the external HDF-EOS2 libraries available from
    http://newsroom.gsfc.nasa.gov/sdptoolkit/toolkit.html. You
    must also have included support for HDF4.)
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build HDF5 support (optional) into NCL (y)
    (Requires the external HDF5 library available from
    http://www.hdfgroup.org/ftp/HDF5/current/src/
    Enter Return (default), y(yes), n(no), or q(quit) > y

    Build HDF-EOS5 support (optional) into NCL (y)
    (Requires the external HDF-EOS5 library available from
    ftp://edhs1.gsfc.nasa.gov/pub)
    Enter Return (default), y(yes), n(no), or q(quit) > n

    Build GRIB2 support (optional) into NCL (y)
    (Requires the GRIB2 decoder (g2clib) library and jasper from
    http://www.nco.ncep.noaa.gov/pmb/codes/GRIB2/ and
    http://www.ece.uvic.ca/~mdadams/jasper/)
    Enter Return (default), y(yes), n(no), or q(quit) > n


.. note::

    Options not mentioned here are either to the discretion of the person compiling or the default option given, since those are the include and library paths.


.. warning::

    Building support for the optional libraries specified in the configuration requires compiling extra libraries and dependencies not listed at the top of this
    documentation that may incurr in more errors at the time of compilation.

Install
-------

.. code-block:: bash

    make Everything 2>&1 | tee make-output


Check the compilation
---------------------

check the make-output file for errors and look if any of those errors look like any of the ones mentioned in the notes on this documentation.


Module file
-----------

.. code-block:: tcl

    #%Module1.0#####################################################################
    ##
    ## modules ncl6.6.2_gcc-9.3.0
    ##
    ## /share/apps/ncl/6.6.2/gcc-9.3.0
    ##

    proc ModulesHelp { } {
        puts stderr "\t6.6.2gcc-9.3.0 - sets the Enviroment for NCL in \
        \n\tthe share directory /share/apps/modules/ncl/6.6.2_gcc-9.3.0\n"
    }

    module-whatis "\n\n\tSets the enviroment for NCL\
                \n\tbuilt with gcc-9.3.0\n"

    #for TCL script use only
    set       topdir     /share/apps/ncl/6.6.2/gcc-9.3.0
    set       version    6.6.2
    set       sys        x86_64-redhat-linux

    conflict ncl

    module load pixman/0.38.0_gcc-9.3.0 libpng/1.6.37_gcc-9.3.0 cairo/1.16.0_gcc-9.3.0 libportablexdr/4.9.1_gcc-9.3.0 hdf4/4.2.15_gcc-9.3.0 libjpeg/9e_gcc-9.3.0 hdf5/1.10.4_gcc-9.3.0 libjpeg/9e_gcc-9.3.0 zlib/1.2.11_gcc-9.3.0 cairo/1.16.0_gcc-9.3.0 hdf4/4.2.15_gcc-9.3.0 netcdf/4.8.1_gcc-9.3.0 freetype/2.9.1_gcc-9.3.0 expat/2.5.0_gcc-9.3.0 gperf/3.1_gcc-9.3.0 libfontconfig/2.14.2_gcc-9.3.0 bzip2/1.0.8_gcc-9.3.0 libflex/2.6.4_gcc-9.3.0 gcc/9.3.0

    prepend-path    LD_LIBRARY_PATH         $topdir/lib
    prepend-path    LD_RUN_PATH             $topdir/lib
    prepend-path    LIBRARY_PATH            $topdir/lib

    prepend-path    PATH                    $topdir/lib/ncarg/data/bin

    prepend-path    C_INCLUDE_PATH          $topdir/include
    prepend-path    CXX_INCLUDE_PATH        $topdir/include
    prepend-path    CPLUS_INCLUDE_PATH      $topdir/include

    prepend-path    PATH                    $topdir/bin

    prepend-path    MANPATH                 $topdir/man


Test the application
--------------------

.. code-block:: bash

    ncl -V
    ng4ex gsun01n


if both commands work without giving any errors, and the file gsun01n.ncl is in your directory, the compilation was succesful.


Authors
-------

- Jacobo Monsalve Guzman <jmonsalve@eafit.edu.co>
