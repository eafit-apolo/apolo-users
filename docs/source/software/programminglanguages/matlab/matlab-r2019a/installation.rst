.. _matlab-r2019a-installation:

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
* **MPI:** Intel MPI :math:`\boldsymbol{\ge}` 19.0.4 (Mandatory to use with Infiniband networks)
* **Scheduler:** SLURM :math:`\boldsymbol{\ge}` 18.08.1
* **Application:** MATLAB Client (Optional)
* **Extra Libraries:**

  * libXtst (:ref:`Troubleshooting <matlab-r2019a-installation-troubleshooting>`)

License Manager
---------------
The *License Manager* provides a network license support to allow the usage of
the different MATLAB features on the clusters (Apolo II and Cronos).

In this case we have two types of licenses, the first one is for the MATLAB
Parallel Server and the second one for MATLAB client with
all the toolboxes available.

Next steps will describe the installation and configuration process for the MLM
(MATLAB License Manager based on FlexLM_ [1]_):

.. _FlexLM: https://en.wikipedia.org/wiki/FlexNet_Publisher

#. Get the online installer using your MATLAB account.

#. Send the installation package to the License Manager server (VM).

   .. code-block:: bash

      scp matlab_R2019a_glnxa64.zip root@<FQDN>:$installer_path

#. Follow the next steps to run the MATLAB installer.

   #. Unzip and access the installer files.

      .. code-block:: bash

         ssh -X root@<FQDN>
         cd $installer_path$
         mkdir matlab-R2019a
         mv matlab_R2019a_glnxa64.zip matlab-R2019a
         cd matlab-R2019a
         unzip matlab_R2019a_glnxa64.zip

   #. Execute the installer.

      .. code-block:: bash

         ./install

      .. note::

         :ref:`Troubleshooting <matlab-r2019a-installation-troubleshooting>`

   #. Select the installation method (by MATLAB account).

      .. image:: images/MathWorks_Installer_1.png

   #. Accept license agreement (yes).

      .. image:: images/License_Agreement_2.png

   #. Login (username and password).

      .. image:: images/Log_in_Mathworks_3.png

   #. Select license (Parallel Server license).

      .. image:: images/License_Selection_4.png

   #. Folder selection (/usr/local/MATLAB/R2019a).

      .. image:: images/Folder_Selection_5.png

   #. Products selection (License Manager 11.14.1.2).

      .. image:: images/Product_Selection_LM.png

   #. License file.

      .. note::

         Login to the MATLAB admin account and download the license file
         (*license.lic*) created for the MATLAB Parallel Server (MATLAB Distribuited
         Computing Engine) and upload it
         to the *License Manager* server in the
         :bash:`/usr/local/MATLAB/R2019a/etc` directory.

         :bash:`scp license.lic root@<FQDN>:/usr/local/MATLAB/R2019a/etc`

      .. image:: images/License_File_7.png

   #. Finish the installation process.

