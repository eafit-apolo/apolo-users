.. _beast-2.6.4-index:


BEAST 2.6.4
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.beast2.org/
- **License:**  GNU LESSER GENERAL PUBLIC LICENSE Version 2.1
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Installation date:** 08/06/2021

Tested on (Requirements)
------------------------

- **Dependencies:**
    - Java JDK - 1.8.0 u112

Installation
------------


#. Download the desired version of the software (Source code - tar.gz)

    .. code-block:: bash

        cd /home/jpossaz/sources/beast2
        wget -O beast2.6.4.tgz "https://github-releases.githubusercontent.com/15949777/faf69900-ae6f-11eb-8247-ca2b5a96b6dd?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20210608%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210608T204641Z&X-Amz-Expires=300&X-Amz-Signature=4edf797e065ec87baa8a21dbd0cd5938f85a56d0f03e25535125646c65cfdbc2&X-Amz-SignedHeaders=host&actor_id=13303029&key_id=0&repo_id=15949777&response-content-disposition=attachment%3B%20filename%3DBEAST.v2.6.4.Linux.tgz&response-content-type=application%2Foctet-stream"
        tar -zxvf beast2.6.4.tgz


#. After unpacking, copy the files to the corresponding apps directory:

    .. code-block:: bash

        cd beast
        sudo mkdir -p /share/apps/beast2/2.6.4
        sudo cp -r bin/ lib/ templates/ examples/ images/ /share/apps/beast2/2.6.4


Module
------

    .. code-block:: bash

        #%Module1.0#####################################################################
        ##
        ## module /share/apps/modules/beast2/2.6.4
        ##
        ## /share/apps/beast2/2.6.4 Written by Juan Pablo Ossa Zapata
        ##

        proc ModulesHelp { } {
            puts stderr "\tbeast2/2.6.4 - sets the Environment for BEAST2 \
            \n\tin the share directory /share/apps/beast2/2.6.4\n"
        }

        module-whatis "\n\n\tSets the environment for using beast2\n"

        # for Tcl script use only
        set     topdir          /share/apps/beast2/2.6.4
        set     version         2.6.4
        set     sys             linux-x86_64

        conflict beast2

        module load java/jdk-1.8.0_112

        prepend-path PATH               $topdir/bin

        prepend-path CLASSPATH          $topdir/lib/beast.jar
        prepend-path CLASSPATH          $topdir/lib/beast.src.jar
        prepend-path CLASSPATH          $topdir/lib/DensiTree.jar
        prepend-path CLASSPATH          $topdir/lib/launcher.jar


Use
---

    .. code-block:: bash

        module load beast2/2.6.4

Example slurm job file:

    .. code-block:: bash

        #!/bin/sh
        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --cpus-per-task=4
        #SBATCH --ntasks=1
        #SBATCH --time=2:00:00
        #SBATCH --job-name=testBEAST2
        #SBATCH -o %x_%j.out      # File to which STDOUT will be written
        #SBATCH -e %x_%j.err      # File to which STDERR will be written
        #SBATCH --mail-type=ALL
        #SBATCH --mail-user=jpossaz@eafit.edu.co

        module load beast2/2.6.4
        export OMP_NUM_THREADS=4
        DISPLAY="" beast -threads 4 testRNA.xml

Make sure that your xml file can and will use all of the threads that you assign to the job.

Resources
---------
 * http://www.beast2.org/


Author
------
    * Juan Pablo Ossa Zapata
