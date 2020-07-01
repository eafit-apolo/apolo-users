.. _ansys-19.2-index:

.. role:: bash(code)
   :language: bash

ANSYS 19.2
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://www.ansys.com/
- **License:** ANSYS Research License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
  , :ref:`Cronos <about_cronos>`


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)

Installation
------------

The following procedure is the easiest way to install ANSYS in a cluster.

#. Copy the three (3) iso files into a cluster location

   .. code-block:: bash

    $ tree ANSYS\ LINUX\ 19.2/

   ::

    ANSYS LINUX 19.2/
    ├── DVD 1
    │   └── ANSYS192_LINX64_DISK1.iso
    ├── DVD 2
    │   └── ANSYS192_LINX64_DISK2.iso
    └── DVD 3
        └── ANSYS192_LINX64_DISK3.iso

#. Mount each iso file into a different folder, you might create a folder structure in your home or :bash:`/tmp`.

    .. code-block:: bash

        $ mkdir -p ansys-19.2/ansys-{1,2,3}
        $ sudo mount -o loop ANSYS192_LINX64_DISK1.iso ansys-19.2/ansys-1
        $ sudo mount -o loop ANSYS192_LINX64_DISK2.iso ansys-19.2/ansys-2
        $ sudo mount -o loop ANSYS192_LINX64_DISK3.iso ansys-19.2/ansys-3

#. After you have mounted all the iso files you have to log into the cluster through the GUI or via ssh using the :bash:`-X`.

    .. code-block:: bash

        $ ssh <user>@(apolo|cronos).eafit.edu.co -X

#. Go to the folder location of the first iso file and execute the :bash:`INSTALL` script.

    .. code-block:: bash

        $ cd ansys-19.2/ansys-1
        $ ./INSTALL

    It will open an ANSYS 19.2 GUI and just follow the steps. During the installation process, it will ask you for
    the other two folders where the iso files are mounted.

    .. note::

        Ensure to read the "Getting Started - Installation" and "System Requirements" PDFs shown in the GUI
        to meet the necessary requirements before to try to install the software.

#. After the installation is completed you have to create the corresponding module for ANSYS 19.2.

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load ansys/19.2
        ##
        ## /share/apps/modules/ansys/19.2
        ## Written by Johan Sebastian Yepes Rios
        ##

        proc ModulesHelp {} {
             global version modroot
             puts stderr "Sets the environment for using Ansys 19.2\
                          \nin the shared directory /share/common-apps/ansys/19.2"
        }

        module-whatis "(Name________) Ansys"
        module-whatis "(Version_____) 19.2"
        module-whatis "(Compilers___) "
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/common-apps/ansys/19.2/ansys_inc/v192
        set         version       19.2
        set         sys           x86_64-redhat-linux

        conflict ansys

        prepend-path              PATH        $topdir/ansys/bin
        prepend-path              PATH        $topdir/CFX/bin
        prepend-path              PATH        $topdir/autodyn/bin
        prepend-path              PATH        $topdir/fluent/bin
        prepend-path              PATH        $topdir/Icepak/bin
        prepend-path              PATH        $topdir/polyflow/bin
        prepend-path              PATH        $topdir/AFD/bin
        prepend-path              PATH        $topdir/TurboGrid/bin


Running Examples
----------------

In this section, there are some examples of how to use the different programs present in ANSYS through the Slurm Workload
manager.

CFX5
~~~~

ANSYS CFX is a high-performance computational fluid dynamics (CFD) software tool that delivers reliable and accurate
solutions quickly and robustly across a wide range of CFD and multiphysics applications. CFX is recognized for its
outstanding accuracy, robustness, and speed when simulating turbomachinery, such as pumps, fans, compressors
and gas and hydraulic turbines. [1]_

In the following example, we have decided to use Intel MPI because of the best choice for our current architecture.
The example below was adapted from [2]_

    .. code-block:: bash

        #!/bin/bash

        #SBATCH -J jobcfx_test
        #SBATCH -e jobcfx_test-%j.err
        #SBATCH -o jobcfx_test-%j.out
        #SBATCH -t 05:00:00
        #SBATCH -n 64

        module load ansys/19.2

        #Generate lines of names of computational nodes (or hosts).
        MYHOSTLIST=$(srun hostname | sort | uniq -c | awk '{print $2 "*" $1}' | paste -sd, -)

        #Run Ansys CFX.
        cfx5solve -def prueba.def \
            -parallel \
            -start-method "Intel MPI Distributed Parallel" \
            -par-dist "$MYHOSTLIST" \
            -batch \
            -stdout-comms

Fluent
~~~~~~

Fluent software contains the broad, physical modeling capabilities needed to model flow, turbulence, heat transfer and reactions for industrial applications.
These range from air flow over an aircraft wing to combustion in a furnace, from bubble columns to oil platforms, from blood flow to semiconductor manufacturing and from clean room design to wastewater treatment plants.
Fluent spans an expansive range, including special models, with capabilities to model in-cylinder combustion, aero-acoustics, turbomachinery and multiphase systems. [3]_

How to run it in our cluster?. This example was adapted from [4]_:

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --job-name=jobfluent_test
        #SBATCH --error=jobfluent_test.err.%j
        #SBATCH --output=jobfluent_test.out.%j
        #SBATCH --time=00:10:00
        #SBATCH --ntasks=16
        #SBATCH --nodes=1
        #SBATCH --partition=longjobs

        # Load Ansys.
        module load ansys/19.2

        # Generate list of hosts.
        MYHOSTLIST="hosts.$SLURM_JOB_ID"
        srun hostname | sort > $MYHOSTLIST

        # Run AnsysFluent.
        fluent 3ddp \
            -g \
            -mpi=intel \
            -t $SLURM_NTASKS \
            -cnf=$MYHOSTLIST \
            -i fluent.jou \
            > fluent.out

References
----------

.. [1] ANSYS CFX - ANSYS Official website.
       Retrieved April 10, 2019, from https://www.ansys.com/products/fluids/ansys-cfx

.. [2] HKHLR-How To - Run ANSYS CFX on an HPC-Cluster.
       Retrieved April 10, 2019, from https://www.hkhlr.de/sites/default/files/field_download_file/HowTo-ANSYS_CFX.pdf

.. [3] ANSYS Fluent - ANSYS Official website.
       Retrieved September 10, 2019, from https://www.ansys.com/products/fluids/ansys-fluent

.. [4] HKHLR-How To - Run ANSYS Fluent on an HPC-Cluster.
       Retrieved September 10, 2019, from https://www.hkhlr.de/sites/default/files/field_download_file/HKHLR-HowTo-Ansys_Fluent.pdf

Authors
-------

- Johan Sebastián Yepes Ríos <jyepesr1@eafit.edu.co>