#. Configure MLM (FlexLM).

   #. Access the *License Manager* machine via **SSH**.

   #. Create a system user without privileges to run MLM.

      .. code-block:: bash

         # Create a non-root user to launch matlab (security reasons)
         ## -u uid
         ## -d homedir
         ## -r system user
         ## -s shell (no login user)
         useradd -u 110 -c "MDCE" -d /var/tmp -r -s /sbin/nologin matlab

   #. Create the daemon service to execute automatically MLM.


      .. literalinclude:: src/lm-matlab.service
         :language: bash
         :caption: :download:`lm-matlab.service <src/lm-matlab.service>`

   #. Configure MLM ports and firewall on the license manager machine.

      .. note::

         After the installation process, the MLM generates a new license file
         called :bash:`license.dat` on the :bash:`/usr/local/MATLAB/R2019a/etc`
         directory with the information given in :bash:`license.lic` file during the
         installation process and some additional information showing at following.

      - Review the server port (27000) and specify MLM daemon port (53200) at
        the top of the license file
        (:bash:`/usr/local/MATLAB/R2019a/etc/license.dat`)

        .. code-block:: bash

           SERVER <HOSTNAME> <HOSTID> 27000
           DAEMON MLM "/usr/local/MATLAB/R2019a/etc/MLM" port=53200
           ...

        .. warning:: If you do NOT have this file, please create it and add the above mentioned information.

      - Open those ports in License manager machine firewall (CentOS 7).

        .. code-block:: bash

           firewall-cmd --permanent --add-port=53200/tcp
           firewall-cmd --permanent --add-port=27000/tcp

   #. Configure both licenses (Parallel Server and MATLAB client with all the toolboxes).

      - Download the :bash:`license.lic` file related with MATLAB client and its
        toolboxes from the MATLAB administrator account, then open it with a
        text editor to copy all the **INCREMENTS** lines.

      - Append all (MATLAB client and its toolboxes) **INCREMENTS** lines
        (licensed products) to end of the :bash:`license.dat` on the *License
        Manager* server.

        .. code-block:: bash

           SERVER <FQDN> <HOSTID> 27000
           DAEMON MLM "/usr/local/MATLAB/R2019a/etc/MLM" port=53200
           # BEGIN--------------BEGIN--------------BEGIN
           # MathWorks license passcode file.
           # LicenseNo: ########   HostID: ############
           #
           # R2019a
           #
           INCREMENT MATLAB_Distrib_Comp_Engine MLM 39 <END_DATE> <NUM_WORKES> \
           ...
           INCREMENT MATLAB MLM 39 <END_DATE> ##################### \
           ...
           INCREMENT SIMULINK MLM 39 <END_DATE> ##################### \
           ...
           ... continue ...
           ...

   #. Enable and start the daemon.

      .. code-block:: bash

         systemctl enable lm-matlab
         systemctl start  lm-matlab

   #. Check the log file to see if everything works properly.
      :bash:`/var/tmp/lm_TMW.log`

      .. code:: bash

        10:55:13 (lmgrd) -----------------------------------------------
        10:55:13 (lmgrd)   Please Note:
        10:55:13 (lmgrd)
        10:55:13 (lmgrd)   This log is intended for debug purposes only.
        10:55:13 (lmgrd)   In order to capture accurate license
        10:55:13 (lmgrd)   usage data into an organized repository,
        10:55:13 (lmgrd)   please enable report logging. Use Flexera Software LLC's
        10:55:13 (lmgrd)   software license administration  solution,
        10:55:13 (lmgrd)   FlexNet Manager, to  readily gain visibility
        10:55:13 (lmgrd)   into license usage data and to create
        10:55:13 (lmgrd)   insightful reports on critical information like
        10:55:13 (lmgrd)   license availability and usage. FlexNet Manager
        10:55:13 (lmgrd)   can be fully automated to run these reports on
        10:55:13 (lmgrd)   schedule and can be used to track license
        10:55:13 (lmgrd)   servers and usage across a heterogeneous
        10:55:13 (lmgrd)   network of servers including Windows NT, Linux
        10:55:13 (lmgrd)   and UNIX.
        10:55:13 (lmgrd)
        10:55:13 (lmgrd) -----------------------------------------------
        10:55:13 (lmgrd)
        10:55:13 (lmgrd)
        10:55:13 (lmgrd) Server's System Date and Time: Wed Jul 17 2019 10:55:13 -05
        10:55:13 (lmgrd) SLOG: Summary LOG statistics is enabled.
        10:55:13 (lmgrd) FlexNet Licensing (v11.14.1.2 build 208719 x64_lsb) started on <FQDN> (linux) (7/17/2019)
        10:55:13 (lmgrd) Copyright (c) 1988-2017 Flexera Software LLC. All Rights Reserved.
        10:55:13 (lmgrd) World Wide Web:  http://www.flexerasoftware.com
        10:55:13 (lmgrd) License file(s): /var/tmp/lm_TMW.dat
        10:55:13 (lmgrd) lmgrd tcp-port 27000
        10:55:13 (lmgrd) (@lmgrd-SLOG@) ===============================================
        10:55:13 (lmgrd) (@lmgrd-SLOG@) === LMGRD ===
        10:55:13 (lmgrd) (@lmgrd-SLOG@) Start-Date: Wed Jul 17 2019 10:55:13 -05
        10:55:13 (lmgrd) (@lmgrd-SLOG@) PID: 14118
        10:55:13 (lmgrd) (@lmgrd-SLOG@) LMGRD Version: v11.14.1.2 build 208719 x64_lsb ( build 208719 (ipv6))
        10:55:13 (lmgrd) (@lmgrd-SLOG@)
        10:55:13 (lmgrd) (@lmgrd-SLOG@) === Network Info ===
        10:55:13 (lmgrd) (@lmgrd-SLOG@) Listening port: 27000
        10:55:13 (lmgrd) (@lmgrd-SLOG@)
        10:55:13 (lmgrd) (@lmgrd-SLOG@) === Startup Info ===
        10:55:13 (lmgrd) (@lmgrd-SLOG@) Server Configuration: Single Server
        10:55:13 (lmgrd) (@lmgrd-SLOG@) Command-line options used at LS startup: -z -c /var/tmp/lm_TMW.dat
        10:55:13 (lmgrd) (@lmgrd-SLOG@) License file(s) used:  /var/tmp/lm_TMW.dat
        10:55:13 (lmgrd) (@lmgrd-SLOG@) ===============================================
        10:55:13 (lmgrd) Starting vendor daemons ...
        10:55:13 (lmgrd) Using vendor daemon port 53200 specified in license file
        10:55:13 (lmgrd) Started MLM (internet tcp_port 53200 pid 14120)
        10:55:13 (MLM) FlexNet Licensing version v11.14.1.2 build 208719 x64_lsb
        10:55:13 (MLM) SLOG: Summary LOG statistics is enabled.
        10:55:13 (MLM) SLOG: FNPLS-INTERNAL-CKPT1
        10:55:13 (MLM) SLOG: VM Status: 0
        10:55:13 (MLM) Server started on <FQDN> for:	MATLAB_Distrib_Comp_Engine
        10:55:13 (MLM) MATLAB		SIMULINK	MATLAB_5G_Toolbox
        10:55:13 (MLM) AUTOSAR_Blockset Aerospace_Blockset Aerospace_Toolbox
        10:55:13 (MLM) Antenna_Toolbox Audio_System_Toolbox Automated_Driving_Toolbox
        10:55:13 (MLM) Bioinformatics_Toolbox Communication_Toolbox Video_and_Image_Blockset
        10:55:13 (MLM) Control_Toolbox Curve_Fitting_Toolbox Signal_Blocks
        10:55:13 (MLM) Data_Acq_Toolbox Database_Toolbox Datafeed_Toolbox
        10:55:13 (MLM) Neural_Network_Toolbox Econometrics_Toolbox RTW_Embedded_Coder
        10:55:13 (MLM) Filter_Design_HDL_Coder Fin_Instruments_Toolbox Financial_Toolbox
        10:55:13 (MLM) Fixed_Point_Toolbox Fuzzy_Toolbox	GPU_Coder
        10:55:13 (MLM) GADS_Toolbox	Simulink_HDL_Coder EDA_Simulator_Link
        10:55:13 (MLM) Image_Acquisition_Toolbox Image_Toolbox	Instr_Control_Toolbox
        10:55:13 (MLM) LTE_HDL_Toolbox LTE_Toolbox	MATLAB_Coder
        10:55:13 (MLM) MATLAB_Builder_for_Java Compiler	MATLAB_Report_Gen
        10:55:13 (MLM) MAP_Toolbox	Mixed_Signal_Blockset MPC_Toolbox
        10:55:13 (MLM) MBC_Toolbox	OPC_Toolbox	Optimization_Toolbox
        10:55:13 (MLM) Distrib_Computing_Toolbox PDE_Toolbox	Phased_Array_System_Toolbox
        10:55:13 (MLM) Powertrain_Blockset Pred_Maintenance_Toolbox RF_Blockset
        10:55:13 (MLM) RF_Toolbox	Reinforcement_Learn_Toolbox Risk_Management_Toolbox
        10:55:13 (MLM) Robotics_System_Toolbox Robust_Toolbox	Sensor_Fusion_and_Tracking
        10:55:13 (MLM) SerDes_Toolbox	Signal_Toolbox	SimBiology
        10:55:13 (MLM) SimEvents	SimDriveline	Power_System_Blocks
        10:55:13 (MLM) SimHydraulics	SimMechanics	Simscape
        10:55:13 (MLM) Virtual_Reality_Toolbox SL_Verification_Validation Simulink_Code_Inspector
        10:55:13 (MLM) Real-Time_Workshop Simulink_Control_Design Simulink_Coverage
        10:55:13 (MLM) Simulink_Design_Optim Simulink_Design_Verifier Real-Time_Win_Target
        10:55:13 (MLM) Simulink_PLC_Coder XPC_Target	SIMULINK_Report_Gen
        10:55:13 (MLM) Simulink_Requirements Simulink_Test	SoC_Blockset
        10:55:13 (MLM) Excel_Link	Stateflow	Statistics_Toolbox
        10:55:13 (MLM) Symbolic_Toolbox System_Composer Identification_Toolbox
        10:55:13 (MLM) Text_Analytics_Toolbox Trading_Toolbox Vehicle_Dynamics_Blockset
        10:55:13 (MLM) Vehicle_Network_Toolbox Vision_HDL_Toolbox WLAN_System_Toolbox
        10:55:13 (MLM) Wavelet_Toolbox SimElectronics
        10:55:13 (MLM) EXTERNAL FILTERS are OFF
        10:55:14 (lmgrd) MLM using TCP-port 53200
        10:55:14 (MLM) License verification completed successfully.
        10:55:14 (MLM) SLOG: Statistics Log Frequency is 240 minute(s).
        10:55:14 (MLM) SLOG: TS update poll interval is 600 seconds.
        10:55:14 (MLM) SLOG: Activation borrow reclaim percentage is 0.
        10:55:14 (MLM) (@MLM-SLOG@) ===============================================
        10:55:14 (MLM) (@MLM-SLOG@) === Vendor Daemon ===
        10:55:14 (MLM) (@MLM-SLOG@) Vendor daemon: MLM
        10:55:14 (MLM) (@MLM-SLOG@) Start-Date: Wed Jul 17 2019 10:55:14 -05
        10:55:14 (MLM) (@MLM-SLOG@) PID: 14120
        10:55:14 (MLM) (@MLM-SLOG@) VD Version: v11.14.1.2 build 208719 x64_lsb ( build 208719 (ipv6))
        10:55:14 (MLM) (@MLM-SLOG@)
        10:55:14 (MLM) (@MLM-SLOG@) === Startup/Restart Info ===
        10:55:14 (MLM) (@MLM-SLOG@) Options file used: None
        10:55:14 (MLM) (@MLM-SLOG@) Is vendor daemon a CVD: No
        10:55:14 (MLM) (@MLM-SLOG@) Is TS accessed: No
        10:55:14 (MLM) (@MLM-SLOG@) TS accessed for feature load: -NA-
        10:55:14 (MLM) (@MLM-SLOG@) Number of VD restarts since LS startup: 0
        10:55:14 (MLM) (@MLM-SLOG@)
        10:55:14 (MLM) (@MLM-SLOG@) === Network Info ===
        10:55:14 (MLM) (@MLM-SLOG@) Listening port: 53200
        10:55:14 (MLM) (@MLM-SLOG@) Daemon select timeout (in seconds): 1
        10:55:14 (MLM) (@MLM-SLOG@)
        10:55:14 (MLM) (@MLM-SLOG@) === Host Info ===
        10:55:14 (MLM) (@MLM-SLOG@) Host used in license file: <FQDN>
        10:55:14 (MLM) (@MLM-SLOG@) Running on Hypervisor: Not determined - treat as Physical
        10:55:14 (MLM) (@MLM-SLOG@) ===============================================
        ...

   #. After that, the license manager service should run without problems, if
      there is any trouble with the service you can debug this process checking
      the log file (:bash:`/var/tmp/lm_TMW.log`) to understand what is
      happening.

      .. code-block:: bash

         tailf /var/tmp/lm_TMW.log

