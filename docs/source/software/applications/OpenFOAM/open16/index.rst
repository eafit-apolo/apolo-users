.. _open16:

.. contents:: Table of Contents

***************
OpenFOAM/v1612+
***************

- **Installation date:** 27/02/2017
- **URL:** http://openfoam.com/
- **Apolo version:** Apolo II
- **License:** General Public Licence

Dependencies
-------------

- gcc >= 5.4.0
- python >= 2.7.11
- fftw >= 3.3.5
- zlib >= 1.2.11
- qt >= 4.8.7
- boost >= 1.62.0
- cmake >= 3.7.1
- Intel Parallel Studio XE Cluster Edition 2017 Update 1 (Intel MPI)

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    wget https://sourceforge.net/projects/openfoamplus/files/v1612+/OpenFOAM-v1612+.tgz
    wget https://sourceforge.net/projects/openfoamplus/files/v1612+/ThirdParty-v1612+.tgz


#. For the configuration and installation of OpenFOAM it is necessary to build the following dependencies of the software
following these steps:

**CGAL**

.. code-block:: bash

    source /share/apps/openfoam/v1612+/intel_impi/2017_update-1/OpenFOAM-v1612+/etc/bashrc
    cd ThirdParty-v1612+
    module load fftw/3.3.5_intel_impi-2017_update-1
    module load zlib/1.2.11_intel-2017_update-1
    module load qt/4.8.7_intel-2017_update-1
    module load boost/1.62.0_intel_mkl_impi_2017_update-1
    module load python/2.7.11_intel-2017_update-1
    module load cmake/3.71
    emacs ../OpenFOAM-v1612+/etc/config.sh/CGAL
    ...
    # Modification
    boost_version=boost-system
    cgal_version=CGAL-4.9

    # Modification
    export BOOST_ARCH_PATH=/share/apps/boost/1.62.0/intel_impi/2017_update-1
    export CGAL_ARCH_PATH=$WM_THIRD_PARTY_DIR/platforms/$WM_ARCH$WM_COMPILER/$cgal_version
    ...
    emacs makeCGAL
    ...
    # Enable/disable gmp/mpfr together
    if _foamIsNone $gmpPACKAGE || _foamIsNone $mpfrPACKAGE
    then
        GMP_ARCH_PATH=none
        MPFR_ARCH_PATH=none
    elif _foamIsSystem $GMP_ARCH_PATH || _foamIsSystem $MPFR_ARCH_PATH
    then
        # Modification
        GMP_ARCH_PATH=/share/apps/gmp/6.1.1    # for an accurate record
        MPFR_ARCH_PATH=/share/apps/mpfr/3.1.5
    fi
    ...

    sudo ln -s /share/apps/gmp/6.11/lib /share/apps/gmp/6.11/lib64
    sudo ln -s /share/apps/mpfr/3.1.5/lib /share/apps/mpfr/3.1.5/lib64
    ./makeCGAL

**MESA**

.. code-block:: bash

    wget ftp://ftp.freedesktop.org/pub/mesa/13.0.4/mesa-13.0.4.tar.gz
    ./makeMESA mesa-13.0.4

**ParaView**

.. code-block:: bash

    # Modificar la versión de MESA para que corresponda
    emacs makeParaview.example
    ...
    # Modification
    mesa=mesa-13.0.4
    ...
    # Modificar el siguiente archivo
    emacs etc/tools/ParaViewFunctions
    ...
    # Modification
    pythonInclude=/share/apps/python/2.7.12/intel/2017_update-1/intelpython27/include/python$pythonMajor
    ...
    # Comentar las siguientes líneas en el archivo indicado:
    emacs ParaView-5.0.1/Qt/Components/pqPresetToPixmap.cxx
    ...
        // Now determine best value for Nh in [Nh/2,Nh-1]
        double bestQ = vtkMath::Inf();
        int best = -1;
        // mateo
        //for (int i = Nh / 2; i < Nh; ++i)
        //  {
        double ar = Nv * wmp / static_cast<double>(hmp * Nh);
        double q = ( ar >= 1.0 ) ? ar : 1. / ar;
        if ( q < bestQ )
          {
            bestQ = q;
            best = Nh-1;//i;
          }
        //}
        Nh = best;
        }
    ...
    ./makeParaView.example -python

**VTK**

.. code-block:: bash

    ln -s ParaView-5.0.1/VTK  VTK-7.1.0
    # Agregar versión de MESA
    emacs makeVTK.example
    ...
    mesa=mesa-13.0.4
    ...
    ./makeVTK.example -mpi=0

**FFTW**

.. code-block:: bash

    emacs ../OpenFOAM-v1612+/etc/config.sh/FFTW
    ...
    # Modification
    fftw_version=fftw-system
    ../OpenFOAM-v1612+/etc/config.sh/FFTW
    # Modifictation
    export FFTW_ARCH_PATH=/share/apps/fftw/3.3.5/intel_impi/2017_update-1
    ...

#. Edit the makefile

.. code-block:: bash

    emacs etc/wmakeFiles/scotch/Makefile.inc.i686_pc_linux2.shlib-OpenFOAM
    ...
    MAKE        = make
    AR          = icc
    ARFLAGS     = $(WM_CFLAGS) -shared -o
    CAT         = cat
    CCS         = icc
    CCP         = mpiicc
    CCD         = mpiicc
    ...
    module unload python
    ./Allwmake


Slurm template
---------------

.. code-block:: bash

    #!/bin/bash
    #SBATCH --partition=longjobs
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=32
    #SBATCH --time=1:00:00
    #SBATCH --job-name=vsearch
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err

    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=???

    xxx

References
------------

- https://openfoamwiki.net/index.php/Installation/Linux/OpenFOAM-4.0/CentOS_SL_RHEL
- http://openfoam.com/documentation/system-requirements.php
- http://openfoam.com/download/install-source.php
- http://openfoam.com/code/build-guide.php
- https://software.intel.com/en-us/forums/intel-c-compiler/topic/702934

Author
------

- Mateo Gómez Zuluaga
