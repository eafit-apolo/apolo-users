.. _matlab-r2018a-integration:

.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: matlab(code)
   :language: matlab

.. role:: raw-html(raw)
   :format: html

**Contents**
============

.. contents::
   :local:
   :depth: 2


MDCS_ using a local MATLAB client
---------------------------------

To submit jobs through a local MATLAB client in Apolo II or Cronos using
`SLURM <https://www.schedmd.com/>`_ follow next steps to got the integration:

Integration scripts
^^^^^^^^^^^^^^^^^^^

#. Add the MATLAB integration scripts to your MATLAB PATH by placing the
   integration scripts into :bash:`$HOME/Documents/matlab-integration`
   directory (:download:`matlab-apolo.zip <src/matlab-apolo.zip>`).

      .. admonition:: Linux

         .. code-block:: bash

            mkdir $HOME/Documents/matlab-integration
            mv path-to-file/matlab-apolo.zip $HOME/matlab-integration/
            cd $HOME/Documents/matlab-integration
            unzip matlab-apolo.zip
            rm matlab-apolo.zip


      .. admonition:: Windows

         To-Do

#. Open your MATLAB client to configure it.

   (If MATLAB client is installed in a system directory, we strongly suggest to
   open it with admin privileges, it is only necessary the first time to
   configure it).

   .. image:: images/matlab-client.png
      :alt: MATLAB client

#. Add the integrations scripts to the MATLAB PATH

   - Press the **"Set Path"** button

     .. image:: images/set-path.png
        :alt: Set path button

   |

   - Press the **"Add with Subfolders"** button and choose the directories where
     you unzip the integrations scripts (Apolo II and Cronos) and finally
     press the **"Save"** button:

     - :bash:`/home/$USER/matlab-integration/apolo`

     |

     .. image:: images/subfolders.png
        :alt: Subfolders

     |

     .. image:: images/ok.png
        :alt: Navigate

     |

     .. image:: images/save.png
        :alt: Save changes

Configuring cluster profiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Open again your MATLAB client (without admin privileges)

   .. image:: images/matlab-client.png
      :alt: MATLAB client

#. Configure MATLAB to run parallel jobs on your cluster by calling
   :matlab:`configCluster`.

   .. code-block:: matlab

      >> configCluster
      Cluster FQDN (e.g. apolo.eafit.edu.co): cronos.eafit.edu.co
      Username on Apolo (e.g. mgomezz): mgomezzul

      >> % Must set TimeLimit before submitting jobs to Apolo II or
      >> % Cronos cluster

      >> % e.g. to set the TimeLimit and Partition
      >> c = parcluster('apolo remote R2018a');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'longjobs';
      >> c.saveProfile

      >> % e.g. to set the NumGpus, TimeLimit and Partition
      >> c = parcluster('apolo remote R2018a');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'accel';
      >> c.AdditionalProperties.NumGpus = 2;
      >> c.saveProfile


#. Custom options

- ``TimeLimit`` :raw-html:`&rarr;` Set a limit on the total run time of the job
  allocation (more info_).

   - e.g. :matlab:`c.AdditionalProperties.TimeLimit = '3-10:00:00';`

- ``AccountName`` :raw-html:`&rarr;` Change the default user account on Slurm.

   - e.g. :matlab:`c.AdditionalProperties.AccountName = 'apolo';`

- ``ClusterHost`` :raw-html:`&rarr;` Another way to change the cluster hostname
  to sumbit jobs.

   - e.g. :matlab:`c.AdditionalProperties.ClusterHost = 'apolo.eafit.edu.co';`

- ``EmailAddress`` :raw-html:`&rarr;` Get all job notifications by e-mail.

   - e.g. :matlab:`c.AdditionalProperties.EmailAddress = 'apolo@eafit.edu.co';`

- ``EmailType`` :raw-html:`&rarr;` Get only the desired notifications based on
  `sbatch options <https://slurm.schedmd.com/sbatch.html>`_.

   - e.g. :matlab:`c.AdditionalProperties.EmailType = 'END,TIME_LIMIT_50';`

