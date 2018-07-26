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


MDCS_ using a local Matlab client
---------------------------------

Integration scripts
^^^^^^^^^^^^^^^^^^^

#. Add the MATLAB integration scripts to your Matlab PATH by placing the
   integration scripts zip file into :bash:`$HOME/Documents/matlab-integration` 
   directory (:download:`matlab-apolo.zip`).

      .. admonition:: Linux
 
         .. code-block:: bash

            mkdir $HOME/matlab-integration
            mv $path/to/file/matlab-apolo.zip$ $HOME/matlab-integrations
            cd $HOME/matlab-integration
            unzip matlab-apolo.zip
            rm matlab-apolo.zip


      .. admonition:: Windows

         To-Do

#. Open your Matlab client (If Matlab client is installed in a system directory, 
   we suggest to open it with admin privileges only for this time to configure it
   ).

   .. image:: images/matlab-client.png
      :alt: Matlab client

#. Add the integrations scripts to the Matlab PATH

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

Configuring Cluster Profiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Open your Matlab Client

   .. image:: images/matlab-client.png
      :alt: Matlab client

#. Configure MATLAB to run parallel jobs on your cluster by calling 
   :matlab:`configCluster`.  

   .. code-block:: matlab

      >> configCluster
      Cluster FQDN (i.e. apolo.eafit.edu.co): cronos.eafit.edu.co
      Username on APOLO (e.g. mgomezz): mgomezzul
      
      >> % Must set TimeLimit before submitting jobs to Apolo II or 
      >> % Cronos cluster
      
      >> % i.e. to set the TimeLimit and Partition
      >> c = parcluster('apolo remote R2018a');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'longjobs';
      >> c.saveProfile
      
      >> % i.e. to set the NumGpus, TimeLimit and Partition
      >> c = parcluster('apolo remote R2018a');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'accel';
      >> c.AdditionalProperties.NumGpus = '2';
      >> c.saveProfile
      

#. Custom options

- **TimeLimit** :raw-html:`&rarr;` Set a limit on the total run time of the job
  allocation (more info_).

   - i.e. :matlab:`c.AdditionalProperties.TimeLimit = '3-10:00:00';`

- **AccountName** :raw-html:`&rarr;` Change the default user account on Slurm.

   - i.e. :matlab:`c.AdditionalProperties.AccountName = 'apolo';`

- **ClusterHost** :raw-html:`&rarr;` Another way to change the cluster hostname 
  to sumbit jobs.

   - i.e. :matlab:`c.AdditionalProperties.ClusterHost = 'apolo.eafit.edu.co';`

- **EmailAddress** :raw-html:`&rarr;` Get all job notifications by e-mail.

   - i.e. :matlab:`c.AdditionalProperties.EmailAddress = 'apolo@eafit.edu.co';`

- **EmailType** :raw-html:`&rarr;` Get only the desired notifications based on 
  `sbatch options <https://slurm.schedmd.com/sbatch.html>`_.

   - i.e. :matlab:`c.AdditionalProperties.EmailType = 'END,TIME_LIMIT_50';`

- **MemUsage** :raw-html:`&rarr;`  Total amount of memory per machine 
  (more info_).

   - i.e. :matlab:`c.AdditionalProperties.MemUsage = '5G';`

- **NumGpus** :raw-html:`&rarr;`  Number of GPUs to use in a job (currently the 
  maximum possible NumGpus value is two, also if you select this option you have
  to use the *'accel'* partition on :ref:`Apolo II <about_apolo-ii>`).

  - i.e. :matlab:`c.AdditionalProperties.NumGpus = '2';`

- **Partition** :raw-html:`&rarr;` Select the desire partition to submit jobs
  (by default *longjobs* partition will be used)
  
  - i.e. :matlab:`c.AdditionalProperties.Partition = 'bigmem';`

- **Reservation** :raw-html:`&rarr;` Submit a job into a reservation 
  (more info_).

  - i.e. :matlab:`c.AdditionalProperties.Reservation = 'reservationName';`


- **AdditionalSubmitArgs** :raw-html:`&rarr;` Any valid sbatch parameter (raw)
  (more info_)

  - i.e. :matlab:`c.AdditionalProperties.AdditionalSubmitArgs = '--no-requeue';`


.. _info: https://slurm.schedmd.com/sbatch.html

Submitting Jobs
^^^^^^^^^^^^^^^

General steps
"""""""""""""

#. Load *'apolo remote R2018a'* cluster profile and load the desired properties 
   to submit a job.

   .. code-block:: matlab
   
      >> % Run cluster configuration
      >> configCluster
      
      Cluster FQDN (i.e. apolo.eafit.edu.co): cronos.eafit.edu.co
      Username on APOLO (e.g. mgomezz): mgomezzul
      
      >> c = parcluster('apolo remote R2018a');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'longjobs';
      >> c.saveProfile
   
#. To see the values of the current configuration options, call the specific 
   AdditionalProperties name.

   .. code-block:: matlab
   
      >> % To view current properties
      >> c.AdditionalProperties
   
#. To clear a value, assign the property an empty value ('', [], or false).

   .. code-block:: matlab
   
      >> % Turn off email notifications 
      >> c.AdditionalProperties.EmailAddress = '';


#. If you have to cancel a job (queued or running) type.

   .. code-block:: matlab

      >> j.cancel

