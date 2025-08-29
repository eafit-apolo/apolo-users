.. _open17:

.. contents:: Table of Contents

***************
OpenFOAM/v1712+
***************

- **Installation date:** 16/02/2018
- **URL:** http://openfoam.com/
- **Apolo version:** Cronos
- **License:** General Public Licence

Dependencies
-------------

-GNU GCC >= 5.4.0
- Python2 (Intel version) >= 2.7.14
- Boost >= 1.67.0
- cmake >= 3.7.1
- OpenMPI >= 1.10.7

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    cd /share/apps/openfoam/v1712/gcc-5.4.0/OpenFOAM-v1712
    wget https://sourceforge.net/projects/openfoamplus/files/v1712/OpenFOAM-v1712.tgz
    wget https://sourceforge.net/projects/openfoamplus/files/v1712/ThirdParty-v1712.tgz
    tar xf OpenFOAM-v1712.tgz
    tar xf ThirdParty-v1712.tgz


#. Edit the following archives:

**/share/apps/openfoam/v1712+/gcc-5.5.0/OpenFOAM-v1712/etc/bashrc:**

.. code-block:: bash

    ...
    FOAM_INST_DIR=/share/apps/openfoam/v1712/gcc-5.4.0/OpenFOAM-v1712
    # FOAM_INST_DIR=/opt/$WM_PROJECT
    # FOAM_INST_DIR=/usr/local/$WM_PROJECT
    ...
    export WM_COMPILER_TYPE=system
    ...
    export WM_COMPILER=Gcc54
    ...
    export WM_MPLIB=SYSTEMOPENMPI
    ...

** /share/apps/openfoam/v1712+/gcc-5.5.0/OpenFOAM-v1712/etc/config.sh/CGAL:**

.. code-block:: bash

    ...
    boost_version=boost-system
    ...
    export BOOST_ARCH_PATH=/share/apps/boost/1.67.0/gcc-5.4.0
    ...

#. Load compilation environment:

.. code-block:: bash

    source /share/apps/openfoam/v1712+/gcc-5.5.0/OpenFOAM-v1712/etc/bashrc
    cd ThirdParty-v1712
    module load python/2.7.12_intel-2017_update-1
    module load boost/1.67.0_gcc-5.4.0_openmpi-1.10.7
    module load cmake/3.7.1

#. Edit archives:

**makeCGAL**

.. code-block:: bash

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

.. code-block:: bash

    sudo ln -s /share/apps/gmp/6.1.1/lib /share/apps/gmp/6.1.1/lib64
    sudo ln -s /share/apps/mpfr/3.1.5/lib /share/apps/mpfr/3.1.5/lib64

#. compile cgal

.. code-block:: bash

    ./makeCGAL

#. OpenFoam installation

.. code-block:: bash

    cd ../OpenFOAM-v1712
    ./Allwmake


Slurm template
---------------

.. code-block:: bash

    #!/bin/sh

    #SBATCH --partition=bigmem
    #SBATCH --nodes=2
    #SBATCH --ntasks-per-node=24
    #SBATCH --time=14-00
    #SBATCH --job-name=OpenFOAM_1
    #SBATCH -o result_%N_%j.out
    #SBATCH -e result_%N_%j.err
    #SBATCH --mail-type=ALL
    #SBATCH --mail-user=dtobone@eafit.edu.co

    # Don't share environment variables
    export SBATCH_EXPORT=NONE
    export OMP_NUM_THREADS=1
    # Debug OpenFOAM
    #export FOAM_ABORT=1

    # R U in cronos or apolo2?
    if [[ "${SLURM_SUBMIT_HOST}" != "apolo.eafit.edu.co" ]]; then
    ## OpenFOAM-v1712 - Cronos Configuration
        echo "No estoy en apolo"
        module load python/2.7.14_intel-18_u1
        module load openmpi/1.10.7_gcc-5.5.0
        module load fftw/3.3.7_gcc-5.5.0
        module load boost/1.66.0_gcc-5.5.0
        source /share/apps/openfoam/v1712+/gcc-5.5.0/OpenFOAM-v1712/etc/bashrc
    else
    ## OpenFOAM-v1612 - Apolo Configuration
        echo "Estoy en Apolo"
        module load boost/1.67.0_gcc-5.4.0_openmpi-1.10.7
        source /share/apps/openfoam/v1712/gcc-5.4.0/OpenFOAM-v1712/etc/bashrc > /dev/null 2>&1
    fi


    # Source tutorial run functions
    . $WM_PROJECT_DIR/bin/tools/RunFunctions

    #------------------------------------------------------------------------------
    #     BORRAR Y ORGANIZAR LOS ARCHIVOS INICILES PARA LA SIMULACIÓN
    #------------------------------------------------------------------------------

    rm -rf processor*                               #Borra carpetas procesadores
    rm -rf file log.pimpleFoam                      #Borra archivos de simulaciones pasadas
    rm -rf file log.snappyHexMesh                   #Borra archivos de simulaciones pasadas
    rm -rf file log.renumberMesh                    #Borra archivos de simulaciones pasadas

    #------------------------------------------------------------------------------
    #     PASOS PREVIOS - MALLADO - VERIFICACIÓN
    #------------------------------------------------------------------------------

    mv 0 0.org                                  #Mueve los datos para que no se dañe al hacer la malla
    mkdir 0                                     #Crea una carpeta de 0 falsa
    cd constant/triSurface                      #Entra donde estan los archivos stl para la malla
    surfaceTransformPoints -scale '(0.001 0.001 0.001)' vane_mm.stl vane_m.stl #Escala la malla
    cd ..                                       #Se devuelve a la carpeta constant
    cd ..                                       #Se devuelve a la carpeta de la simulación
    blockMesh                                   #Crea la malla base, o geometria de referencia
    surfaceFeatureExtract                       #Extrae las superficies de los stl para la malla
    decomposePar                                #Parte las instancias para los procesos en paralelo
    srun snappyHexMesh -parallel -overwrite     #Crea la malla en paralelo
    reconstructParMesh -constant                #Unifica la malla en la carpeta constant
    rm -rf processor*                           #Borra carpetas procesadores
    rm -rf 0                                    #Borra la carpeta 0 falsa
    mv 0.org 0                                  #Trae de vuela la carpeta original 0
    checkMesh -allTopology -allGeometry         #Verifica la calidad de la malla

    #------------------------------------------------------------------------------
    #     PROCESO DE SIMULACIÓN Y UNIFICACIÓN DE RESULTADOS
    #------------------------------------------------------------------------------

    decomposePar                                #Parte las instancias para los procesos en paralelo
    srun renumberMesh -overwrite                #Reescribe la malla de forma que sea mas estable a la hora de la simulación
    srun `getApplication` -parallel             #Inicia el proceso de cálculo
    reconstructPar                              #Reconstruye los resultados en las carpetas del tiempo

    #------------------------------------------------------------------------------
    #     BORRADO Y LIMPIEZA DE ARCHIVOS QUE NO SON NECESARIOS
    #------------------------------------------------------------------------------

    rm -rf processor*                           #Borra carpetas procesadores
    . $WM_PROJECT_DIR/bin/tools/CleanFunctions  # Source tutorial clean functions

    #------------------------------------------------------------------------------
    #     FIN DE LA SIMULACIÓN
    #------------------------------------------------------------------------------

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