- ``MemUsage`` :raw-html:`&rarr;`  Total amount of memory **per machine**
  (more info_).

   - e.g. :matlab:`c.AdditionalProperties.MemUsage = '5G';`

- ``NumGpus`` :raw-html:`&rarr;`  Number of GPUs (double) to use in a job.

   - e.g. :matlab:`c.AdditionalProperties.NumGpus = 2;`

  .. note::

     The maximum value for  ``NumGpus`` is two, also if you select this option
     you should use the *'accel'* partition on :ref:`Apolo II <about_apolo-ii>`.


- ``Partition`` :raw-html:`&rarr;` Select the desire partition to submit jobs
  (by default *longjobs* partition will be used)

   - e.g. :matlab:`c.AdditionalProperties.Partition = 'bigmem';`

- ``Reservation`` :raw-html:`&rarr;` Submit a job into a reservation
  (more info_).

   - e.g. :matlab:`c.AdditionalProperties.Reservation = 'reservationName';`


- ``AdditionalSubmitArgs`` :raw-html:`&rarr;` Any valid sbatch parameter (raw)
  (more info_)

   - e.g. :matlab:`c.AdditionalProperties.AdditionalSubmitArgs = '--no-requeue';`


.. _info: https://slurm.schedmd.com/sbatch.html

Submitting jobs
^^^^^^^^^^^^^^^

General steps
"""""""""""""

#. Load *'apolo remote R2018a'* cluster profile and load the desired properties
   to submit a job.

   .. code-block:: matlab

      >> % Run cluster configuration
      >> configCluster

      Cluster FQDN (e.g. apolo.eafit.edu.co): cronos.eafit.edu.co
      Username on Apolo (e.g. mgomezz): mgomezzul

      >> c = parcluster('apolo remote R2018a');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'longjobs';
      >> c.saveProfile

#. To see the values of the current configuration options, call the specific
   ``AdditionalProperties`` method.

   .. code-block:: matlab

      >> % To view current properties
      >> c.AdditionalProperties

#. To clear a value, assign the property an empty value (``''``,
   ``[]``, or ``false``).

   .. code-block:: matlab

      >> % Turn off email notifications
      >> c.AdditionalProperties.EmailAddress = '';


#. If you have to cancel a job (queued or running) type.

   .. code-block:: matlab

      >> j.cancel

#. Delete a job after results are no longer needed.

   .. code-block:: matlab

      >> j.delete