Serial Jobs
"""""""""""

#. Use the batch command to submit asynchronous jobs to the cluster. The batch 
   command will return a job object  which is used to access the output of the 
   submitted job.  (See the MATLAB documentation for more help on batch_.)

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster();
      
      >> % Submit job to query where MATLAB is running on the cluster
      >> j = c.batch(@pwd, 1, {});
      
      >> % Query job for state
      >> j.State
      
      >> % If state is finished, fetch results
      >> j.fetchOutputs{:}
      
      >> % Delete the job after results are no longer needed
      >> j.delete
   
#. To retrieve a list of currently running or completed jobs, call parcluster 
   to retrieve the cluster object.  The cluster object stores an array of jobs 
   that were run, are running, or are queued to run.  This allows us to fetch 
   the results of completed jobs.  Retrieve and view the list of jobs as shown 
   below.

   .. code-block:: matlab

      >> c = parcluster;
      >> jobs = c.Jobs

#. Once we have identified the job we want, we can retrieve the results as 
   we have done previously. *fetchOutputs* is used to retrieve function output 
   arguments; if using batch with a script, use load instead. 
   Data that has been written to files on the cluster needs be retrieved 
   directly from the file system. To view results of a previously completed job:

   .. code-block:: matlab

      >> % Get a handle on job with ID 2
      >> j2 = c.Jobs(2);

   .. note:: 
      
      You can view a list of your jobs, as well as their IDs, using the above 
      :matlab:`c.Jobs` command.  

      .. code-block:: matlab
         >> % Fetch results for job with ID 2
         >> j2.fetchOutputs{:}

   
Parallel or Distributed Jobs
""""""""""""""""""""""""""""

Users can also submit parallel or distributed workflows with batch command.  
Let’s use the following example for a parallel job.

.. literalinclude:: parallel_example.m
   :language: matlab
   :linenos:
   :caption: :download:`parallel_example.m`

     
- We will use the batch command again, but since we are running a parallel job, 
  we will also specify a MATLAB Pool.

   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster();

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
      too many workers (communication), as the overhead may exceed computation 
      time.    

-  We will run the same simulation, but increase the Pool size.  This time, to 
   retrieve the results later, we will keep track of the job ID.


   .. code-block:: matlab

      >> % Get a handle to the cluster
      >> c = parcluster();
      
      >> % Submit a batch pool job using 8 workers
      >> j = c.batch(@parallel_example, 1, {1000}, ‘Pool’, 8);
      
      >> % Get the job ID
      >> id = j.ID
      Id =
      4
      >> % Clear workspace, as though we quit MATLAB
      >> clear j

- Once we have a handle to the cluster, we will call the findJob method to 
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
      
- The job now runs 22.2082 seconds using 8 workers.  Run code with different 
  number of workers to determine the ideal number to use.


Debugging
^^^^^^^^^

#. If a serial job produces an error, we can call the getDebugLog method to view
   the error log file using *j.Tasks(1)*. Additionally  when submitting 
   independent jobs, with multiple tasks, you will have to specify the task 
   number.  

   .. code-block:: matlab

      >> % If necessary, retrieve output/error log file
      >> j.Parent.getDebugLog(j.Tasks(1))



#. For Pool jobs, do not diference into the job object.

   .. code-block:: matlab

      >> % If necessary, retrieve output/error log file
      >> j.Parent.getDebugLog(j)
      >> % or
      >> c.getDebugLog(j)

#. To get information about the job in Slurm, we can consult the scheduler ID 
   by calling schedID
   
   .. code-block:: matlab
 
      >> schedID(j)
         ans =
            25539


MDCS_ using APOLO's Matlab client
--------------------------------

Submitting Jobs
^^^^^^^^^^^^^^^

Using Matlab client on Apolo II or Cronos
"""""""""""""""""""""""""""""""""""""""""

#. Connect to Apolo II or Cronos via SSH.

   .. code-block:: bash
   
      # Without graphical user interface
      ssh username@apolo.eafit.edu.co
      # or with graphical user interface
      ssh -X username@cronos.eafit.edu.co

#. Load Matlab modufile.

   .. code-block:: bash
  
      module load matlab/r2018a

#. Run Matlab client

   .. code-block:: bash

      matlab

#. Load *'apolo'* cluster profile and load the desired properties 
   to submit a job (Matlab GUI or command line).

   .. code-block:: matlab

      >> % Must set TimeLimit before submitting jobs to Apolo II or 
      >> % Cronos cluster
       
      >> % i.e. to set the TimeLimit and Partition
      >> c = parcluster('apolo');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'longjobs'; 
      >> c.saveProfile 
      >> % or	    
      >> % i.e. to set the NumGpus, TimeLimit and Partition 
      >> c = parcluster('apolo'); 
      >> c.AdditionalProperties.TimeLimit = '1:00:00'; 
      >> c.AdditionalProperties.Partition = 'accel'; 
      >> c.AdditionalProperties.NumGpus = '2'; 
      >> c.saveProfile

#. To see the values of the current configuration options, call the specific 
   AdditionalProperties name.

   .. code-block:: matlab
   
      >> % To view current properties
      >> c.AdditionalProperties
   
#. To clear a value, assign the property an empty value ('', [], or false).

   .. code-block:: matlab
   
      >> % Turn off email notifications 
      >> c.AdditionalProperties.EmailAddress = '';


#. If you have to cancel a job (queued or running) type.

   .. code-block:: matlab

      >> j.cancel

Serial Jobs
"""""""""""



Matlab on APOLO
---------------

Unattended Job
^^^^^^^^^^^^^^



Interactive Job
^^^^^^^^^^^^^^^

.. _MDCS: https://la.mathworks.com/products/distriben.html
.. _batch: https://la.mathworks.com/help/distcomp/batch.html
