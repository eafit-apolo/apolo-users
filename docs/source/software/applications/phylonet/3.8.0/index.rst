.. _phylonet-3.8.0-index:


PhyloNet3.8.0
=============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://bioinfocs.rice.edu/phylonet
- **License:**  GNU General Public License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Installation date:** 22/07/2021

Tested on (Requirements)
------------------------

- **Dependencies:**
    - Java JDK - 1.8.0 u112

Installation
------------


#. Download the jar file from the official website

    .. code-block:: bash

        cd /share/apps/phylonet/3.8.0
        wget https://bioinfocs.rice.edu/sites/g/files/bxs266/f/kcfinder/files/PhyloNet_3.8.0.jar


#. After downloading, rename the file to ``PhyloNet.jar``:

    .. code-block:: bash

        mv PhyloNet_3.8.0.jar PhyloNet.jar

#. Install the corresponding module file:

Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module /share/apps/modules/phylonet/3.8.0
        ##
        ## /share/apps/phylonet/3.8.0 Written by Juan Pablo Ossa Zapata
        ##

        proc ModulesHelp { } {
            puts stderr "\tphylonet/3.8.0 - sets the Environment for Phylonet \
            \n\tin the share directory /share/apps/phylonet/3.8.0 \n"
        }

        module-whatis "\n\n\tSets the environment for using phylonet 3.8.0\n"

        # for Tcl script use only
        set     topdir          /share/apps/phylonet/3.8.0
        set     version         3.8.0
        set     sys             linux-x86_64

        conflict phylonet

        module load java/jdk-1.8.0_112

        prepend-path PHYLONET_DIRECTORY               $topdir


Use
---

    .. code-block:: bash

        module load phylonet/3.8.0

Example slurm job file:

    .. code-block:: bash

        #!/bin/sh
        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --cpus-per-task=4
        #SBATCH --ntasks=1
        #SBATCH --time=2:00:00
        #SBATCH --job-name=testPhylonet
        #SBATCH -o %x_%j.out      # File to which STDOUT will be written
        #SBATCH -e %x_%j.err      # File to which STDERR will be written
        #SBATCH --mail-type=ALL
        #SBATCH --mail-user=jpossaz@eafit.edu.co

        module load phylonet/3.8.0

        export OMP_NUM_THREADS=4

        srun java -jar $PHYLONET_DIRECTORY/PhyloNet.jar mynexusfile

Make sure that your nexus file is able to use all of the allocated cpu cores.

Resources
---------
 * https://wiki.rice.edu/confluence/pages/viewpage.action?pageId=39500205#PhylonetTutorial%28SSB2020%29-2.Installation
 * https://bioinfocs.rice.edu/phylonet


Author
------
    * Juan Pablo Ossa Zapata