Serial jobs
"""""""""""

#. Use the batch command to submit asynchronous jobs to the cluster. The batch
   command will return a job object  which is used to access the output of the
   submitted job.

   (See the MATLAB documentation for more help on batch_.)

   .. literalinclude:: src/serial_example.m
      :language: matlab
      :caption: :download:`serial_example.m <src/serial_example.m>`

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Submit job to query where MATLAB is running on the cluster (script)
      >> j = c.batch(@serial_example, 1, {1000});

      >> % Query job for state
      >> j.State

      >> % Load results
      >> j.fetchOutputs{:}

      >> % Delete the job after results are no longer needed
      >> j.delete


#. To retrieve a list of currently running or completed jobs, call ``parcluster``
   to retrieve the cluster object.  The cluster object stores an array of jobs
   that were run, are running, or are queued to run.  This allows us to fetch
   the results of completed jobs.  Retrieve and view the list of jobs as shown
   below.

   .. code-block:: matlab

      >> c = parcluster('apolo remote R2018a');
      >> jobs = c.Jobs

#. Once we have identified the job we want, we can retrieve the results as
   we have done previously. ``fetchOutputs`` is used to retrieve function output
   arguments; if using batch with a script, use ``load`` instead.

   Data that has been written to files on the cluster needs be retrieved
   directly from the file system. To view results of a previously completed job:

   .. code-block:: matlab

      >> % Get a handle on job with ID 2
      >> j2 = c.Jobs(2);
      >> j2.fetchOutputs{:}

   .. note::

      You can view a list of your jobs, as well as their IDs, using the above
      :matlab:`c.Jobs` command.

#. Another example using a MATLAB script.

   .. literalinclude:: src/serial_example_script.m
      :language: matlab
      :caption: :download:`serial_example_script.m <src/serial_example_script.m>`

   - Job submission

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Submit job to query where MATLAB is running on the cluster (script)
      >> j = c.batch('serial_example_script');

      >> % Query job for state
      >> j.State

      >> %Load results into the client workspace
      >> j.load

      >> % Delete the job after results are no longer needed
      >> j.delete

#. Another example using a MATLAB script that supports GPU.

   .. literalinclude:: src/gpu_script.m
      :language: matlab
      :caption: :download:`gpu_script.m <src/gpu_script.m>`

   - Job submission

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Submit job to query where MATLAB is running on the cluster (script)
      >> j = c.batch('gpu_script');

      >> % Query job for state
      >> j.State

#. Another example using Simulink via MATLAB.

   .. literalinclude:: src/parsim_test_script.m
      :language: matlab
      :caption: :download:`parsim_test_script.m <src/parsim_test_script.m>`

   :download:`parsim_test.slx (Simulink model) <src/parsim_test.slx>`

   - Job submission

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Submit job to query where MATLAB is running on the cluster (script)
      >> j = c.batch('parsim_test_script');

      >> % Query job for state
      >> j.State

      >> % Load data to client workspace
      >> j.load

Parallel or distributed jobs
""""""""""""""""""""""""""""

Users can also submit parallel or distributed workflows with batch command.
Let’s use the following example for a parallel job.

.. literalinclude:: src/parallel_example.m
   :language: matlab
   :caption: :download:`parallel_example.m <src/parallel_example.m>`


#. We will use the batch command again, but since we are running a parallel job,
   we will also specify a MATLAB pool.

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Submit a batch pool job using 4 workers
      >> j = c.batch(@parallel_example, 1, {1000}, 'Pool', 4);

      >> % View current job status
      >> j.State

      >> % Fetch the results after a finished state is retrieved
      >> j.fetchOutputs{:}
      ans =
         41.7692

   - The job ran in 41.7692 seconds using 4 workers.

   .. note::

      Note that these jobs will always request N+1 CPU cores, since one worker
      is required to manage the batch job and pool of workers.
      For example, a job that needs eight workers will consume nine CPU cores.

   .. note::

      For some applications, there will be a diminishing return when allocating
      too many workers, as the overhead may exceed computation
      time (communication).

#. We will run the same simulation, but increase the pool size.  This time, to
   retrieve the results later, we will keep track of the job ID.


   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Submit a batch pool job using 8 workers
      >> j = c.batch(@parallel_example, 1, {1000}, ‘Pool’, 8);

      >> % Get the job ID
      >> id = j.ID
      Id =
      4
      >> % Clear workspace, as though we quit MATLAB
      >> clear

#. Once we have a handle to the cluster, we will call the ``findJob`` method to
   search for the job with the specified job ID.

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Find the old job
      >> j = c.findJob(‘ID’, 4);

      >> % Retrieve the state of the job
      >> j.State
      ans
      finished
      >> % Fetch the results
      >> j.fetchOutputs{:}
      ans =
      22.2082

   - The job now runs 22.2082 seconds using 8 workers.

     Run code with different number of workers to determine the ideal number to
     use.

     |
#. Another example using a parallel script.

   .. literalinclude:: src/parallel_example_script.m
      :language: matlab
      :caption: :download:`parallel_example_script.m <src/parallel_example_script.m>`

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster('apolo remote R2018a');

      >> % Submit job to query where MATLAB is running on the cluster (script)
      >> j = c.batch('parallel_example_script', 'Pool', 8);

      >> % Query job for state
      >> j.State

      >> %Load results
      >> j.load

      >> % Delete the job after results are no longer needed
      >> j.delete


