.. _matlab-r2018a-installation:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

.. role:: raw-html(raw)
   :format: html

.. role:: matlab(code)
   :language: matlab

.. sidebar:: Contents

   .. contents::
      :local:

Tested on (Requirements)
------------------------

* **License Manager Server:** Virtual machine (CentOS 7 Minimal (x86_64))
* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
* **MPI:** Intel MPI :math:`\boldsymbol{\ge}` 17.0.1 (Mandatory to use with Infiniband networks)
* **Scheduler:** SLURM :math:`\boldsymbol{\ge}` 16.05.6
* **Application:** MATLAB Client (Optional)
* **Extra Libraries:**

  * libXtst (:ref:`Troubleshooting <matlab-r2018a-installation-troubleshooting>`)


MATLAB Distributed Computing Server (MDCS)
------------------------------------------

This entry described the installation process of MDCS on the cluster and its
integration with the *License Manager*.

#. Get the online installer using your MATLAB account.

#. Send the installation file to the master node on your cluster.

   .. code-block:: bash

      scp matlab_R2018a_glnxa64.zip root@<FQDN>:$installer_path$

#. Follow next steps to run the MATLAB installer.

   #. Unzip and access the installer files.

      .. code-block:: bash

         ssh -X root@<FQDN>
         cd $installer_path$
         mkdir matlab-R2018a
         mv matlab-R2018a matlab_R2018a_glnxa64.zip
         cd matlab-R2018a
         unzip matlab_R2018a_glnxa64.zip

   #. Create the installation directory.

      .. code-block:: bash

         mkdir -p /share/apps/matlab/r2018a


   #. Execute the installer.

      .. code-block:: bash

         ./install

      .. note::

         :ref:`Troubleshooting <matlab-r2018a-installation-troubleshooting>`


   #. Select the installation method (by MATLAB account).

      .. image:: images/installer.png

   #. Accept license agreement (yes).

      .. image:: images/terms.png

   #. Login (username and password).

      .. image:: images/login.png

   #. Select license (MDCE license).

      .. image:: images/select.png

   #. Folder selection (:bash:`/share/apps/matlab/r2018a`).

      .. note::

         Use a shared file system to do an unique installtion across all the
         nodes in the cluster.

         - /share/apps/matlab

      .. image:: images/folder-cluster.png

   #. Products selection (All products except License Manager 11.14.1.2).

      .. note::

         MATLAB recommends install every *Toolbox* available because in this way
         they can be used by MDCE workers.

      .. image:: images/all-products.png

   #. License file (:bash:`/share/apps/matlab/r2018a/etc`).

      .. note::

         Download and upload the modified :bash:`license.dat` file on the
         *License Manager* server to the :bash:`/share/apps/matlab/r2018a/etc`
         directory on the cluster.

         .. code-block:: bash

            mkdir -p /share/apps/matlab/r2018a/etc
            cd /share/apps/matlab/r2018a/etc
            sftp user@<LICENSE_MANAGER_SERVER>
            cd /usr/local/MATLAB/R2018a/etc
            mget license.dat

      .. image:: images/full-license.png

   #. Finish the installation process.

      .. image:: images/process.png

      .. image:: images/compiler.png

      .. image:: images/finish.png

Intregration with SLURM
-----------------------

To integrate the MATLAB client on the cluster to use SLURM as resource manager
you have to follow next steps:

#. Add the MATLAB integration scripts to its MATLAB PATH by placing the
   integration scripts into :bash:`/share/apps/matlab/r2018a/toolbox/local`
   directory (:download:`Apolo II <src/apolo.local.zip>` or
   :download:`Cronos <src/cronos.local.zip>`).

      .. admonition:: Linux

         .. code-block:: bash

            scp apolo.local.zip or cronos.local.zip <user>@cluster:$path/to/file
            mv $path/to/file/matlab-apolo.zip$ /share/apps/matlab/r2018a/toolbox/local
            cd /share/apps/matlab/r2018a/toolbox/local
            unzip apolo.local.zip or cronos.local.zip
            rm apolo.local.zip or cronos.local.zip


#. Open the MATLAB client on the cluster to configure it.

   (If MATLAB client is installed in a system directory, we strongly suggest to
   open it with admin privileges, it is only necessary the first time to
   configure it).

   .. code-block:: bash

      ssh -X username@<master>
      module load matlab/r2018a
      matlab

   .. image:: images/matlab-client.png
      :alt: MATLAB client

