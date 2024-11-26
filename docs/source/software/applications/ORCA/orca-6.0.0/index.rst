.. _orca-6.0.0-index:

.. role:: bash(code)
    :language: bash

ORCA 6.0.0
=============

Basic Information
-----------------

- **Implementation Date:** 15/11/2024
- **Oficcial Website:** https://www.faccts.de/orca/
- **Apolo Version:** Apolo II and later
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
-----------------

Tested on (Requirements)
""""""""""""""""""""""""

- **OS base:**  Rocky Linux (x86_64) :math:`\boldsymbol{\ge}` 8
- OpenMPI :math:`\boldsymbol{\ge}` 4.1.6

Build process
""""""""""""""""""""""""

After solving the previously mentioned dependencies, you can proceed with the installation of ORCA.

1. Download the latest version of the software (Source code - tar.gz) (https://orcaforum.kofo.mpg.de/index.phphttps://orcaforum.kofo.mpg.de/index.php).
To transfer the file to the cluster, use the `scp` command in a Linux environment or the **WinSCP** program on Windows.:

.. note::

    You need to create an account in the forum to download the software.
    It is not possible to download the file using `wget`, so it needs to be transferred to the cluster.


.. code-block:: bash

    cd /path/to/file/of/orca
    scp ./orca_6_0_0_linux_x86-64_avx2_shared_openmpi416.run your_user@apolo.eafit.edu.co:/home/your_user/path/destination

2. Extaact the file and move it to the installation directory:

.. code-block:: bash

    cd /path/to/file/of/orca
    tar -xvf orca_6_0_0_linux_x86-64_avx2_shared_openmpi416.tar.xz
    sudo sudo mkdir -p /share/apps/orca/6.x.x/gcc-11.2.0_openmpi/
    sudo mv ./orca_6_0_0_linux_x86-64_avx2_shared_openmpi416/* /share/apps/orca/6.x.x/gcc-11.2.0_openmpi/


Module
------------
Create and place the needed module file. Create a file with the following content:

.. code-block:: bash

    #%Module1.0#####################################################################
    ##
    ## modules orca6.0.0_gcc-11.2.0_openmpi
    ##
    ## /share/apps/orca/6.0.0/gcc-11.2.0_openmpi
    ##

    proc ModulesHelp { } {
        puts stderr "\t6.0.0gcc-11.2.0_openmpi - sets the Enviroment for ORCA in \
        \n\tthe share directory /share/apps/modules/orca/6.0.0_gcc-11.2.0_openmpi\n"
    }

    module-whatis "\n\n\tSets the enviroment for ORCA\
                \n\tbuilt with gcc-11.2.0\n"

    #for TCL script use only
    set       topdir     /share/apps/orca/6.0.0/gcc-11.2.0_openmpi
    set       version    6.0.0
    set       sys        x86_64-redhat-linux

    conflict orca

    module load intel/2022_oneAPI-update1
    module load openmpi/5.0.3_gcc-11.2.0

    prepend-path    PATH                    $topdir
    prepend-path    LD_LIBRARY_PATH         $topdir
    prepend-path    LD_RUN_PATH             $topdir/lib
    prepend-path    LIBRARY_PATH            $topdir/lib


Testing (Usage)
------------------
Here's an example SLURM script to test the installation.
This script will submit a simple job that runs ORCA with a water molecule input file.

.. literalinclude:: src/water-parallel.inp
        :language: bash
        :caption: :download:`water-parallel.inp <src/water-parallel.inp>`

.. literalinclude:: src/slurm.sh
        :language: bash
        :caption: :download:`slurm.sh <src/slurm.sh>`


Resources
-----------

- ORCA Documentation. Retrieved from: https://orcaforum.kofo.mpg.de/app.php/dlext/?cat=1
- ORCA Official Website. Retrieved from: https://www.faccts.de/docs/orca/6.0/manual/


Authors
---------

- Isis Catitza Amaya Arbelaez <icamayaa@eafit.edu.co>
