.. _lotos-euros-2.2.002-index:

.. role:: bash(code)
       :language: bash

.. role:: raw-html(raw)
   :format: html

Lotos Euros 2.2.002
===================

Basic Information
-----------------

- **Deploy date:** January 2024
- **Official Website:** https://airqualitymodeling.tno.nl/
- **License:**
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Tested on (Requirements)
------------------------
- **OS base:** Rocky Linux (x86_64) :math:`\boldsymbol{\ge}` 8.5
- **Compiler:** GCC 9.3.0
- **Requirements:**

  * gcc 11.2.0

  * python 3.9.9 with gcc 11.2.0

  * netcdf-c 4.8.1 with gcc 11.2.0

  * netcdf-fortran 4.5.3 with gcc 11.2.0

  * makedepf90 2.8.9 with gcc 11.2.0

  * hdf5 1.13 with gcc 11.2.0



Installation
------------

This entry covers the entire process performed for the installation and configuration of Lotos Euros



Get the software
----------------

Enter the `Link following <https://airqualitymodeling.tno.nl/lotos-euros/open-source-version/>` page and fill in the application to get access to the software which you can find in the bottom of the page.


Configure the machine file
--------------------------

Find the environment section, and replace the paths to the HDF5, NETCDF-C, NETCDF-FORTRAN like so:

.. code-block::

        USERLONGNAME            :  /no/USERLONGNAME
        !LE_DATA                 :  /no/LE_DATA
        MODAS_SCRATCH           :  /no/MODAS_SCRATCH
        !SCRATCH                 :  /scratch/lcruzr
        NETCDF_FORTRAN_HOME     :  /share/apps/netcdf-fortran/4.5.3/gcc-11.2.0
        NETCDF_C_HOME           :  /share/apps/netcdf/4.8.1/gcc-11.2.0
        HDF5_HOME               :  /share/apps/hdf5/1.13.0/gcc-11.2.0
        UDUNITS_HOME            :  /share/apps/UDUNITS_HOME
        LAPACK_HOME             :  /share/apps/LAPACK_HOME
        SPBLAS_HOME             :  /share/apps/SPBLAS_HOME

comment with a **!** **LE_DATA** and **SCRATCH**, since those variables are either not used or defined in other places in the script.

if you need udunits, lapack or spblas define those variables as well, however they are not required to run lotos euros.

Next, modify the commands that are going to load the modules like so:

.. code-block::

   *.modules                     :  load python-3.9.9-gcc-11.2.0-k7juzmi ; \
                                 load gcc/11.2.0 ; \
                                 load netcdf/4.8.1_gcc-11.2.0 ; \
                                 load netcdf-fortran/4.5.3_gcc-11.2.0; \
                                 load makedepf90/2.8.9_gcc-11.2.0

Don't forget to delete the line

.. code-block::

          purge ; \

Otherwise there is a possibility that slurm will not work.

Next, configure the job settings.

Look for the Job scripts sections and modify the following based on the needs of what you are running:

.. code-block::

        *.batch.slurm.option.queue      :  partition longjobs
        *.batch.slurm.option.nodes      :  nodes 1
        *.batch.slurm.option.tasks      :  ntasks 16
        *.batch.slurm.option.threads    :  cpus-per-task 1
        *.batch.slurm.option.memory     :  mem 128Gb
        *.batch.slurm.option.time       :  time 24:00:00


Remember to take into account the limits of the partition you are running on.


Next, comment the libraries you are not using.

Look for the libraries section and comment the libraries you are not using with **!** like so:

.. code-block::

        my.udunits.define             :
        !my.udunits.define             :  with_udunits1
        !my.udunits.define             :  with_udunits2

        ! define libraries:
        !my.spblas.define              :
        my.spblas.define              :  with_spblas

        ! define libraries:
        !my.linalg.define              :
        my.linalg.define              :  with_lapack


Next, define the model data and the output path like so:

.. code-block::

        ! the user scratch directory:
        my.scratch                    :  /path/to/lotos-euros/v2.2.002/output

        ! base path to input data files:
        my.data.dir                   : /path/to/input/data

        ! location of LEIP produced input,
        ! region name is defined together with grid:
        my.leip.dir                   :  /path/to/leip/dir

        ! used to install files from archive,
        ! not yet on this machine ...
        my.leip.arch                  :  /no/arch

This section is usually defined by the user since they are the ones that have to source the data for the model to run.

The output directory is defined by the variable **my.scratch**, it is recomended that this is not in the scratch directory but in the home directory of the user in Apolo II, if you try to use it in the scratch or any other path it will not generate any output files.

:Authors:

- Jacobo Monsalve Guzman <jmonsalve@eafit.edu.co>
