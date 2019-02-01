.. _info-jobs:

.. role:: bash(code)
          :language: bash

.. role:: raw-html(raw)
          :format: html


Getting information about jobs
==============================

.. contents:: Contents
              :local: 


**Getting cluster(s) state**
---------------------------- 

In Slurm, nodes have different states [2]_, this tells if a job can  or not be 
allocated. 

.. csv-table:: Slurm node's states
     :header-rows: 1
     :widths: 5, 8
     :file: src/info/node_states.csv

The simplest way to get information about the state of our clusters is
using these commands: ``sinfo`` and ``squeue``. Here we list some useful 
examples [1]_ [2]_ [3]_ .

* Report basic node and partition (queue) configurations and state and 
  long version
  

  .. code-block:: bash

       sinfo
       sinfo -s
       sinfo -N

* Report node state reason (if exists)
 
  .. code-block:: bash

      sinfo -R


* Show queued jobs, and long version

  .. code-block:: bash

       squeue
       squeue -l

  .. note::
       ``squeue`` jobs also include running jobs.


* Show queued jobs by a specific user. Most of cases you will need to get information
  about your jobs, using the variable ``$USER`` could be useful. 


  .. code-block:: bash
    
     squeue -u $USER
     squeue -u pepito77
    

* Show queue jobs of a specific partition/queue.

  .. code-block:: bash

     squeue -p debug
     squeue -p bigmem
     squeue -p accel

* Show queue jobs that are in a specific state. To know more about job's state see:
  ``What's going on with my job?``

  .. code-block:: bash
     
      squeue -t PD
      squeue -t R
      squeue -t F
      squeue -t PR

* Show detailed information about node(s)
   
  .. code-block:: bash

      scontrol show node compute-1-25
      scontrol show node compute-0-5
      scontrol show node debug-0-0

.. note::

   If you need further information, you can always check the command's manual
   ``man squeue``, ``man sinfo``, etc. 

**What's going on with my job?** Getting information about submitted jobs
-------------------------------------------------------------------------
Once your job is queue in an specific partition you may want to know its state. 
There some of the Slurm's job states [3]_. 

.. csv-table:: Job's states
     :header-rows: 1
     :widths: 5, 8
     :file: src/info/jobs_states.csv

You can check the expected start time of a job(s) base on the actual queue state:

.. code-block:: bash

    squeue --start --job 1234 
    squeue --start -u $USER


You can also check the reason why your job is waiting, usually is displayed by
default in the command ``squeue``. You can also change the output format, thus,
display the field ``reason (%R)`` more clearly.

.. code-block:: bash

   squeue -u $USER --format="%j %name %U %R"
   squeue --jobid 1234 --format="%j %name %U %R"

.. note::

   Not only pending jobs have the field reason set, also failure completed jobs 
   show the reason of its fail in it.   

.. note::

   You can also use ``sprio`` in order to know the priority of your job(s). 
   For further information see ``man sprio``

In the following table [3]_ we describe the most common reasons:

.. csv-table:: Job's reasons
     :header-rows: 1
     :file: src/info/jobs_reasons.csv

.. warning::
  
  Related with ``QOSMaxCpuPerUserLimit`` Slurm's reason, the maximum number of 
  allocated resources (in specific Memory and CPUs) per User at the same time 
  differs between clusters:

  * **Apolo:**
        **CPUs:** 96
        **Memory:** 192G

  * **Cronos:**
        **CPUs:** 96
        **Memory:** 384G

  It is important to note that those are policies defined by of 
  Centro de Computación Científica Apolo.


Another useful command to show information about recently jobs is:

.. code-block:: bash

  scontrol show job 1234

There is an example of its output from :ref:`Apolo II <about_apolo-ii>`.

.. literalinclude:: src/info/scontrol_show_job_ouput
       :language: bash

.. note::
  
  We also recommend to log in (using ``ssh`` ) into the respective compute node(s)
  of your job and run ``htop`` in order to see if your process(es) are actually
  running in the way that you expect and the compute's ``CPU Load`` is optimum. 
  To know more about see: :ref:`FAQ <faq-slurm>`   


**Canceling a job**
-------------------
Once your job is submitted and running, you can do some operations in order to
change its state. Here we list some useful examples [1]_ [4]_  .

* Cancel job 1234

  .. code-block:: bash

     scancel 1234

* Cancel only array ID 9 of job array 1234

  .. code-block:: bash

     scancel 1234_9

* Cancel all my jobs (without taking care of its state)
    
  .. code-block:: bash

     scancel -u $USER

* Cancel my waiting (``pending`` state) jobs.
  
  .. code-block:: bash

     scancel -u $USER -t pending

* Cancel the jobs queue on a given partition (queue)

  .. code-block:: bash

     scancel -p longjobs 

* Cancel one or more jobs by name
  
  .. code-block:: bash

     scancel --name MyJobName

* Pause the job 1234
  
  .. code-block:: bash

     scontrol hold 1234

* Resume the job 1234
  
  .. code-block:: bash
   
     scontrol resume 1234

* Cancel and restart the job 1234
  
  .. code-block:: bash
  
     scontrol requeue 1234
  
**What happened with my job?** Getting information about finished jobs
----------------------------------------------------------------------
Here we are going to explain how to get information about completed jobs 
(that are not longer in the queue). Those commands use the Slurm database to
get the information.

* ``sacct``: is used to get general accounting data for all jobs and job steps 
  in the Slurm [5]_

   * Get the today's jobs submitted by a user (or users) 

       .. code-block:: bash

            sacct -S$(date +'%m/%d/%y) -u $USER

   * Get the jobs submitted by a user (or users) 1 week ago
   
        .. code-block:: bash

            sacct -S$(date +'%m/%d/%y' --date="1 week ago") -u $USER 



* ``ssat``: [6]_


References
----------

.. [1] cool page about stats commands in Slurm
.. [2] sinfo man page
.. [3] squeue man page
.. [4] scancel man page
.. [5] sacct man page
.. [6] sstat man page