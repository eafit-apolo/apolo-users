.. _yade-2022.01a:

Yade 2022.01a
=============

Basic Information
-----------------

- *Installation Date:* dd/mm/yyyy
- *URL:* https://yade-dem.org/
- *Apolo Version:* Apolo II
- *License:* GNU GPL

Dependencies
------------

- Apptainer (provided by the `apptainer` module)
- Ubuntu 22.04 base image, which supplies Boost, the OpenMP runtime and
  Python 3 inside the container

Installation
------------

Yade is not built from source on the cluster. It is packaged as a Singularity
Image Format (SIF) container from the official Ubuntu 22.04 packages and
exposed through a wrapper script.

Container image
^^^^^^^^^^^^^^^

Definition file `yade.def`:

.. code-block:: singularity

   Bootstrap: docker
   From: ubuntu:22.04

   %post
       apt-get update && apt-get install -y \
           yade \
           python3-yade \
           python3-pip \
           ca-certificates
       apt-get clean

   %environment
       export LC_ALL=C

Build the read-only SIF image on the head node:

.. code-block:: bash

   apptainer build yade.sif yade.def

Deployment path
^^^^^^^^^^^^^^^

Following the OpenHPC convention
`/opt/ohpc/pub/apps/<software>/<version>`, create the version directory and
copy the image from the local path to the shared one:

.. code-block:: bash

   sudo mkdir -p /opt/ohpc/pub/apps/yade/2022.01a

   sudo cp yade.sif /opt/ohpc/pub/apps/yade/2022.01a/yade.sif

Wrapper script
^^^^^^^^^^^^^^

A wrapper is used instead of a Bash alias, since aliases are not resolved in
the non-interactive subshells spawned by SLURM:

.. code-block:: bash

   sudo mkdir -p /opt/ohpc/pub/apps/yade/2022.01a/bin

   cat << 'EOF' | sudo tee /opt/ohpc/pub/apps/yade/2022.01a/bin/yade
   #!/bin/bash
   exec apptainer exec /opt/ohpc/pub/apps/yade/2022.01a/yade.sif yade "$@"
   EOF

`"$@"` forwards every user flag (simulation script, thread count `-j`,
exit flag `-x`) to the containerized binary.

Module File
-----------

.. code-block:: bash

   sudo mkdir -p /opt/ohpc/pub/modulefiles/yade

`/opt/ohpc/pub/modulefiles/yade/2022.01a.lua`:

.. code-block:: text

   help([[Loads the Yade DEM simulation environment (v2022.01a)]])

   whatis("Name: Yade")
   whatis("Version: 2022.01a")
   whatis("Category: Simulation / DEM")

   depends_on("apptainer")

   prepend_path("PATH", "/opt/ohpc/pub/apps/yade/2022.01a/bin")

Running Example
---------------

Interactive session:

.. code-block:: bash

   module load yade/2022.01a
   yade

Batch submission (`job_yade.sh`):

.. code-block:: bash

   #!/bin/bash
   #SBATCH --job-name=yade_sim
   #SBATCH --output=logs/yade_%j.out
   #SBATCH --error=logs/yade_%j.err
   #SBATCH --ntasks=1
   #SBATCH --cpus-per-task=8
   #SBATCH --partition=normal

   module load yade/2022.01a

   # -x: exit after the script finishes, preventing a hanging IPython prompt
   yade -x my_simulation.py

.. code-block:: bash

   sbatch job_yade.sh

.. note::

   `logs/yade_<JOB_ID>.err` collects container runtime messages (SIF
   conversion, TCP socket initialization, temporary directory cleanup). These
   are ordinary `stderr` output and do not indicate a failed job. The
   simulation output, including the Yade version header and iteration
   summaries, is written to `logs/yade_<JOB_ID>.out`.

Resources
---------

- https://yade-dem.org/doc/
- https://gitlab.com/yade-dev/trunk
- https://apptainer.org/docs/user/main/
- https://lmod.readthedocs.io/

Author
------

- Byron Arenilla Ramirez (Apolo Scientific Computing Center <https://www.eafit.edu.co/apolo>_)
- Juan Manuel Morales Cartagena (Apolo Scientific Computing Center <https://www.eafit.edu.co/apolo>_)
