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
of a cluster in order to achieve any possible combination of needs like: 
Number of CPUS, Number of Nodes, Memory, Time, GPUs, Licenses, etc.

The command ``sbatch`` is used to submit a ``batch`` script, making your job 
running in the cluster. Like this:

.. code-block:: bash
		
   sbatch <batch_script>

A Slurm ``batch`` is a shell script (usually wrote in ``bash``) where you
specify all these options to Slurm, including the creation of the environment to
make your job run correctly, and the set of commands to run that job.

Thus, we say that a ``batch`` script have **three** parts:

#. **Sbatch parameters**:
   
   The idea is to include all the information you think Slurm should know about
   your job (name, notification mail, partition, std_out, std_err, etc) and 
   request all your computational needs, which consist at least in a number of CPUs,
   the computing expected duration and amounts of RAM.
  
   All this parameters must start with the comment ``#SBATCH``, one per line,  
   and need to be included at the beginning of the file, just after
   the shebang (``e.g. #!/bin/bash``) which should be the first line.

   The following table show important and common options, for further
   information you can check this section.

   .. csv-table:: Sbatch option's table
     :header-rows: 1
     :widths: 5, 10, 5, 2
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

   Next, you should create the necessary environment to make your job work correctly.
   This often means include the same set of steps that you do to run your application
   locally on your sbatch script, things like export environmental variables,
   create or delete files and directory structures, etc. 
   Remember a Slurm script is a shell script.

   In case you want to submit a job that uses an :ref:`application <applications-index>`
   that are installed in our :ref:`clusters <supercomputers>` you have to 
   ``load`` its module.  

   An application Module_. is used to create the specific environment need by 
   the application.  

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
The debug partition is a useful queue created to test your slurm job script,
it does not have any performance capabilities but its nodes have the same 
environment of the longjobs partition.  

.. note::
  Quick aspects about debug partition:
  
  * **Apolo:** 

      * Number of Nodes: 2
      * Number of CPUS per node: 2
      * Memory per node: 2GB

  * **Cronos:** Not deployed yet.

  For more information, see :ref:`getting cluster information <info-jobs>` section

.. warning::
  Debug partition has the same environment of longjobs, so if you want to test a
  job that will be executed in a different queue (e.g Accel or Bigmem) 
  it does not guarantee a successful execution. 

Serial jobs
-----------

Array jobs
----------

OpenMP jobs
-----------

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

.. [1] NYU HPC. (n.d). Slurm + tutorial - Software and Environment Modules. Retrieved 
       17:47, January 21, 2019 from https://wikis.nyu.edu/display/NYUHPC/Slurm+Tutorial
