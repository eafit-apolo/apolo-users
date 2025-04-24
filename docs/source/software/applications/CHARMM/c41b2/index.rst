.. _c41b2:

CHARMM c41b2
============

- **Installation date:** 5/06/2017
- **URL:**  https://www.charmm.org/charmm
- **Apolo version:** Apolo II
- **License:** Payment (Special Contract)

.. contents:: Table of contents

Dependencies
------------

Apolo
+++++

- MPICH 3.2 (This must be compiled without using the PMI interface, as there is a bug with SLURM which makes it impossible to run distributed jobs)
- GCC-5.4.0
- Source code GAMESS 2016 R1
- Cmake >= 3.7.1

Cronos
++++++

- Gnu GCC >= 5.5.0
- Mpich2 >= 3.2.1
- FFTW3 >= 3.3.7
- CMake >= 3.10.2
- Source code GAMESS 2016 R1 (gamess-current.tar.gz)

Installation
------------

Apolo
+++++

After resolving to load the previously mentioned dependencies, you can proceed with the installation of CHARMM-GAMESS.

1. Prepare the environment before compilation:

.. code-block:: bash

    $ cd /apps/charmm/src/charmm-gammess
    $ tar xf c41b2.tar.gz
    $ cd charmm
    $ wget http://ala.cmm.ki.si/gamess/20160818.1/gamess-20160818.1-charmm.tar.gz
    $ tar xf gamess-20160818.1-charmm.tar.gz
    $ rm gamess-20160818.1-charmm.tar.gz
    $ mkdir source/gamint/gamess
    $ cp ~/apps/gamess/src/gamess/source/* source/gamint/gamess/
    $ rm source/gamint/gamess/vector.src
    $ rm source/gamint/gamess/ga.src
    $ module unload slurm/16.05.6
    $ module load mpich2/3.2_gcc-5.4.0 cmake/3.7.1
    $ patch -p1 < gamess/gamess2016-for-charmm.patch
    $ patch -p1 < gamess/c41b2-for-gamess.patch
    $ chmod 755 tool/gmscomp

For the moment ignore this step.

We comment on the following line in the **tool/gmscomp** file:

.. code-block:: bash

    $ emacs /home/mgomezzul/apps/charmm/src/charmm-gammess/charmm/tool/gmscomp
    $ ...
    $ #set EXTRAOPT="$EXTRAOPT -w -fno-aggressive-loop-optimizations -fno-sanitize=all"
    $ ...

2. After preparing the compilation environment we proceed with the compilation:

.. code-block:: bash

    $ mkdir -p ~/charmm/build
    $ cd ~/charmm/build
    $ ~/apps/charmm/src/charmm-gammess/charmm/configure --gamess
    $ make -j 8

3. At the end of the execution of the **make -j 8**, several errors related to functions that are not defined will result,
this happens because the CHARMM and GAMESS compilation methods are different, making cmake unable to produce the dependencies
for the parallel compilation of the program. This is why it is necessary to apply a new patch and recompile again.

.. code-block:: bash

    $ cd ~/apps/charmm/src/charmm-gammess/charmm
    $ patch -p1 < gamess/c41b2-phase2.patch
    $ cd ~/charmm/build
    $ make -j 8

4. After finishing with the last parallel make, the **charmm** binary should have been produced, we can try it as follows:

.. code-block:: bash

    $ ./charmm
    ...
    1
                    Chemistry at HARvard Macromolecular Mechanics
            (CHARMM) - Developmental Version 41b2   February 15, 2017
                                Revision unknown
        Copyright(c) 1984-2014  President and Fellows of Harvard College
                                All Rights Reserved
      Current operating system: Linux-2.6.32-504.16.2.el6.x86_64(x86_64)@deb
                  Created on  6/6/17 at  9:36:54 by user: mgomezzul

             Maximum number of ATOMS:    360720, and RESidues:      120240
    ...

Cronos
++++++

After resolving to load the previously mentioned dependencies, you can proceed with the installation of **CHARMM-GAMESS.**

1. Prepare the compilation environment:

.. code-block:: bash

    $ cd /home/mgomezzul/apps/charmm-gammes/src/gcc-5.5.0_mpich2-3.2.1
    $ tar xf c41b2.tar.gz
    $ cd charmm
    We download the patch that allows you to compile charmm with support for gamess
    $ wget http://ala.cmm.ki.si/gamess/20160818.1/gamess-20160818.1-charmm.tar.gz
    $ tar xf gamess-20160818.1-charmm.tar.gz
    $ rm gamess-20160818.1-charmm.tar.gz
    $ mkdir source/gamint/gamess
    $ cp  ~/apps/gammess/src/gamess/source/* source/gamint/gamess/
    $ rm source/gamint/gamess/vector.src
    $ rm source/gamint/gamess/ga.src
    $ module purge
    $ module load fftw/3.3.7_gcc-5.5.0_mpich2-3.2.1 cmake/3.10.2
    $ patch -p1 < gamess/gamess2016-for-charmm.patch
    $ patch -p1 < gamess/c41b2-for-gamess.patch
    $ chmod 755 tool/gmscomp

2. The following line is commented in the **tool/gmscomp** file:

.. code-block:: bash

    $ emacs /home/mgomezzul/apps/charmm-gammes/src/gcc-5.5.0_mpich2-3.2.1/charmm/tool/gmscomp
    $ ...
    $ #set EXTRAOPT="$EXTRAOPT -w -fno-aggressive-loop-optimizations -fno-sanitize=all"
    $ ...

3. After preparing the compilation environment we proceed with it:

.. code-block:: bash

    $ mkdir -p ~/apps/charmm-gammes/build
    $ cd ~/apps/charmm-gammes/build
    $ FFTWDIR=/share/apps/fftw/3.3.7/gcc-5.5.0_mpich2-3.2.1 FFTW_HOME=/share/apps/fftw/3.3.7/gcc-5.5.0_mpich2-3.2.1 ~/apps/charmm-gammes/src/gcc-5.5.0_mpich2-3.2.1/charmm/configure --prefix=/share/apps/charmm/c41b2/gcc-5.5.0_mpich2-3.2.1 --gamess --with-gcc
    $ make -j 16 | tee make-charmm.log

4. At the end of the execution of the **make -j 16**, several errors related to functions that are not defined will result, this happens because the CHARMM and GAMESS
compilation methods are different, making cmake unable to produce the dependencies for the parallel compilation of the program. This is why it is necessary to apply
a new patch and recompile again.

.. code-block:: bash

    $ cd /home/$USER/apps/charmm-gammes/src/gcc-5.5.0_mpich2-3.2.1
    $ patch -p1 < gamess/c41b2-phase2.patch
    $ cd /home/$USER/apps/charmm-gammes/build
    $ make -j 16 2>&1 | tee make-charmm.log
    $ sudo mkdir -p /share/apps/charmm/c41b2/gcc-5.5.0_mpich2-3.2.1
    $ sudo chown -R $USER.apolo /share/apps/charmm/c41b2/gcc-5.5.0_mpich2-3.2.1
    $ sudo make install 2>&1 | tee make-charmm.log
    $ sudo chown -R root.root /share/apps/charmm/c41b2/gcc-5.5.0_mpich2-3.2.1

5. After finishing with the last parallel make, the charmm binary should have been produced, we can try it as follows:

.. code-block:: bash

    $ ./charmm
    ...
    1
                  Chemistry at HARvard Macromolecular Mechanics
            (CHARMM) - Developmental Version 41b2   February 15, 2017
                                 Revision unknown
        Copyright(c) 1984-2014  President and Fellows of Harvard College
                               All Rights Reserved
      Current operating system: Linux-2.6.32-504.16.2.el6.x86_64(x86_64)@deb
                  Created on  6/6/17 at  9:36:54 by user: mgomezzul

             aximum number of ATOMS:    360720, and RESidues:      120240
    ...

Module
------

.. code-block:: tcl

    #%Module1.0####################################################################
    ##
    ## module load charmm/c41b2
    ##
    ## /share/apps/modules/charmm/c41b2
    ## Written by Mateo Gomez-Zuluaga
    ##

    proc ModulesHelp {} {
        global version modroot
        puts stderr "Sets the environment for using CHARMM c41b2\
            \nin the shared directory\
            \n/share/apps/charmm/c41b2\
            \nbuilded with GAMESS 2016 R1, MPICH2 3.2 and GCC-5.4.0"
    }

    module-whatis "(Name________) charmm"
    module-whatis "(Version_____) c41b2"
    module-whatis "(Compilers___) mpich2-3.2_gcc-5.4.0"
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) "

    # for Tcl script use only
    set         topdir        /share/apps/charmm/c41b2
    set         version       c41b2
    set         sys           x86_64-redhat-linux

    conflict charmm

    module load mpich2/3.2_gcc-5.4.0


    prepend-path	PATH		$topdir/bin



Mode of Use
-----------

1. Have available an example to run charmm-gamess, in our case the example is available in **/home/$USER/test/charm/ilans**

.. code-block:: bash

    cd /home/$USER/test/charmm-gamess/test_ilans

SLURM Template
--------------

.. code-block:: bash

    #!/bin/sh

    #!/bin/sh

    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=16
    #SBATCH --time=250:00:00
    #SBATCH --job-name=mdrun-npt
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err

    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1

    module load charmm/c41b2_gcc-5.5.0_mpich2-3.2.1

    srun --mpi=pmi2 charmm < min1.inp  > pot.out

References
----------

- https://www.charmm.org/charmm/documentation/by-version/c41b1/
- http://ala.cmm.ki.si/gamess/20160818.1/Compile-CHARMM-with-GAMESS.txt
- https://www.charmmtutorial.org/index.php/Installation
- https://github.com/kgullikson88/Telluric-Fitter/issues/5

Author
------

- Mateo Gómez Zuluaga
