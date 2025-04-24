.. _trinity-2.8.5-index:

.. role:: bash(code)
   :language: bash

TRINITY 2.8.5
=============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://github.com/trinityrnaseq/trinityrnaseq/wiki
- **Download Website:** https://github.com/trinityrnaseq/trinityrnaseq/releases
- **License:** trinityrnaseq License
- **Installed on:** Apolo II and Cronos

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)
* **Dependencies to run trinity:**
    * bowtie2  (tested on version 2.3.2)
    * jellyfish (tested on version 2.3.0) depends on yaggo
    * yaggo (tested on version 1.5.10)
    * salmon   (tested on version 0.14.1)
    * samtools (tested on version 1.3.1)
    * Python 2.7 or 3.X with numpy
    * CMAKE (teste on version 3.7.1)

Installation
------------

The following procedure is the easiest way to install Trinity v2.8.5 in a cluster.

#. Download the tar.gz of trinity version 2.8.5 from the release page into a cluster location.

   .. code-block:: bash

    $ wget https://github.com/trinityrnaseq/trinityrnaseq/archive/Trinity-v2.8.5.tar.gz

#. Now, because trinity depends on other tools, make sure you have them compiled and installed in your cluster, else trinity won't run.

   * https://salmon.readthedocs.io/en/latest/salmon.html
   * http://www.genome.umd.edu/jellyfish.html
   * http://bowtie-bio.sourceforge.net/bowtie2/index.shtml
   * https://github.com/samtools/samtools


   .. note::

        For jellyfish, the documentation for version 2.3.0 says you don't have to compile yaggo. It didn't work for us, we compiled yaggo, and then, it worked. Also, the Intel compiler doesn't work to compile jellyfish, use gcc instead as recommended in the jellyfish documentation.



#. After you have all the dependencies installed, load them so trinity will be able to use them.

    .. code-block:: bash

        $ module load bowtie2 samtools jellyfish salmon python/3.6.5_miniconda-4.5.1 intel/19.0.4
        $ echo "We load python because Apolo uses different versions of python, that's how Apolo works."

    .. note::

        In this example, we loaded the Intel compiler icc v19.0.4, because trinity does support it, but we have to do some changes first.

#. Now, we start configuring some components that are inside the directory you extracted from the tar.gz file.

    .. code-block:: bash

        $ cd trinityrnaseq-Trinity-v2.8.5/trinity-plugins
        $ emacs -nw Makefile

    Go to where it says "parafly_target:"

    * Delete the first line that contains ``tar -zxvf ${PARAFLY_CODE}.tar.gz && \``
    * Then, search for the ``-fopenmp`` flags and change them to ``-qopenmp``
    * Save the file.

    After this, extract the ParaFly tar file and go inside the directory.

    .. code-block:: bash

        $ tar xfz ParaFly-0.1.0.tar.gz
        $ cd ParaFly-0.1.0

    Now, lets configure one last thing:

    .. code-block:: bash

        $ emacs -nw configure

    Starting line 3125 inside ``configure``, you should see something like this:

    .. code-block:: bash

        case $CXX in
            ++*) AM_CXXFLAGS="-pedantic -fopenmp -Wall -Wextra -Wno-long-long -Wno-deprecated $AM_CXXFLAGS"
        ;;
            sunCC*) AM_CXXFLAGS="-library=stlport4 -xopenmp -xvpara -fast $AM_CXXFLAGS"
        ;;
            icpc*) AM_CXXFLAGS="-Wall -openmp $AM_CXXFLAGS"
        ;;
        esac

    Go to ``icpc`` and change the ``-openmp`` to ``-qopenmp``

    .. note::

        You need to be inside the trinityrnaseq-Trinity-v2.8.5/trinity-plugins/ to make this changes.

#. We may compile Trinity V2.8.5 inside the directory you extracted from the tar.gz file.

    .. code-block:: bash

        $ cd trinityrnaseq-Trinity-v2.8.5
        $ make -j4
        $ make -j4 plugins



#. Now, Trinity's installer doesn't work well, it copies all the files inside the main trinity directory to /usr/local/bin, so for us to install it correctly, we had to delete some files manually and change the name of the main tirnity directory.

    Based on the Anaconda setup, this is how Apolo has Trinity installed.

    .. code-block:: bash

        $ cd trinityrnaseq-Trinity-v2.8.5
        $ rm -Rf bioconda_recipe/ trinityrnaseq.wiki/ Docker/
        $ cd Butterfly
        $ rm -Rf build_jar.xml src/ jar-in-jar-loader.zip
        $ cd ..
        $ cd Chrysalis
        $ rm -Rf aligns/ analysis/ base/ build/ chrysalis.notes CMakeLists.txt Makefile system/ util/
        $ cd ..
        $ cd Inchworm
        $ rm -Rf build/ CMakeLists.txt Makefile src/
        $ cd ..
        $ rm Changelog.txt Makefile notes README.md
        $ cd ..
        $ mv trinityrnaseq-Trinity-v2.8.5/ 19.0.4
        $ sudo mv 19.0.4/ /share/apps/trinity/2.8.5/intel/

    You have Trinity v2.8.5 installed inside the /share/apps/trinity/2.8.5/intel/19.0.4 directory

    .. note::
        The second to last line is the change the name of the directory, this is easier when creating the module file.
#. After the installation is completed you have to create the corresponding module for Trinity 2.8.5.

    .. code-block:: tcl

        #%Module1.0####################################################################
        ##
        ## module load trinity/2.8.5
        ##
        ## /share/apps/modules/trinity/2.8.5
        ## Written by Tomas David Navarro Munera
        ##

        proc ModulesHelp {} {
             puts stderr "Sets the environment for using Trinity 2.8.5\
                          \nin the shared directory /share/apps/trinity/2.8.5/intel/19.0.4"
        }

        module-whatis "(Name________) Trinity"
        module-whatis "(Version_____) 2.8.5"
        module-whatis "(Compilers___) intel-19.0.4
        module-whatis "(System______) x86_64-redhat-linux"
        module-whatis "(Libraries___) "

        # for Tcl script use only
        set         topdir        /share/apps/trinity/2.8.5/intel/19.0.4
        set         version       2.8.5
        set         sys           x86_64-redhat-linux

        conflict trinity
        module load jellyfish/2.3.0
        module load samtools/1.3.1_intel-2017_update-1
        module load salmon/0.14.1
        module load bowtie2/2.3.2_gcc-4.4.7
        module load intel/19.0.4
        module load python/3.6.5_miniconda-4.5.1

        prepend-path              PATH        $topdir


Running Example
----------------

In this section, there is an example run that Trinity already has.

#.  First, we create a conda environment, in able to run Trinity.

    .. code-block:: bash

        $ conda create --name trinity
        $ conda activate trinity
        $ pip install numpy
        $ module load trinity/2.8.5
        $ cd /share/apps/trinity/2.8.5/intel/19.0.4/sample_data/test_Trinity_Assembly/
        $ ./runMe.sh

    .. note::
        The python version in this example is the one we loaded at the beginning of the installation.


References
----------

 Trinity - Trinity Official website.
       Retrieved Octubre 4, 2019, from https://github.com/trinityrnaseq/trinityrnaseq/wiki

 Installing Trinity - Trinity Official Website.
       Retrieved Octubre 4, 2019, from https://github.com/trinityrnaseq/trinityrnaseq/wiki/Installing-Trinity

Authors
-------

- Tomas David Navarro Munera <tdnavarrom@eafit.edu.co>