MATLAB Parallel Server
----------------------

This entry described the installation process of MATLAB Parallel Server on the cluster and its
integration with the *License Manager*.

#. Get the online installer using your MATLAB account.

#. Send the installation file to the master node on your cluster.

   .. code-block:: bash

      scp matlab_R2019a_glnxa64.zip root@<FQDN>:$installer_path$

#. Follow next steps to run the MATLAB installer.

   #. Unzip and access the installer files.

      .. code-block:: bash

         ssh -X root@<FQDN>
         cd $installer_path$
         mkdir matlab-R2019a
         mv matlab_R2019a_glnxa64.zip matlab-R2019a
         cd matlab-R2019a
         unzip matlab_R2019a_glnxa64.zip

   #. Create the installation directory.

      .. code-block:: bash

         mkdir -p /share/apps/matlab/r2019a

   #. Execute the installer.

      .. code-block:: bash

         ./install

      .. note::

         :ref:`Troubleshooting <matlab-r2019a-installation-troubleshooting>`


   #. Select the installation method (by MATLAB account).

      .. image:: images/MathWorks_Installer_1.png

   #. Accept license agreement (yes).

      .. image:: images/License_Agreement_2.png

   #. Login (username and password).

      .. image:: images/Log_in_Mathworks_3.png

   #. Select license (Parallel Server license).

      .. image:: images/License_Selection_4.png

   #. Folder selection (:bash:`/share/common-apps/matlab/r2019a`).

      .. note::

         Use a shared file system to do an unique installation across all the
         nodes and both clusters.

      .. image:: images/Folder_Selection_client.png


   #. Products selection (All products except License Manager 11.14.1.2).

      .. note::

         MATLAB recommends install every *Toolbox* available because in this way
         they can be used by Parallel Server workers.

      .. image:: images/Product_Selection_6.png

   #. License file (:bash:`/share/apps/matlab/r2019a/etc`).

      .. note::

         Download and upload the modified :bash:`license.dat` file on the
         *License Manager* server to the :bash:`/share/apps/matlab/r2019a/etc`
         directory on the cluster.

         .. code-block:: bash

            mkdir -p /share/apps/matlab/r2019a/etc
            cd /share/apps/matlab/r2019a/etc
            sftp user@<LICENSE_MANAGER_SERVER>
            cd /usr/local/MATLAB/R2019a/etc
            mget license.dat

      .. image:: images/License_File_client.png

   #. Wait to finish the installation process.

