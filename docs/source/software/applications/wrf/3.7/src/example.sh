#!/bin/bash
#SBATCH --job-name=wps-wrf                      # Job name
#SBATCH --mail-type=ALL                         # Mail notification
#SBATCH --mail-user=<user>@<domain>             # User Email
#SBATCH --error=%x-%j.err                       # Stderr (%j expands to jobId)
#SBATCH --output=%x-%j.out                      # Stdout (%j expands to jobId)
#SBATCH --ntasks=2                              # Number of tasks (processes)
#SBATCH --nodes=1                               # Number of nodes
#SBATCH --time=3:00:00                          # Walltime
#SBATCH --partition=longjobs                    # Partition

##### MODULES #####

module load gcc/5.4.0
module load mpich2/3.2_gcc-5.4.0
module load jasper/1.900.1_gcc-5.4.0
module load autoconf/2.69
module load hdf5/1.8.16_gcc-5.4.0
module load netcdf/4.4.0_gcc-5.4.0
module load netcdf-fortran/4.4.3_gcc-5.4.0
module load zlib/1.2.11_gcc-5.4.0

#### ENVIRONMENT VARIABLES ####

export OMP_NUM_THREADS=1

#### VARIABLES ####

WPS_DIR=/path/to/WPS/
WRF_DIR=/path/to/WRFV3/
WRF_HELP=/path/to/wrfhelp/

##### JOB COMMANDS ####

## WPS ##

## Delete previous wrf files ##
cd ${WPS_DIR}
rm -rf GRIBFILE.A*
rm -rf met_em.d0*
rm -rf GFS*
rm -rf geo_em.d0*

## Start ##
./geogrid.exe >& output_geogrid.log
./link_grib.csh ${WRF_HELP}/GFS030416/gfs*
ln -sf ${WPS_DIR}/ungrib/Variable_Tables/Vtable.GFS Vtable
./ungrib.exe >& output_ungrib.log
./metgrid.exe >& output_metgrid.exe

## WRF ##
cd ${WRF_DIR}/run
rm -rf rsl.*
rm -rf met_em.d0*
rm -rf wrffdda_d0*
rm -rf wrfinput_d0*
ln -sf ${WPS_DIR}/met_em* .
./real.exe

## Run MPI with SLURM ##
srun --mpi=pmi2 ./wrf.exe
