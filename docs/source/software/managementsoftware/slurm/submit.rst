.. _submit:

.. role:: bash(code)
          :language: bash

.. role:: raw-html(raw)
          :format: html


**Submitting jobs**
===================

.. contents:: Contents
              :local:


What is ``sbatch``?
-------------------
**Slurm** has a lot of options to manage all the resources of a cluster to
achieve any possible combination of needs like:
Number of CPUs, Number of Nodes, Memory, Time, GPUs, Licenses, etc.

The command ``sbatch`` is used to submit a ``batch`` script, making your job
running in the cluster. Like this:

.. code-block:: bash

   $ sbatch <batch_script>

A Slurm ``batch`` is a shell script (usually written in ``bash``) where you
specify all these options to Slurm, including the creation of the environment to
make your job run correctly, and the set of commands to run that job.

Thus, we say that a ``batch`` script has **three** parts:

#. **Sbatch parameters**:

   The idea is to include all the information you think Slurm should know about
   your job (name, notification mail, partition, std_out, std_err, etc) and
   request all your computational needs, which consist at least in a number of CPUs,
   the computing expected duration and the amount of RAM to use.

   All these parameters must start with the comment ``#SBATCH``, one per line,
   and need to be included at the beginning of the file, just after
   the shebang (``e.g. #!/bin/bash``) which should be the first line.

   The following table [3]_ shows important and common options, for further
   information see ``man sbatch``.

   .. csv-table:: Sbatch option's
     :header-rows: 1
     :widths: 5, 8, 5, 4
     :stub-columns: 1
     :file: src/submit/sbatch_options.csv

   .. note::
     Each option must be included using ``#SBATCH <option>=<value>``

   .. warning::
      Some values of the options/parameters may be specific for our clusters.

   .. note::
     About the ``--mail-type`` option, the value ``TIME_LIMIT_%``  means the reached
     time percent, thus, ``TIME_LIMIT_90`` notify reached the 90% of walltime,
     ``TIME_LIMIT_50`` at the 50%, etc.

#. **Environment creation**

   Next, you should create the necessary environment to make your job run correctly.
   This often means include the same set of steps that you do to run your application
   locally on your sbatch script, things like export environment variables,
   create or delete files and directory structures, etc.
   Remember a Slurm script is a shell script.

   In case you want to submit a job that uses an :ref:`application <applications-index>`
   that is installed in our :ref:`clusters <supercomputers>` you have to
   ``load`` its module.

   An application Module_. is used to create the specific environment needed by
   your application.

   The following table [1]_ show useful commands about modules.

   .. csv-table:: Module useful commands
     :header-rows: 1
     :widths: 5, 10
     :stub-columns: 1
     :file: src/submit/module_table.csv

   .. warning::
     Slurm **always** propagate the environment of the current user to the job.
     This could impact the behavior of the job. If you want a clean environment,
     add ``#SBATCH --export=NONE`` to your sbatch script.
     This option is particularly important for jobs that are submitted  on  one
     cluster  and execute on a different cluster (e.g. with different paths).

#. **Job(s) steps**

  Finally, you put the command(s) that executes your application, including all the
  parameters.
  You will often see the command ``srun`` calling the executable instead of
  executing the application binary. For more information see `MPI jobs`_ section.

There are other options beyond using ``sbatch`` to submit jobs to Slurm,
like ``salloc`` or simply using ``srun``. We recommend using ``sbatch``, but
depending on the specific need of your application those options could be better.
To know more about see: :ref:`FAQ <faq-slurm>` and :ref:`testing-slurm`

Serial jobs
-----------
Serial jobs only use a process with **one** execution thread,
this means one core of a CPU, given our configuration without HTT_
(Hyper-Threading Technology).

This kind of job does not take advantage of our computational resources but
is the basic step to create more complex jobs.

In terms of Slurm, this job uses one ``task (process)`` and one
``cpu-per-task (thread)`` in one ``node``. In fact, we don't need to specify any
resource, the default value for those options in Slurm is ``1``.

Here_ is a good article about the differences between ``Processes`` and
``Threads``.

In the template below we specify ``ntasks=1`` to make it explicit.

.. literalinclude:: src/submit/templates/serial.sh
       :language: bash
       :caption: :download:`serial-template.sh <src/submit/templates/serial.sh>`


Shared Memory jobs (OpenMP)
---------------------------
This set up is made to create parallelism using threads on a single machine.
OpenMP makes communication between threads (``-c`` in Slurm) but they must be on
the same machine, it does not make any kind of communication between
process/threads of different physical machines.

In the below example we launched the classical "Hello world" OpenMP example [5]_.
It was compiled in :ref:`Cronos <about_cronos>` using ``intel compiler 18.0.1``
as follow:

.. code-block:: bash

    $ module load intel/18.0.1
    $ icc -fopenmp omp_hello.c -o hello_omp_intel_cronos

We used **16** ``threads``, the maximum number allowed in the Cronos' longjobs
partition. In terms of Slurm, we specify **16** ``cpus-per-task`` and one ``ntasks``.

.. literalinclude:: src/submit/templates/openmp.sh
       :language: bash
       :caption: :download:`openmp-template.sh <src/submit/templates/openmp.sh>`

**Output**

.. literalinclude:: src/submit/openmp_output
       :language: bash

.. warning::
  Remember the maximum number of total threads that can be running at the same
  time in a compute node.

  * **Apolo:**
     * **Longjobs queue:** 32
     * **Accel queue:** 32
     * **Bigmem queue:** 24
     * **Debug queue:** 2

  * **Cronos:**
     * **Longjobs queue:** 16

  Otherwise, your job will overpass the maximum multiprocessing grade and this is
  going to cause a drastic decrease in the performance of your application.
  To know more about see: :ref:`FAQ <faq-slurm>`

  As extra information, our setup does not use HTT_ (Hyper-Threading Technology).

.. note::
  We highly recommend using the Slurm variable ``$SLURM_CPUS_PER_TASK`` to specify
  the number of threads that OpenMP is going to work with. Most of the applications
  use  the variable ``OMP_NUM_THREADS`` to defined it.

MPI jobs
--------

MPI jobs are able to launch multiple processes on multiple nodes.
There is a lot of possible workflows using MPI, here we are going to
explain a basic one. Based on this example and modifying its parameters, you can
find the configuration for your specific need.

The example was compiled in :ref:`Cronos <about_cronos>` using ``impi`` as follow:

.. code-block:: bash

    $ module load impi
    $ impicc hello_world_mpi.c -o mpi_hello_world_apolo

We submited the classic "Hello world" MPI example [6]_ using 5 processes (``--ntasks=5``),
each one on a different machine (``--ntasks-per-node=1``). Just to be clear,
we used 5 machines and 1 CPU per each, leaving the other CPUs
(15, in this specific case) free to be allocated by Slurm to other jobs.

.. literalinclude:: src/submit/templates/mpi.sh
       :language: bash
       :caption: :download:`mpi-template.sh <src/submit/templates/mpi.sh>`

.. note::
   The use of ``srun`` is mandatory here. It creates the necessary
   environment to launch the MPI processes. There you can also specify other parameters.
   See ``man srun`` to more information.

   Also, the use of ``--mpi=pmi2`` is mandatory, it tells MPI to use the pmi2_ Slurm's
   plugin. This could change when you are using a different implementation of MPI
   (e.g MVAPICH, OpenMPI) but we strongly encourage our users to specify it.

**Output**

.. literalinclude:: src/submit/mpi_output

.. warning::
   As you can see in that example, we do not specify ``-N`` or ``--nodes`` to submit
   the job in 5 different machines. You can let Slurm decides how many machines your
   job needs.

   Try to think in terms of "tasks" rather than "nodes".

This table shows some other useful cases [2]_:

.. csv-table:: MPI jobs table
     :header-rows: 1
     :widths: 10, 7
     :file: src/submit/mpi_jobs_table.csv

Array jobs
----------
Also called Embarrassingly-Parallel_, this set up is commonly used by users
that do not have a native parallel application, so they run **multiple parallel
instances** of their application changing its ``input``. Each instance is
independent and does not have any kind of communication with others.

To do this, we specify an array using the ``sbatch`` parameter ``--array``,
multiple values may be specified using a comma-separated list and/or a
range of values with a "-" separator (e.g ``--array=1,3,5-10`` or ``--array=1,2,3``).
This will be the values that the variable ``SLURM_ARRAY_TASK_ID`` is
going to take in each ``array-job``.

This ``input`` usually refers to these cases:

1. **File input**

   You have **multiple files/directories** to **process**.

   In the below example/template we made a "parallel copy" of the files contained
   in ``test`` directory using the ``cp`` command.

   .. literalinclude:: src/submit/str_directory_array.txt
       :language: bash

   We used one process (called ``task`` in Slurm) per each ``array-job``.
   The array goes from 0 to 4, so there were 5 processes copying the 5 files
   contained in the ``test`` directory.


   .. literalinclude:: src/submit/templates/array_file.sh
       :language: bash
       :caption: :download:`array-file-input-template.sh <src/submit/templates/array_file.sh>`

   Thus, the generated file ``copy_0`` is the copy of the file ``test/file1.txt``
   and the file ``copy_1`` is the copy of the file ``test2.txt`` and so on.
   Each one was done by a different Slurm process in parallel.


.. warning::
   Except to ``--array``, **ALL** other ``#SBATCH`` options specified in the
   submitting Slurm script are used to configure **EACH** ``job-array``, including
   **ntasks**, **ntasks-per-node**, **time**, **mem**, etc.

2. **Parameters input**

   You have **multiple parameters** to **process**.

   Similarly to the last example, we created an array with some values that we
   wanted to use as parameters of the application. We used one process (``task``)
   per ``array-job``. We had 4 parameters (``0.05 100 999 1295.5``)
   to process and 4 ``array-jobs``.

   **Force Slurm to run array-jobs in different nodes**

   To give another feature to this example, we used ``1`` node for
   each ``array-job``, so, even knowing that one node can run up to 16 processes
   (in the case of :ref:`Cronos <about_cronos>`) and the 4 ``array-jobs``
   could be assigned to ``1`` node, we forced Slurm to use ``4`` nodes.

   To get this we use the parameter ``--exclusive``, thus, for each ``job-array``
   Slurm will care about not to have other Slurm-job in the same node, even other
   of your ``job-array``.

   .. note::

      Just to be clear, the use of ``--exclusive`` as a **SBATCH** parameter tells
      Slurm that the job allocation cannot share nodes with other running jobs [4]_ .
      However, it has a slightly **different** meaning when you use it as a
      parameter of a job-step (each separate srun execution inside a **SBATCH**
      script, e.g ``srun --exclusive $COMMAND``). For further information see
      ``man srun``.


  .. literalinclude:: src/submit/templates/array_param.sh
       :language: bash
       :caption: :download:`array-params-template.sh <src/submit/templates/array_param.sh>`

Remember that the **main idea** behind using Array jobs in Slurm is based on the
use of the variable ``SLURM_ARRAY_TASK_ID``.

.. note::
   The parameter ``ntasks`` specify the number of processes that **EACH**
   ``array-job`` is going to use. So if you want to use more, you
   just can specify it. This idea also applies to all other ``sbatch``
   parameters.

.. note::
   You can also limit the number of simultaneously running tasks from the job
   array using a ``%``  separator. For example ``--array=0-15%4`` will limit the
   number of simultaneously running tasks from this job array to 4.


Slurm's environment variables
-----------------------------
In the above examples, we often used the output of the environment variables provided by
Slurm. Here you have a table [3]_ with the most common variables.

.. csv-table:: Output environment variables
     :header-rows: 1
     :widths: 2,7
     :file: src/submit/output_env_table.csv

Slurm's file-patterns
---------------------
``sbatch``  allows filename patterns, this could be useful to name ``std_err`` and
``std_out`` files. Here you have a table [3]_ with some of them.

.. csv-table:: Slurm's file-patterns
     :header-rows: 1
     :widths: 3,7
     :file: src/submit/file-patern-table.csv

.. note::

   If you need to separate the output of a job per each node requested, ``%N`` is
   specially useful, for example in array-jobs.

For instance, if you use ``#SBATCH --output=job-%A.%a`` in an array-job the output
files will be something like ``job-1234.1``, ``job-1234.2`` , ``job-1234.3``;
where: ``1234`` refers to the job array’s master job allocation number and ``1``
, ``2`` and ``3`` refers to the id of each job-array.

Constraining Features on a job
------------------------------
In Apolo II, one can specify what type of CPU instruction set to use. One can choose
between `AVX2 <https://en.wikipedia.org/wiki/Advanced_Vector_Extensions#AVX2>`_ and
`AVX512 <https://en.wikipedia.org/wiki/AVX-512>`_. These *features* can be specify
using the SBATCH option ``--constraint=<list>`` where ``<list>`` is the **features** to constrain.
For example, ``--constraint="AVX2"`` will allocate only nodes that have AVX2 in their instruction
set. ``--constraint="AVX2|AVX512"`` will allocate only nodes that have either AVX512 or AVX2.

One can also have a job requiring some nodes to have AVX2 and some others using AVX512. For this
one would use operators **'&'** and **'*'**. The ampersand works as a **'and'** operator, and the
**'*'** is used to specify the number of nodes that must comply a single feature. For example,
``--constraint="[AVX2*2&AVX512*3]"`` is asking for two nodes with AVX2 and three with AVX512.
The squared brackets are mandatory.

References
----------

.. [1] NYU HPC. (n.d). Slurm + tutorial - Software and Environment Modules. Retrieved
       17:47, January 21, 2019 from https://wikis.nyu.edu/display/NYUHPC/Slurm+Tutorial

.. [2] UCLouvai - University of Leuven (n.d). Slurm Workload Manager - Slide 57. Retrieved 11:33
       January 25, 2019 from http://www.cism.ucl.ac.be/Services/Formations/slurm/2016/slurm.pdf

.. [3] SchedMD LLC (2018). Slurm, resource management [sbatch]. Copy of manual text available at
       https://slurm.schedmd.com/sbatch.html. Retrieved 17:20 January 30, 2019

.. [4] SchedMD LLC (2018). Slurm, resource management [srun]. Copy of manual text available at
       https://slurm.schedmd.com/srun.html. Retrieved 12:20 January 31, 2019

.. [5] Barney Blaise (2005) OpenMP Example - Hello World - C/C++ Version.
       Example was taken from
       https://computing.llnl.gov/tutorials/openMP/samples/C/omp_hello.c
       Retrieved 09:32 February 12, 2019

.. [6] Burkardt John (2008) Using MPI: Portable Parallel Programming with the
       Message-Passing Interface. Example was taken from
       https://people.sc.fsu.edu/~jburkardt/c_src/heat_mpi/heat_mpi.c
       Retrived 09:38 February  12, 2019

.. _Module: http://modules.sourceforge.net/man/modulefile.html
.. _HTT: https://en.wikipedia.org/wiki/Hyper-threading
.. _Here: https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
.. _Embarrassingly-Parallel: http://www.cs.iusb.edu/~danav/teach/b424/b424_23_embpar.html
.. _pmi2: https://pmix.org/