Intregration with SLURM
-----------------------

To integrate the MATLAB client on the cluster to use SLURM as resource manager
you have to follow next steps:

#. Create a folder called :bash:`cluster.local` in the following path bash:`/share/common-apps/matlab/r2019a/toolbox/local/`.

    .. code-block:: bash

        mkdir /share/common-apps/matlab/r2019a/toolbox/local/cluster.local

#. Copy the MATLAB integration scripts into the above mentioned folder
   (:download:`Scripts <src/cluster.local.R2019a.tar.gz>`).

    .. code-block:: bash

        scp cluster.local.R2019a.tar.gz <user>@<FQDN>:/path/to/file
        mv /path/to/file/cluster.local.R2019a.tar.gz /share/common-apps/matlab/r2019a/toolbox/local/cluster.local
        cd /share/common-apps/matlab/r2019a/toolbox/local/cluster.local
        tar xf cluster.local.R2019a.tar.gz
        rm cluster.local.R2019a.tar.gz

#. Open the MATLAB client on the cluster to configure the paths for the integration scripts.

   .. note:: Add the module file to be able to load MATLAB for the further steps.
             Please refer to :ref:`module_file` section.

   .. warning:: If MATLAB client is installed in a system directory, we strongly suggest to
                open it with admin privileges, it is only necessary the first time to
                configure it.

   .. code-block:: bash

      module load matlab/r2019a
      matlab -nodisplay

   .. code-block:: matlab

      >> addpath(genpath('/share/common-apps/matlab/r2019a/toolbox/local/cluster.local'))
      >> savepath /share/common-apps/matlab/r2019a/toolbox/local/pathdef.m


   .. note:: For more info about the last commands please refer to `MathWorks documentation <https://la.mathworks.com/help/matlab/ref/addpath.html>`_.


