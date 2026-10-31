.. _julia-1.12.6:

Julia 1.12.6
============

:Authors: Jeronimo Campuzano
:Maintainer: Jeronimo Campuzano
:Last reviewed: 2026-10-31
:Applies to: Apolo II

How to use Julia 1.12.6 on Apolo II, including how to run it on several
nodes, and how it was installed.

Basic information
-----------------

- **Installation date:** 2026-10-23
- **Installed on:** Apolo II
- **Installation path:** :file:`/opt/ohpc/pub/apps/julia/1.12.6`
- **Website:** `julialang.org <https://julialang.org>`_
- **License:** MIT

Usage
-----

Load the module:

.. code-block:: bash

   module load julia/1.12.6

Check that it works:

.. code-block:: console

   $ julia --version
   julia version 1.12.6

Julia packages
~~~~~~~~~~~~~~

Each user installs their own packages. They are stored in
:file:`$HOME/.julia`, and the module sets ``JULIA_DEPOT_PATH`` to that
directory. Install a package from the login node, where you have internet
access, for example:

.. code-block:: bash

   julia -e 'using Pkg; Pkg.add("SlurmClusterManager")'

.. note::

   The first time you install or load a package, Julia compiles it. This can
   take several minutes and prints almost nothing while it works, so it can
   look frozen. Let it finish. If your connection might drop, run it inside
   ``screen`` or submit it as a job.

Because your home directory is shared by all the nodes, a package installed
once is available in every job.

Example job: one node
~~~~~~~~~~~~~~~~~~~~~

This job runs Julia with 4 threads on one node.

Save this script as :file:`julia-job.sh`, together with your Julia code. Here
the code is inline, with ``-e``:

.. code-block:: bash
   :caption: julia-job.sh

   #!/bin/bash
   #SBATCH --job-name=julia-test           # Job name
   #SBATCH --partition=longjobs            # Partition
   #SBATCH --nodes=1                       # Nodes
   #SBATCH --ntasks=1                      # Tasks (processes)
   #SBATCH --cpus-per-task=4               # Cores per task
   #SBATCH --mem=8G                        # Memory per node
   #SBATCH --time=0-00:10:00               # Time limit (D-HH:MM:SS)
   #SBATCH --output=%x-%j.out              # Output (%x = job name, %j = job ID)
   #SBATCH --error=%x-%j.err               # Errors

   ##### ENVIRONMENT #####
   module purge
   module load julia/1.12.6

   ##### JOB COMMANDS #####
   julia -t "$SLURM_CPUS_PER_TASK" -e '
   using LinearAlgebra
   println("Julia threads: ", Threads.nthreads())

   acc = Threads.Atomic{Int}(0)
   Threads.@threads for i in 1:1_000_000
       Threads.atomic_add!(acc, 1)
   end
   println("Parallel sum = ", acc[], " (expected 1000000)")

   A = rand(2000, 2000)
   @time B = A * A
   println("Trace = ", tr(B))
   '

Submit it with ``sbatch julia-job.sh``. The output is written to
:file:`julia-test-<jobid>.out`; the parallel sum must be ``1000000``.

Running on several nodes
~~~~~~~~~~~~~~~~~~~~~~~~

Julia can distribute work across nodes with the ``Distributed`` standard
library. The ``SlurmClusterManager`` package starts one Julia worker per Slurm
task, so you only choose the number of workers with ``--nodes`` and
``--ntasks-per-node``.

First install the package once, as shown in `Julia packages`_. Then save this
program as :file:`multinode.jl`:

.. code-block:: julia
   :caption: multinode.jl

   using Distributed, SlurmClusterManager

   addprocs(SlurmManager())   # one worker per Slurm task

   @everywhere using LinearAlgebra

   println("Workers: ", nworkers())

   # Where did each worker run?
   hosts = [fetch(@spawnat p gethostname()) for p in workers()]
   for h in sort(unique(hosts))
       println("  ", h, " -> ", count(==(h), hosts), " workers")
   end

   # A distributed reduction
   total = @distributed (+) for i in 1:10_000_000
       1
   end
   println("Distributed sum = ", total, " (expected 10000000)")

and this job script as :file:`julia-multinode-job.sh`:

.. code-block:: bash
   :caption: julia-multinode-job.sh

   #!/bin/bash
   #SBATCH --job-name=julia-multinode      # Job name
   #SBATCH --partition=longjobs            # Partition
   #SBATCH --nodes=2                       # Nodes
   #SBATCH --ntasks-per-node=4             # Workers per node
   #SBATCH --cpus-per-task=1               # Cores per worker
   #SBATCH --mem=8G                        # Memory per node
   #SBATCH --time=0-00:10:00               # Time limit (D-HH:MM:SS)
   #SBATCH --output=%x-%j.out              # Output (%x = job name, %j = job ID)
   #SBATCH --error=%x-%j.err               # Errors

   ##### ENVIRONMENT #####
   module purge
   module load julia/1.12.6

   ##### JOB COMMANDS #####
   julia multinode.jl

Submit it with ``sbatch julia-multinode-job.sh``. With 2 nodes and 4 tasks per
node, the output looks like this (the node names will differ):

.. code-block:: text

   Workers: 8
     compute-0-30.apolo.eafit.edu.co -> 4 workers
     compute-0-31.apolo.eafit.edu.co -> 4 workers
   Distributed sum = 10000000 (expected 10000000)

.. important::

   Start Julia once, as in the script above, not with ``srun julia``.
   ``SlurmManager`` calls ``srun`` itself to start the workers inside your
   allocation.

.. note::

   This section covers ``Distributed`` only. Using MPI from Julia
   (``MPI.jl``) or GPUs (``CUDA.jl``) has not been tested on Apolo II.

Installation
------------

#. Download the official Linux x86_64 binary and check its checksum against
   the one published on the `Julia downloads page
   <https://julialang.org/downloads/>`_:

   .. code-block:: bash

      cd /tmp
      curl -LO https://julialang-s3.julialang.org/bin/linux/x64/1.12/julia-1.12.6-linux-x86_64.tar.gz
      sha256sum julia-1.12.6-linux-x86_64.tar.gz

#. Extract it to the installation path:

   .. code-block:: bash

      mkdir -p /opt/ohpc/pub/apps/julia
      tar -xzf julia-1.12.6-linux-x86_64.tar.gz -C /opt/ohpc/pub/apps/julia
      mv /opt/ohpc/pub/apps/julia/julia-1.12.6 /opt/ohpc/pub/apps/julia/1.12.6

#. Create the module file :file:`/opt/ohpc/pub/modulefiles/julia/1.12.6.lua`:

   .. code-block:: lua

      help([[Julia 1.12.6 - high-level language for scientific computing]])
      whatis("Name: Julia")
      whatis("Version: 1.12.6")
      whatis("URL: https://julialang.org")

      local root = "/opt/ohpc/pub/apps/julia/1.12.6"
      prepend_path("PATH", pathJoin(root, "bin"))
      prepend_path("MANPATH", pathJoin(root, "share/man"))

      setenv("JULIA_DEPOT_PATH", os.getenv("HOME") .. "/.julia")

#. Check the module:

   .. code-block:: bash

      module avail julia
      module load julia/1.12.6
      julia --version

References
----------

- `Julia documentation <https://docs.julialang.org>`_
- `Distributed Computing <https://docs.julialang.org/en/v1/manual/distributed-computing/>`_
- `SlurmClusterManager.jl <https://github.com/JuliaParallel/SlurmClusterManager.jl>`_
