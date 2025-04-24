.. _info-jobs:

.. role:: bash(code)
          :language: bash

.. role:: raw-html(raw)
          :format: html


**Getting information about jobs**
==================================

.. contents:: Contents
              :local:


Getting cluster(s) state
----------------------------

In Slurm, nodes have different states [2]_, this tells if a job can or not be
allocated.

.. csv-table:: Slurm node's states
     :header-rows: 1
     :widths: 5, 8
     :file: src/info/node_states.csv

The simplest way to get information about the state of our clusters is
using the commands: ``sinfo`` and ``squeue``. Here we list some useful
examples [1]_ [2]_ [3]_ .

* View information about nodes and partitions and a longer version (``-N``)


  .. code-block:: bash

      $ sinfo
      $ sinfo -N

* Show nodes that are in a specific state.


  .. code-block:: bash

      $ sinfo -t idle
      $ sinfo -t mix
      $ sinfo -t alloc

* Report node state reason (if exists)

  .. code-block:: bash

      $ sinfo -R


* Show queued jobs and long version

  .. code-block:: bash

      $ squeue
      $ squeue -l

  .. note::
       ``squeue`` also includes running jobs.


* Show queued jobs by a specific user. Most of the cases you will need to get information
  about your jobs, using the variable ``$USER`` could be useful.


  .. code-block:: bash

      $ squeue -u $USER
      $ squeue -u pepito77


* Show queued jobs of a specific partition/queue.

  .. code-block:: bash

      $ squeue -p debug
      $ squeue -p bigmem
      $ squeue -p accel

* Show queued jobs that are in a specific state. To know more about the job's state see:
  `What's going on with my job? Getting information about submitted jobs`_

  .. code-block:: bash

      $ squeue -t PD
      $ squeue -t R
      $ squeue -t F
      $ squeue -t PR

* Show detailed information about the node(s)

  .. code-block:: bash

      $ scontrol show node compute-1-25
      $ scontrol show node compute-0-5
      $ scontrol show node debug-0-0

.. note::

   If you need further information, you can always check the command's manual
   ``man squeue``, ``man sinfo``, etc.

What's going on with my job? Getting information about submitted jobs
-------------------------------------------------------------------------
Once your job is queued in a specific partition you may want to know its state.
There some of the Slurm's job states [3]_.

.. csv-table:: Job's states
     :header-rows: 1
     :widths: 5, 8
     :file: src/info/jobs_states.csv

You can check the expected start time of a job(s) base on the actual queue state:

.. code-block:: bash

    $ squeue --start --job 1234
    $ squeue --start -u $USER


You can also check the reason why your job is waiting, usually is displayed by
default in the command ``squeue``. You can also change the output format, thus,
display the field ``reason (%R)`` more clearly.

.. code-block:: bash

    $ squeue -u $USER --format="%j %name %U %R"
    $ squeue --jobid 1234 --format="%j %name %U %R"

.. note::

   Not only pending jobs set the reason field, also failed jobs
   set it, showing its failure message.

.. note::

   You can also use ``sprio`` in order to know the priority of your job(s).
   For further information see ``man sprio``

In the following table [3]_ we describe the most common reasons:

.. csv-table:: Job's reasons
     :header-rows: 1
     :file: src/info/jobs_reasons.csv

.. warning::

  Related with ``QOSMaxCpuPerUserLimit`` Slurm's reason, the maximum number of
  allocated resources at the same time (in specific Memory and CPUs) per user
  differ between clusters:

  * **Apolo:**
        **CPUs:** 96
        **Memory:** 192G

  * **Cronos:**
        **CPUs:** 96
        **Memory:** 384G

  It is important to note that those are policies defined by
  Apolo - Centro de Computación Científica.


Another useful command to show information about recent jobs is:

.. code-block:: bash

    $ scontrol show job 1234

There is an example of its output from :ref:`Apolo II <about_apolo-ii>`.

.. literalinclude:: src/info/scontrol_show_job_ouput
       :language: bash