Configuring Cluster Profiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Open again your MATLAB Client (without admin privileges)

   .. code-block:: bash

      module load matlab/r2019a
      matlab -nodisplay

#. Load the cluster profile and configure it to submit jobs using SLURM via Parallel Server.

   .. code-block:: matlab

     >> configCluster

        >> % Must set TimeLimit before submitting jobs to
		>> % the cluster.

		>> % i.e. to set the TimeLimit
		>> c = parcluster('cluster R2019a');
		>> c.AdditionalProperties.TimeLimit = '1:00:00';
		>> c.saveProfile

   .. warning:: The :bash:`configCluster` command should be run only the very first time you configure your MATLAB
                client. It is NOT necessary to run the command each time.

#. Custom options

    There are some additional properties you can set in order to get the desired resources with Slurm

    .. code-block:: matlab

        >> c = parcluster()
        >> c.AdditionalProperties

        ans =

          AdditionalProperties with properties:

                     AccountName: ''
            AdditionalSubmitArgs: ''
                    EmailAddress: ''
                       EmailType: ''
                     EnableDebug: 0
                        MemUsage: ''
                       Partition: ''
                    ProcsPerNode: 0
                     Reservation: ''
                       TimeLimit: ''
                         UseSmpd: 0

    - **TimeLimit (mandatory)** :raw-html:`&rarr;` Set a limit on the total run time of the job allocation (more info_).

        - e.g. :matlab:`c.AdditionalProperties.TimeLimit = '3-10:00:00';`

    - **AccountName** :raw-html:`&rarr;` Change the default user account on Slurm.

        - e.g. :matlab:`c.AdditionalProperties.AccountName = 'apolo';`

    - **ClusterHost** :raw-html:`&rarr;` Another way to change the cluster hostname to sumbit jobs.

        - e.g. :matlab:`c.AdditionalProperties.ClusterHost = 'apolo.eafit.edu.co';`

    - **EmailAddress** :raw-html:`&rarr;` Get all job notifications by e-mail.

        - e.g. :matlab:`c.AdditionalProperties.EmailAddress = 'apolo@eafit.edu.co';`

    - **EmailType** :raw-html:`&rarr;` Get only the desired notifications based on
      `sbatch options <https://slurm.schedmd.com/sbatch.html>`_.

        - e.g. :matlab:`c.AdditionalProperties.EmailType = 'END,TIME_LIMIT_50';`

    - **MemUsage** :raw-html:`&rarr;`  Total amount of memory per MATLAB worker (more info_).

        - e.g. :matlab:`c.AdditionalProperties.MemUsage = '5G';`

    - **NumGpus** :raw-html:`&rarr;` Number of GPUs to use in a job (currently the maximum possible NumGpus value is
      two, also if you select this option you have to use the *'accel'* partition on :ref:`Apolo II <about_apolo-ii>`).

        - e.g. :matlab:`c.AdditionalProperties.NumGpus = '2';`

    - **Partition** :raw-html:`&rarr;` Select the desire partition to submit jobs (by default *longjobs* partition will be used)

        - e.g. :matlab:`c.AdditionalProperties.Partition = 'bigmem';`

    - **Reservation** :raw-html:`&rarr;` Submit a job into a reservation (more info_).

        - e.g. :matlab:`c.AdditionalProperties.Reservation = 'reservationName';`

    - **AdditionalSubmitArgs** :raw-html:`&rarr;` Any valid sbatch parameter (raw) (more info_)

        - e.g. :matlab:`c.AdditionalProperties.AdditionalSubmitArgs = '--no-requeue --exclusive';`


    .. _info: https://slurm.schedmd.com/sbatch.html


Troubleshooting
---------------

.. _matlab-r2019a-installation-troubleshooting:

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

.. _module_file:

Module file
-----------

.. literalinclude:: src/r2019a
   :language: tcl
   :caption: :download:`Module file <src/r2019a>`

.. [1] Wikipedia contributors. (2018, April 13). FlexNet Publisher.
       In Wikipedia, The Free Encyclopedia. Retrieved 20:44, July 18, 2018, from
       https://en.wikipedia.org/w/index.php?title=FlexNet_Publisher&oldid=836261861
