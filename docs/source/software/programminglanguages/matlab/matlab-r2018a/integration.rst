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

#. Add the MATLAB integration scripts to your Matlab path by placing the 
   integration scripts into :bash:`$MATLAB_ROOT/toolbox/local` directory.

      .. admonition:: Linux / macOS
 
         .. code-block:: bash

            mkdir $HOME/matlab-integrations
            cp $path/to/file/matlab-apolo.zip$ $HOME/matlab-integrations
            cd $HOME/matlab-integrations
            unzip matlab-apolo.zip
            rm matlab-apolo.zip


      .. admonition:: Windows

         To-Do

#. Open your Matlab Client with *admin privilages*, if it is installed in a
   system directory (permissions are necessary).

   .. image:: images/matlab-client.png
      :alt: Matlab client

#. Add the integrations scripts to the Matlab PATH

   - Press the **"Set Path"** button

     .. image:: images/set-path.png
        :alt: Set Path button

   - Press the **"Add with Subfolders"** button and choose the directories where
     you decompress the integrations scripts (Apolo II and Cronos) and finally
     press the **"Save"** button:
     
     - :bash:`/home/$USER/matlab-integrations/apolo-ii`
     - :bash:`/home/$USER/matlab-integrations/cronos`
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
  allocation (more info_)..

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

.. code:block:: matlab

   >> configCluster
   Cluster FQDN (i.e. apolo.eafit.edu.co): cronos.eafit.edu.co
   Username on APOLO (e.g. mgomezz): mgomezzul
   ...
   ...
   >> c = parcluster('apolo remote R2018a');
   >> c.AdditionalProperties.TimeLimit = '1:00:00';
   >> c.AdditionalProperties.Partition = 'longjobs';
   >> c.saveProfile

#. To 
Interactive Jobs
""""""""""""""""

#. 

Serial Jobs
"""""""""""

Parallel Jobs
"""""""""""""

     

MDCS_ using APOLO's Matlab client
--------------------------------

Matlab on APOLO
---------------

Unattended Job
^^^^^^^^^^^^^^

Interactive Job
^^^^^^^^^^^^^^^

.. _MDCS: https://la.mathworks.com/products/distriben.html