.. note::

  We also recommend to log in (using ``ssh`` ) into the respective compute node(s)
  of your job and run ``htop`` in order to see if your process(es) are actually
  running in the way you would expect and check if the compute's ``CPU Load``
  is the optimum. To know more about see: :ref:`FAQ <faq-slurm>`


Canceling a job
-------------------
Once your job is submitted, you can do some operations in order to
change its state. Here we list some useful examples [1]_ [4]_  .

* Cancel job 1234

  .. code-block:: bash

      $ scancel 1234

* Cancel only array ID 9 of job array 1234

  .. code-block:: bash

      $ scancel 1234_9

* Cancel all my jobs (without taking care of its state)

  .. code-block:: bash

      $ scancel -u $USER

* Cancel my waiting (``pending`` state) jobs.

  .. code-block:: bash

      $ scancel -u $USER -t pending

* Cancel the jobs queue on a given partition (queue)

  .. code-block:: bash

      $ scancel -p longjobs

* Cancel one or more jobs by name

  .. code-block:: bash

      $ scancel --name MyJobName

* Pause the job 1234

  .. code-block:: bash

      $ scontrol hold 1234

* Resume the job 1234

  .. code-block:: bash

      $ scontrol resume 1234

* Cancel and restart the job 1234

  .. code-block:: bash

      $ scontrol requeue 1234

What happened with my job? Getting information about finished jobs
----------------------------------------------------------------------
Here we are going to explain how to get information about completed jobs
(that are no longer in the queue). Those commands use the Slurm database to
get the information.

.. note::

  By default, these commands only search jobs associated with the cluster you are
  log in, however,  for example, if you want to search a job that was executed on
  :ref:`Cronos <about_cronos>` while you are in a session in
  :ref:`Apolo II <about_apolo-ii>`, you can do it using the argument
  ``-M slurm-cronos``. Other possible options are ``-M slurm-apolo``
  and ``-M all``

* ``sacct``: is used to get general accounting data for all jobs and job steps
  in the Slurm [5]_.

    * In case you remember the ``jobid`` you can use

        .. code-block:: bash

             $ sacct -j1234

    * Get information about today's jobs submitted by a user (or users)

        .. code-block:: bash

             $ sacct -S$(date +'%m/%d/%y') -u $USER

    * Get information about jobs submitted by a user (or users) 1 week ago

        .. code-block:: bash

             $ sacct -S$(date +'%m/%d/%y' --date="1 week ago") -u $USER

    * Get information about the job(s) by its name(s)

        .. code-block:: bash

             $ sacct -S$(date +'%m/%d/%y') --name job_name

   .. note::

      ``-S`` argument is to select eligible jobs in any state after the specified time.
      It is mandatory to search jobs in case that a  ``jobid`` was not specified.
      It supports multiple date formats, see ``man sacct`` to know more about.

References
----------

.. [1] University of Luxembourg (UL) HPC Team (2018). UL HPC Tutorial:
       Advanced scheduling with SLURM. Retrieved 16:45 January 28, 2019 from
       https://ulhpc-tutorials.readthedocs.io/en/latest/scheduling/advanced/
.. [2] SchedMD LLC (2018). Slurm, resource management [sinfo]. Copy of manual text available at
       https://slurm.schedmd.com/sinfo.html. Retrieved 14:24 January 31, 2019
.. [3] SchedMD LLC (2018). Slurm, resource management [squeue]. Copy of manual text available at
       https://slurm.schedmd.com/squeue.html. Retrieved 12:30 February 1, 2019
.. [4] SchedMD LLC (2018). Slurm, resource management [scancel]. Copy of manual text available at
       https://slurm.schedmd.com/sinfo.html.  Retrieved 15:47 January 31, 2019
.. [5] SchedMD LLC (2018). Slurm, resource management [sacct]. Copy of manual text available at
       https://slurm.schedmd.com/sacct.html. Retrieved 8:44 February 4, 2019
