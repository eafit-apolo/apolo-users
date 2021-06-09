.. _R-4.0.3-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

R - 4.0.3
=========

Basic information
-----------------

- **Deploy date:** 29 January 2021
- **Official Website:** https://www.r-project.org/
- **License:** https://www.r-project.org/Licenses/
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Dependencies
------------
* zlib >= 1.2.5
* bzip2 >= 1.0.6 compiled with :code:`-fPIC` option
* xz (liblzma) REF https://tukaani.org/xz/
* PCRE >= 8.20 > 10.0 with UTF-8 support
* curl >= 7.22 with https support
* libicu-4.2.1-14.el6.x86_64 and libicu-devel-4.2.1-14.el6.x86_64
* BLAS and LAPACK (Optional) with OpenBlas or MKL
* JDK >= 1.7.0

Installation
------------
After the dependencies have been resolved and configured, the **R** installation can start.

.. note:: The GCC Compiler will be used to build R.

1. Download the selected version from an official mirror (https://cran.r-project.org/mirrors.html).

.. code-block:: bash

    $ wget https://cran.r-project.org/src/base/R-4/R-4.0.3.tar.gz
    $ tar -zxvf R-4.0.3.tar.gz

2. Load the corresponding modules to set the building environment.

.. note:: For BLAS and LAPACK is recommended to use Intel MKL (https://software.intel.com/en-us/articles/build-r-301-with-intel-c-compiler-and-intel-mkl-on-linux)

.. code-block:: bash

    $ module purge # Clean predefined environment
    $ module load zlib/1.2.11_gcc-7.4.0 bzip2/1.0.6 lapack/3.9.0 gcc/7.4.0 pcre/8.39 xz/5.2.2 curl/7.51.0 java/jdk-1.8.0_112 mkl/19.0.4

3. Configure and build the sources.

.. code-block:: bash

    $ CXX98="gcc -std=c++98" CXX11="gcc -std=c++11" CXX14="gcc -std=c++14" CXX17="gcc -std=c++17" \
        ../configure --enable-lto="bootstrap-lto" --prefix=/share/apps/r/4.0.3/gcc/7.4.0 \
        --enable-java --build=x86_64-redhat-linux --enable-R-shlib \
        --with-blas="-lmkl_blas95_lp64 -liomp5 -lpthread" \
        --with-lapack="-lmkl_scalapack_lp64" --enable-BLAS-shlib \
        --without-x --enable-memory-profiling \
        LDFLAGS="$LDFLAGS \
                -L/share/apps/bzip2/1.0.6/lib \
                -L/share/apps/pcre/8.39/lib \
                -L/share/apps/xz/5.2.2/lib" \
        CFLAGS="$CFLAGS -fPIC -fopenmp -O3 -mavx2 \
                -I/share/apps/bzip2/1.0.6/include \
                -I/share/apps/pcre/8.39/include \
                -I/share/apps/xz/5.2.2/include" \
        CXXFLAGS="$CXXFLAGS -fPIC -fopenmp -O3 -maxv2 \
                -I/share/apps/bzip2/1.0.6/include \
                -I/share/apps/xz/5.2.2/include" \
        FFLAGS="$FFLAGS -fPIC -fopenmp -O3 -mavx2" \
        FCFLAGS="$FCFLAGS -fPIC -fopenmp -O3 -mavx2" \
        --with-pcre1=/share/apps/pcre/8.39/


    $ make -j10

4. Make the tests.

.. code-block:: bash

    $ make check

If problems with the test :bash:`reg-packages.Rout` arise, ignore it,
it seems to be a problem with the NFS, check `here <https://stat.ethz.ch/pipermail/r-devel/2016-April/072616.html>`_.

5. Install.

.. code-block:: bash

    $ sudo mkdir -p /share/apps/r/4.0.3/gcc/7.4.0
    $ sudo make install

Module
------

The following is the module used for this version.

.. code-block:: tcl

    #%Module1.0#####################################################################
    ##
    ## modules r/4.0.3_gcc-7.4.0_mkl
    ##
    ## /share/apps/modules/r/3.6.1_gcc-5.4.0_mkl  Written by Johan Yepes
    ##

    proc ModulesHelp { } {
        puts stderr "\tR/4.0.3_gcc-7.4.0_mkl - sets the Environment for R in \
        \n\tthe share directory /share/apps/r/4.0.3/gcc/7.4.0\n"
    }

    module-whatis "\n\n\tSets the environment for R language \
                \n\tbuilt with GCC 7.4.0 and Intel MKL 2017 (Update-1)version \
                \n\t(Update-1)\n"

    # for Tcl script use only
    set       topdir     /share/apps/r/4.0.3/gcc/7.4.0
    set       version    4.0.3
    set       sys        x86_64-redhat-linux

    conflict r

    module load java/jdk-1.8.0_112 intel/2017_update-1 mkl/2017_update-1 gcc/5.4.0

    prepend-path    PATH                    $topdir/bin

    prepend-path    LD_LIBRARY_PATH         $topdir/lib64/R/lib
    prepend-path    LD_RUN_PATH             $topdir/lib64/R/lib
    prepend-path    LIBRARY_PATH            $topdir/lib64/R/lib
    prepend-path    LD_LIBRARY_PATH         $topdir/lib64/R/modules
    prepend-path    LD_RUN_PATH             $topdir/lib64/R/modules
    prepend-path    LIBRARY_PATH            $topdir/lib64/R/modules

    prepend-path    C_INCLUDE_PATH          $topdir/lib64/R/include
    prepend-path    CXX_INCLUDE_PATH        $topdir/lib64/R/include
    prepend-path    CPLUS_INCLUDE_PATH      $topdir/lib64/R/include
    prepend-path    C_INCLUDE_PATH          $topdir/lib64/R/include/R_ext
    prepend-path    CXX_INCLUDE_PATH        $topdir/lib64/R/include/R_ext
    prepend-path    CPLUS_INCLUDE_PATH      $topdir/lib64/R/include/R_ext

    prepend-path    PKG_CONFIG_PATH         $topdir/lib64/pkgconfig

    prepend-path    MAN_PATH                $topdir/share/man


Additional Libraries
--------------------

We recommend for users that need additional libraries in R to use Anaconda. This is because we cannot guarantee that the library will fully work, each library may need different dependencies that we may or may not be able to install and guarantee its functionality.

The following is an example on how to install R in conda with an additional library called ``dada2``.

1. Load the Python 3 module.

.. code-block:: bash

    $ module load python/3.7_miniconda-4.8.3

2. Create the environment in Conda.

.. code-block:: bash

    $ conda create -n ENVIRONMENT_NAME

3. Activate the environment and install R

.. code-block:: bash

    $ conda activate ENVIRONMENT_NAME
    $ conda config --add channels bioconda
    $ conda config --add channels conda-forge
    $ conda install bioconductor-dada2=1.16 r-base r-essentials


.. note::

    If the package is not available in conda, please install it using the R version of conda (See the instruction above to install R in conda) inside the R Studio interpreter like this: ``install.packages("<package_name>");`` .


4. Make sure you activate the environment in the ``slurm_file`` if you are going to run tasks with this method.

.. code-block:: bash

    #!/bin/bash

    #SBATCH --job-name=test_123       # Job name
    #SBATCH --mail-type=ALL         # Mail notification
    #SBATCH --mail-user=tdnavarrom@eafit.edu.co  # User Email
    #SBATCH --output=%x.%j.out # Stdout (%j expands to jobId)
    #SBATCH --error=%x.%j.err  # Stderr (%j expands to jobId)
    #SBATCH --ntasks=3
    #SBATCH --ntasks-per-node=1
    #SBATCH --cpus-per-task=6           # Number of tasks (processes)
    #SBATCH --time=13-23:01:00            # Walltime
    #SBATCH --partition=longjobs         # Partition

    ## load module
    module load python/3.7_miniconda-4.8.3
    source activate r-test

    ## run code
    Rscript simple_script.R
    conda deactivate


:Authors:

- Tomás David Navarro Múnera <tdnavarrom@eafit.edu.co>