Debugging
^^^^^^^^^

#. If a serial job produces an error, we can call the ``getDebugLog`` method to view
   the error log file using *j.Tasks(1)*. Additionally  when submitting
   independent jobs, with multiple tasks, you will have to specify the task
   number.

   .. code-block:: matlab

      >> % If necessary, retrieve output/error log file
      >> j.Parent.getDebugLog(j.Tasks(1))



#. For pool jobs, do not diference into the job object.

   .. code-block:: matlab

      >> % If necessary, retrieve output/error log file
      >> j.Parent.getDebugLog(j)
      >> % or
      >> c.getDebugLog(j)

#. To get information about the job in SLURM, we can consult the scheduler ID
   by calling ``schedID``.

   .. code-block:: matlab

      >> schedID(j)
         ans =
            25539


MDCS_ using cluster's MATLAB client
-----------------------------------

Submitting jobs from within MATLAB client on the cluster
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
General steps
"""""""""""""

#. Connect to Apolo II or Cronos via SSH.

   .. code-block:: bash

      # Without graphical user interface
      ssh username@cronos/apolo.eafit.edu.co
      # or with graphical user interface
      ssh -X username@cronos/apolo.eafit.edu.co

#. Load MATLAB modufile.

   .. code-block:: bash

      module load matlab/r2018a

#. Run MATLAB client

   .. code-block:: bash

      matlab

#. First time, you have to define the cluster profile running the following
   command.

   .. code-block:: matlab

      configCluster

#. Load *'apolo'* or *'cronos'* cluster profile and load the desired properties
   to submit a job (MATLAB GUI or command line).

   .. code-block:: matlab

      >> % Must set TimeLimit before submitting jobs to Apolo II or
      >> % Cronos cluster

      >> % e.g. to set the TimeLimit and Partition
      >> c = parcluster('apolo/cronos');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'longjobs';
      >> c.saveProfile
      >> % or
      >> % e.g. to set the NumGpus, TimeLimit and Partition
      >> c = parcluster('apolo');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'accel';
      >> c.AdditionalProperties.NumGpus = '2';
      >> c.saveProfile

#. To see the values of the current configuration options, call the specific
   ``AdditionalProperties`` method.

   .. code-block:: matlab

      >> % To view current properties
      >> c.AdditionalProperties

#. To clear a value, assign the property an empty value (``''``,
   ``[]``, or ``false``).

   .. code-block:: matlab

      >> % Turn off email notifications
      >> c.AdditionalProperties.EmailAddress = '';