#. Add the integrations scripts to the MATLAB PATH

   - Press the **"Set Path"** button

     .. image:: images/set-path.png
        :alt: Set path button

   - Press the **"Add with Subfolders"** button and choose the directory where
     you unzip the integrations scripts and finally press the **"Save"** button:

     - :bash:`/share/apps/matlab/r2018a/toolbox/local/cronos.local \or\ apolo.local`

|

     .. image:: images/subfolders.png
        :alt: Subfolders

|

     .. image:: images/ok-cluster.png
        :alt: Navigate

|

     .. image:: images/save-cluster.png
        :alt: Save changes

|

Configuring Cluster Profiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Open again your MATLAB Client (without admin privilages)

   .. image:: images/matlab-client.png
      :alt: MATLAB client

#. Load the cluster profile and configure it to submit jobs using SLURM via MDCS.

   .. code-block:: matlab

      >> configCluster
      >> % Must set TimeLimit before submitting jobs to Cronos

      >> % e.g. to set the TimeLimit and Partition
      >> c = parcluster('cronos');
      >> c.AdditionalProperties.TimeLimit = '1:00:00';
      >> c.AdditionalProperties.Partition = 'longjobs';
      >> c.saveProfile

#. Custom options

- **TimeLimit** :raw-html:`&rarr;` Set a limit on the total run time of the job
  allocation (more info_).

   - e.g. :matlab:`c.AdditionalProperties.TimeLimit = '3-10:00:00';`

- **AccountName** :raw-html:`&rarr;` Change the default user account on Slurm.

   - e.g. :matlab:`c.AdditionalProperties.AccountName = 'apolo';`

- **ClusterHost** :raw-html:`&rarr;` Another way to change the cluster hostname
  to sumbit jobs.

   - e.g. :matlab:`c.AdditionalProperties.ClusterHost = 'apolo.eafit.edu.co';`

- **EmailAddress** :raw-html:`&rarr;` Get all job notifications by e-mail.

   - e.g. :matlab:`c.AdditionalProperties.EmailAddress = 'apolo@eafit.edu.co';`

- **EmailType** :raw-html:`&rarr;` Get only the desired notifications based on
  `sbatch options <https://slurm.schedmd.com/sbatch.html>`_.

   - e.g. :matlab:`c.AdditionalProperties.EmailType = 'END,TIME_LIMIT_50';`

- **MemUsage** :raw-html:`&rarr;`  Total amount of memory per machine
  (more info_).

   - e.g. :matlab:`c.AdditionalProperties.MemUsage = '5G';`

- **NumGpus** :raw-html:`&rarr;`  Number of GPUs to use in a job (currently the
  maximum possible NumGpus value is two, also if you select this option you have
  to use the *'accel'* partition on :ref:`Apolo II <about_apolo-ii>`).

  - e.g. :matlab:`c.AdditionalProperties.NumGpus = '2';`

- **Partition** :raw-html:`&rarr;` Select the desire partition to submit jobs
  (by default *longjobs* partition will be used)

  - e.g. :matlab:`c.AdditionalProperties.Partition = 'bigmem';`

- **Reservation** :raw-html:`&rarr;` Submit a job into a reservation
  (more info_).

  - e.g. :matlab:`c.AdditionalProperties.Reservation = 'reservationName';`


- **AdditionalSubmitArgs** :raw-html:`&rarr;` Any valid sbatch parameter (raw)
  (more info_)

  - e.g. :matlab:`c.AdditionalProperties.AdditionalSubmitArgs = '--no-requeue';`


.. _info: https://slurm.schedmd.com/sbatch.html



Troubleshooting
---------------

.. _matlab-r2018a-installation-troubleshooting:

#. When you ran the MATLAB installer with the command :bash:`./install`, it
   prints:

   .. code-block:: bash

      Preparing installation files ...
      Installing ...

   Then a small MATLAB window appears and after a while it closes and prints on
   prompt:

   .. code-block:: bash

      Finished

   To solve this problem, you have to find the root cause modifying
   :bash:`$MATLABINSTALLERPATH/bin/glnxa64/install_unix` script to look the
   :bash:`stderror` and understand what is happening.

   - At line *918* change this statement :bash:`eval "$java_cmd 2> /dev/null"`
     to :bash:`eval "$java_cmd"`, by this way you can see the related errors
     launching the MATLAB installer.

     - e.g. missing library *libXtst.so.6*


Module file
-----------

.. literalinclude:: src/r2018a
   :language: tcl
   :caption: :download:`Module file <src/r2018a>`
