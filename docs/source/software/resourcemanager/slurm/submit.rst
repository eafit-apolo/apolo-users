.. _submit:

.. role:: bash(code)
          :language: bash

.. role:: raw-html(raw)
          :format: html

.. contents:: Contents
              :local:


What is ``sbatch``?
-------------------
**Slurm** as a resource manager has a lot of options to manage all the resources
of a cluster to achieve any possible combination of needs like: 
Number of CPUs, Number of Nodes, Memory, Time, GPUs, Licenses, etc.

The command ``sbatch`` is used to submit a ``batch`` script, making your job 
running in the cluster. Like this:

.. code-block:: bash
		
   sbatch <batch_script>

A Slurm ``batch`` is a shell script (usually written in ``bash``) where you
specify all these options to Slurm, including the creation of the environment to
make your job run correctly, and the set of commands to run that job.

Thus, we say that a ``batch`` script has **three** parts:

#. **Sbatch parameters**:
   
   The idea is to include all the information you think Slurm should know about
   your job (name, notification mail, partition, std_out, std_err, etc) and 
   request all your computational needs, which consist at least in a number of CPUs,
   the computing expected duration and amounts of RAM.
  
   All these parameters must start with the comment ``#SBATCH``, one per line,  
   and need to be included at the beginning of the file, just after
   the shebang (``e.g. #!/bin/bash``) which should be the first line.

   The following table show important and common options, for further
   information you can check this section.

   .. csv-table:: Sbatch option's table
     :header-rows: 1
     :widths: 5, 8, 5, 4
     :stub-columns: 1
     :file: src/sbatch_options.csv

   .. note::
     Each option must be included using ``#SBATCH <option>=<value>``
    
   .. warning::
      Some options/parameters may be specific for our clusters. 
   
   .. note::
     About the ``--mail-type`` option, the value ``TIME_LIMIT_%``  means the reached
     time percent, thus, ``TIME_LIMIT_90`` notify reached the 90% of walltime,
     ``TIME_LIMIT_50`` at the 50%, etc.  
   
#. **Environment creation**

   Next, you should create the necessary environment to make your job run correctly.
   This often means include the same set of steps that you do to run your application
   locally on your sbatch script, things like export environmental variables,
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
     :file: src/module_table.csv

   .. warning:: 
     Slurm **always** propagate the environment of the current user to the job.
     This could impact the behavior of the job. If you want a clean environment
     add ``#SBATCH --export=NONE`` to your sbatch script. 
     This option is particularly important for jobs that are submitted  on  one  
     cluster  and execute on a different cluster (e.g. with different paths). 
   
#. **Job's command(s)**
  
  Finally you put the command that executes your application, including all the
  parameters. 
  You will often see the command ``srun`` calling the executable instead of 
  executing the application binary. For more information see `MPI jobs`_ section.  

There are other options beyond using ``sbatch`` to submit jobs to Slurm,
like ``salloc`` or simply using ``srun``. We recommend using ``sbatch``, but
depending on the specific need of your application those options could be better.


Debug partition
---------------
The debug partition is a useful queue created to test your Slurm job script,
it does not have any performance capabilities but its nodes have the same 
environment as the longjobs partition.

To use this partition you only need to specify it in your batch script like
this:

.. code-block:: bash

   #!/bin/bash
   #SBATCH --partition=debug
   # Other sbatch parameters

.. note::
  Quick aspects about debug partition:
  
  * **Apolo:** 

      * Number of Nodes: 2
      * Number of CPUs per node: 2
      * Memory per node: 2GB

  * **Cronos:** Not deployed yet.

  For more information, see :ref:`getting cluster information <info-jobs>` section

.. warning::
  Debug partition has the same environment of longjobs, so if you want to test
  a job that will be executed in a different queue (e.g Accel or Bigmem) 
  it does not guarantee a successful execution. 

Serial jobs
-----------
Serial jobs only uses a process with **one** execution thread, 
this means one core of a CPU, given our configuration without HTT_ 
(Hyper-Threading Technology). 

This kind of job does not take advantage of our computational resources, but 
is the basic step to create more complex jobs. 

In terms of Slurm, this job uses one ``task (process)`` and one 
``cpu-per-task (thread)`` in one ``node``. In fact, we don't need to specify any 
resource, the default value for those options in Slurm are ``1``.

Here_ is a good article about the differences between ``Processes`` and 
``Threads``.

In the template bellow we specify ``ntasks=1`` to make it explicit.

.. literalinclude:: src/templates/serial.sh
       :language: bash
       :caption: :download:`serial-template.sh <src/templates/serial.sh>`


Array jobs
----------
Also called Embarrassingly-Parallel_, this set up is commonly used by users
that do not have a native parallel application, so they run multiple parallel
instances of his application changing its ``input``.

This ``input`` usually refers to these cases: 

#. **File input**

   You have **multiple files/directories** to **process**.
  
   In the bellow example/template we make a "parallel copy" of the files contained 
   in ``test`` directory using the command ``cp``. 

   .. literalinclude:: src/str_directory_array.txt
       :language: bash

   We use one ``ntask`` per each ``job-step``. The array goes from 0 to 4, 
   so there are 5 process copying the 5 files contened in the ``test`` directory.


   .. literalinclude:: src/templates/array.sh
       :language: bash
       :caption: :download:`array-template.sh <src/templates/array.sh>`
  
   Thus, the generated file ``copy0`` is the copy of the file ``test/file1.txt``
   and the file ``copy1`` is the copy of the file ``test2.txt`` and so on.
   Each one done by a different Slurm process in parallel.

#. **Parameters input**
   You have **multiple parameters** to **process**


.. note:: 
   The parameter ``ntasks`` when is used in array jobs specify the number of process
   that **EACH** ``job-step`` is going to use. So if you want more, you
   just need to specify it.

.. note::
   If you want to assing an ``N`` number of process for each node
  
.. note:: 
  The main idea behind this using Array jobs in Slurm is based on the use of the
  variable ``SLURM_ARRAY_TASK_ID``. 


Shared Memory jobs (OpenMP)
---------------------------

MPI jobs
--------

Slurm's environment variables
-----------------------------
In the above examples we often use the output environment variables provided for
Slurm. Here you have a table with the most common ones. 

tabla

Slurm's file-pattern
--------------------

.. _Module: http://modules.sourceforge.net/man/modulefile.html
.. _HTT: https://en.wikipedia.org/wiki/Hyper-threading
.. _Here: https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
.. _Embarrassingly-Parallel: http://www.cs.iusb.edu/~danav/teach/b424/b424_23_embpar.html

References
----------

.. [1] NYU HPC. (n.d). Slurm + tutorial - Software and Environment Modules. Retrieved 
       17:47, January 21, 2019 from https://wikis.nyu.edu/display/NYUHPC/Slurm+Tutorial