Submitting jobs
"""""""""""""""


.. note::

   Users can submit serial, parallel or distributed jobs with batch command
   as the previous examples.


Submitting jobs directly through SLURM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

MDCS jobs could be submitted directly from the Unix command line through SLURM.


For this, in addition to the MATLAB source, one needs to prepare a MATLAB
submission script with the job specifications.

#. An example is shown below:

   .. literalinclude:: src/matlab_batch.m
      :language: matlab
      :caption: :download:`matlab_batch.m <src/matlab_batch.m>`

   .. literalinclude:: src/parallel_example_slurm.m
      :language: matlab
      :caption: :download:`parallel_example_slurm.m <src/parallel_example_slurm.m>`

#. It is submitted to the queue with help of the following SLURM batch-job
   submission script:

   .. literalinclude:: src/matlab.slurm
      :language: bash
      :caption: :download:`matlab.slurm <src/matlab.slurm>`

#. Job is submitted as usual with:

   .. code-block:: bash

      sbatch matlab.slurm

   .. note::

      This scheme dispatches 2 jobs - one serial that spawns the actual MDCS
      parallel jobs, and another, the actual parallel job.

#. Once submitted, the job can be monitored and managed directly through SLURM

   - :bash:`squeue` command output

     .. image:: images/slurm.png
        :alt: squeue output

#. After the job completes, one can fetch results and delete job object from
   within MATLAB client on the cluster. If program writes directly to disk
   fetching is not necessary.

   .. code-block:: matlab

      >> c = parcluster('apolo');
      >> jobs = c.Jobs
      >> j = c.Jobs(7);
      >> j.fetchOutputs{:};
      >> j.delete;

MATLAB directly on the cluster
------------------------------

Next steps describes how to use MATLAB and its toolboxes without MDCS (workers)
toolbox, but this way has next pros and cons.

- **Pros**

  - No workers limitations

- **Cons**

  - No distributed jobs (Only parallel or serial jobs)

Unattended job
^^^^^^^^^^^^^^
To run unattended jobs on the cluster follow next steps:

#. Connect to Apolo II or Cronos via SSH.

   .. code-block:: bash

      ssh username@cronos.eafit.edu.co

#. Enter to the matlab directory project.

   .. code-block:: bash

      cd ~/test/matlab/slurm

#. Create a SLURM batch-job submission script

   .. literalinclude:: src/slurm.sh
      :language: bash
      :caption: :download:`slurm.sh <src/slurm.sh>`


   .. literalinclude:: src/parallel_example_unattended.m
      :language: matlab
      :caption: :download:`parallel_example_unattended.m <src/parallel_example_unattended.m>`

#. Submit the job.

  .. code-block:: bash

     sbatch slurm.sh

#. Check the :bash:`stdout` file (:bash:`test_matlab_xxxx.out`).

   .. code-block:: matlab

      MATLAB is selecting SOFTWARE OPENGL rendering.

                            < M A T L A B (R) >
                  Copyright 1984-2018 The MathWorks, Inc.
                   R2018a (9.4.0.813654) 64-bit (glnxa64)
                             February 23, 2018


      To get started, type one of these: helpwin, helpdesk, or demo.
      For product information, visit www.mathworks.com.

      >> Starting parallel pool (parpool) using the 'local' profile ...
      connected to 8 workers.
      >> >> >> >> >> >>
      t =

        22.5327

Interactive job (No GUI)
^^^^^^^^^^^^^^^^^^^^^^^^
If it is necessary the user can run interactive jobs  following next steps:

#. Connect to Apolo II or Cronos via SSH.

   .. code-block:: bash

      ssh username@apolo.eafit.edu.co

#. Submit a interactive request to the resource manager

   .. code-block:: bash

      srun -N 1 --ntasks-per-node=2 -t 20:00 -p debug --pty bash
      # If resources are available you get inmediatily a shell in a slave node
      # e.g. compute-0-6
      module load matlab/r2018a
      matlab

   .. code-block:: matlab

       MATLAB is selecting SOFTWARE OPENGL rendering.

                            < M A T L A B (R) >
                  Copyright 1984-2018 The MathWorks, Inc.
                  R2018a (9.4.0.813654) 64-bit (glnxa64)
                             February 23, 2018


       To get started, type one of these: helpwin, helpdesk, or demo.
       For product information, visit www.mathworks.com.

       >> p = parpool(str2num(getenv('SLURM_NTASKS')));
       Starting parallel pool (parpool) using the 'local' profile ...
       >> p.NumWorkers

       ans =

            2

   .. note::

      At this point you have an interactive MATLAB session through the resource
      manager (SLURM), giving you the possibility to test and check different
      MATLAB features.

#. To finish this job, you have to close the MATLAB session and then the bash
   session granted in the slave node.

References
----------

- `Parallel Computing Toolbox <https://www.mathworks.com/products/
  parallel-computing.html>`_

-  `MATLAB Distributed Computing Server <https://la.mathworks.com/products/
   distriben.html>`_

-  "Portions of our documentation contain content originally created by Harvard
   FAS Research Computing and adapted by us under the Creative Commons
   Attribution-NonCommercial 4.0 International License. More information:
   https://rc.fas.harvard.edu/about/attribution/"


.. _MDCS: https://la.mathworks.com/products/distriben.html
.. _batch: https://la.mathworks.com/help/distcomp/batch.html
