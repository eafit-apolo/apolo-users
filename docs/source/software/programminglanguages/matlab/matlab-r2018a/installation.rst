.. _matlab-r2018a-installation:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents
   
   .. contents::
      :local:

Tested on (Requirements)
------------------------

* **License Manager Server:** Virtual machine (CentOS 7 Minimal (x86_64))
* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
* **MPI:** Intel MPI :math:`\boldsymbol{\ge}` 17.0.1 (Mandatory to use with Infiniband networks)
* **Scheduler:** SLURM :math:`\boldsymbol{\ge}` 16.05.6
* **Application:** Matlab Client (Optional)
* **Extra Libraries:**
   
  * libXtst (:ref:`Troubleshooting <matlab-r2018a-installation-troubleshooting>`)



License Manager
---------------
The *License Manager* provides a network license support to allow the access to 
the different Matlab features.

In this case we have two types of licenses, the first one is for the Matlab
Distributed Computing Engine (MDCE) and the second one for Matlab client with 
all the toolboxes available.

Next steps will describe the installation and configuration process for the MLM 
(Matlab License Manager based on FlexLM_ [1]_):

.. _FlexLM: https://en.wikipedia.org/wiki/FlexNet_Publisher

#. Get the online installer using your Matlab account.

#. Send the installation media to the License Manager machine.

   .. code-block:: bash
 
      scp matlab_R2018a_glnxa64.zip root@<FQDN>:$installer_path$

#. Follow the next steps to run the Matlab installer.
   
   #. Unzip and access the installer files.
  
      .. code-block:: bash

         ssh -X root@<FQDN>
         cd $installer_path$
         mkdir matlab-R2018a
         mv matlab-R2018a matlab_R2018a_glnxa64.zip
         cd matlab-R2018a
         unzip matlab_R2018a_glnxa64.zip

   #. Execute the installer.
  
      .. code-block:: bash
    
         ./install

   #. Select the installation method (by Matlab account).

      .. image:: images/installer.png
     
   #. Accept license agreement (yes).
   
      .. image:: images/terms.png

   #. Login (username and password).
  
      .. image:: images/login.png

   #. Select license (MDCE license).

      .. image:: images/select.png

   #. Folder selection (/usr/local/MATLAB/R2018a).

      .. image:: images/folder.png

   #. Products selection (License Manager 11.14.1.2).

      .. image:: images/lm.png

   #. License file.
    
      .. note::

         Login to Matlab admin account and download the license file 
         (*license.dat*) created for this features (MDCE - Matlab Distributed 
         Computign Engine) and upload it to *License Manager* machine in the 
         :bash:`/usr/local/MATLAB/R2018a/etc/license.lic` directory.
          - :bash:`scp license.lic root@<FQDN>:
            /usr/local/MATLAB/R2018a/etc`

      .. image:: images/license.png

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

      :bash:`/etc/systemd/system/lm-matlab.service`

      .. code-block:: bash

         [Unit]
         Description=MATLAB FlexLM license manager

         [Service]
         User=matlab
         RemainAfterExit=True
         ExecStart=/usr/local/MATLAB/R2018a/etc/lmstart
         ExecStop=/usr/local/MATLAB/R2018a/etc/lmdown

         [Install]
         WantedBy=multi-user.target

   #. Configure MLM ports and firewall on the license manager machine.
      
      - Review the server port (27000) and specify MLM daemon port (53200) at 
        the top of the license file 
        (:bash:`/usr/local/MATLAB/R2018a/etc/license.dat`)

        .. code-block:: bash

           SERVER <HOSTNAME> <HOSTID> 27000 
           DAEMON MLM "/usr/local/MATLAB/R2018a/etc/MLM" port=53200
           ...

      - Open those ports in License manager machine's firewall (CentOS 7).

        .. code-block:: bash
 
           firewall-cmd --permanent --add-port=53200/tcp
           firewall-cmd --permanent --add-port=27000/tcp

   #. Configure both licenses (MDCE and Matlab client with all the toolboxes).

      .. note:: 
         
         After the installation process, the MLM generates a new file license
         called *license.dat* on the :bash:`/usr/local/MATLAB/R2018a/etc` 
         directory with the information given in *license.lic* file during the 
         installation process (MDCE license).

      - Download the :bash:`license.lic` file related with Matlab client and its
        toolboxes from the Matlab administrator account, then open it with a 
        text editor to copy all the **INCREMENTS** lines.

      - Append all (Matlab client and its toolboxes) **INCREMENTS** lines 
        (licensed products) to end of the :bash:`license.dat` on the license 
        manager server.

        .. code-block:: bash

           SERVER <FQDN> <HOSTID> 27000 
           DAEMON MLM "/usr/local/MATLAB/R2018a/etc/MLM" port=53200
           # BEGIN--------------BEGIN--------------BEGIN
           # MathWorks license passcode file.
           # LicenseNo: ########   HostID: ############
           #
           # R2018a
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

   #. Check the log to check if everything works properly.
      :bash:`/var/tmp/lm_TMW.log`                                                                          

      .. code:: bash

         8:49:38 (lmgrd) -----------------------------------------------
         8:49:38 (lmgrd)   Please Note:
         8:49:38 (lmgrd)
         8:49:38 (lmgrd)   This log is intended for debug purposes only.
         8:49:38 (lmgrd)   In order to capture accurate license
         8:49:38 (lmgrd)   usage data into an organized repository,
         8:49:38 (lmgrd)   please enable report logging. Use Flexera Software LLC's
         8:49:38 (lmgrd)   software license administration  solution,
         8:49:38 (lmgrd)   FlexNet Manager, to  readily gain visibility
         8:49:38 (lmgrd)   into license usage data and to create
         8:49:38 (lmgrd)   insightful reports on critical information like
         8:49:38 (lmgrd)   license availability and usage. FlexNet Manager
         8:49:38 (lmgrd)   can be fully automated to run these reports on
         8:49:38 (lmgrd)   schedule and can be used to track license
         8:49:38 (lmgrd)   servers and usage across a heterogeneous
         8:49:38 (lmgrd)   network of servers including Windows NT, Linux
         8:49:38 (lmgrd)   and UNIX.
         8:49:38 (lmgrd)
         8:49:38 (lmgrd) -----------------------------------------------
         8:49:38 (lmgrd)
         8:49:38 (lmgrd)
         8:49:38 (lmgrd) Server's System Date and Time: Wed Jul 18 2018 08:49:38 -05
         8:49:38 (lmgrd) SLOG: Summary LOG statistics is enabled.
         8:49:38 (lmgrd) FlexNet Licensing (v11.14.1.2 build 208719 x64_lsb) started on <FQDN> (linux) (7/18/2018)
         8:49:38 (lmgrd) Copyright (c) 1988-2017 Flexera Software LLC. All Rights Reserved.
         8:49:38 (lmgrd) World Wide Web:  http://www.flexerasoftware.com
         8:49:38 (lmgrd) License file(s): /var/tmp/lm_TMW.dat
         8:49:38 (lmgrd) lmgrd tcp-port 27000
         ...
         8:49:38 (lmgrd) (@lmgrd-SLOG@) ===============================================
         8:49:38 (lmgrd) (@lmgrd-SLOG@) === LMGRD ===
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Start-Date: Wed Jul 18 2018 08:49:38 -05
         8:49:38 (lmgrd) (@lmgrd-SLOG@) PID: 19339
         8:49:38 (lmgrd) (@lmgrd-SLOG@) LMGRD Version: v11.14.1.2 build 208719 x64_lsb ( build 208719 (ipv6))
         8:49:38 (lmgrd) (@lmgrd-SLOG@)
         8:49:38 (lmgrd) (@lmgrd-SLOG@) === Network Info ===
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Listening port: 27000
         ...
         8:49:38 (lmgrd) (@lmgrd-SLOG@)
         8:49:38 (lmgrd) (@lmgrd-SLOG@) === Startup Info ===
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Server Configuration: Single Server
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Command-line options used at LS startup: -z -c /var/tmp/lm_TMW.dat
         8:49:38 (lmgrd) (@lmgrd-SLOG@) License file(s) used:  /var/tmp/lm_TMW.dat
         8:49:38 (lmgrd) (@lmgrd-SLOG@) ===============================================
         8:49:38 (lmgrd) Starting vendor daemons ...
         8:49:38 (lmgrd) Using vendor daemon port 53200 specified in license file
         ...
         8:49:38 (lmgrd) Started MLM (internet tcp_port 53200 pid 19341)
         ...
         8:49:38 (MLM) FlexNet Licensing version v11.14.1.2 build 208719 x64_lsb
         8:49:38 (MLM) SLOG: Summary LOG statistics is enabled.
         8:49:38 (MLM) SLOG: FNPLS-INTERNAL-CKPT1
         8:49:38 (MLM) SLOG: VM Status: 0
         ...
         8:49:38 (lmgrd) MLM using TCP-port 53200
         8:49:38 (MLM) License verification completed successfully.
         ...
         8:49:38 (MLM) SLOG: Statistics Log Frequency is 240 minute(s).
         8:49:38 (MLM) SLOG: TS update poll interval is 600 seconds.
         8:49:38 (MLM) SLOG: Activation borrow reclaim percentage is 0.
         8:49:38 (MLM) (@MLM-SLOG@) ===============================================
         8:49:38 (MLM) (@MLM-SLOG@) === Vendor Daemon ===
         8:49:38 (MLM) (@MLM-SLOG@) Vendor daemon: MLM
         8:49:38 (MLM) (@MLM-SLOG@) Start-Date: Wed Jul 18 2018 08:49:38 -05
         8:49:38 (MLM) (@MLM-SLOG@) PID: 19341
         8:49:38 (MLM) (@MLM-SLOG@) VD Version: v11.14.1.2 build 208719 x64_lsb ( build 208719 (ipv6))
         8:49:38 (MLM) (@MLM-SLOG@)
         8:49:38 (MLM) (@MLM-SLOG@) === Startup/Restart Info ===
         8:49:38 (MLM) (@MLM-SLOG@) Options file used: None
         8:49:38 (MLM) (@MLM-SLOG@) Is vendor daemon a CVD: No
         8:49:38 (MLM) (@MLM-SLOG@) Is TS accessed: No
         8:49:38 (MLM) (@MLM-SLOG@) TS accessed for feature load: -NA-
         8:49:38 (MLM) (@MLM-SLOG@) Number of VD restarts since LS startup: 0
         8:49:38 (MLM) (@MLM-SLOG@)
         8:49:38 (MLM) (@MLM-SLOG@) === Network Info ===
         8:49:38 (MLM) (@MLM-SLOG@) Listening port: 53200
         8:49:38 (MLM) (@MLM-SLOG@) Daemon select timeout (in seconds): 1
         8:49:38 (MLM) (@MLM-SLOG@)
         8:49:38 (MLM) (@MLM-SLOG@) === Host Info ===
         8:49:38 (MLM) (@MLM-SLOG@) Host used in license file: <FQDN>
         ...         

   #. After that, the license manager service have to run without problems, if 
      there is a trouble you can debug this process checking the log file 
      (:bash:`/var/tmp/lm_TMW.log`) to get what is happening.

      .. code-block:: bash
  
         tailf /var/tmp/lm_TMW.log
         
Matlab Distributed Computing Server (MDCS)
------------------------------------------

This entry described the installation process of MDCS on the cluster and its
integration with the *License Manager*.

#. Get the online installer using your Matlab account.

#. Send the installation media to the master node on your cluster.

   .. code-block:: bash
 
      scp matlab_R2018a_glnxa64.zip root@<FQDN>:$installer_path$

#. Follow the next steps to run the Matlab installer.
   
   #. Unzip and access the installer files.
  
      .. code-block:: bash

         ssh -X root@<FQDN>
         cd $installer_path$
         mkdir matlab-R2018a
         mv matlab-R2018a matlab_R2018a_glnxa64.zip
         cd matlab-R2018a
         unzip matlab_R2018a_glnxa64.zip

   #. Execute the installer.
  
      .. code-block:: bash
    
         ./install

   #. Select the installation method (by Matlab account).

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
         nodes in the cluster (i.e. /share/apps/matlab).

      .. image:: images/folder-cluster.png

   #. Products selection (All products except License Manager 11.14.1.2).
      
      .. note::
 
         Matlab recommends install each *Toolbox* because it can be used by 
         MDCE workers to run an specific job.

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


Troubleshooting
---------------

.. _matlab-r2018a-installation-troubleshooting:

#. When you ran the Matlab installer with the command :bash:`./install`, it 
   prints:
  
   .. code-block:: bash
     
      Preparing installation files ...
      Installing ...   
  
   Then a small Matlab window appears and after a while it closes and prints:

   .. code-block:: bash

      Finished

   To solve this problem, you have to find the root cause modifying 
   :bash:`$MATLABINSTALLERPATH/bin/glnxa64/install_unix` script to look the 
   :bash:`stderror` and understand what is happening.

   - At line *918* change this statement :bash:`eval "$java_cmd 2> /dev/null"` 
     to :bash:`eval "$java_cmd"`, by this way you can see the related errors 
     launching the Matlab installer (i.e. missing library *libXtst.so.6*).


Module file
-----------

.. code-block:: tcl

   #%Module1.0####################################################################
   ##
   ## module load matlab/r2018a
   ##
   ## /share/apps/modules/matlab/r2018a
   ## Written by Mateo Gómez Zuluaga
   ##
   
   proc ModulesHelp {} {
        global version modroot
        puts stderr "Sets the environment for using Matlab R2018a\
                     \nin the shared directory /share/apps/matlab/r2018a."
   }
   
   module-whatis "(Name________) matlab"
   module-whatis "(Version_____) r2018a"
   module-whatis "(Compilers___) "
   module-whatis "(System______) x86_64-redhat-linux"
   module-whatis "(Libraries___) "
   
   # for Tcl script use only
   set         topdir        /share/apps/matlab/r2018a
   set         version       r2018a
   set         sys           x86_64-redhat-linux
   
   conflict matlab
    
   
   prepend-path              PATH        $topdir/bin
   


.. [1] Wikipedia contributors. (2018, April 13). FlexNet Publisher. 
       In Wikipedia, The Free Encyclopedia. Retrieved 20:44, July 18, 2018, from
       https://en.wikipedia.org/w/index.php?title=FlexNet_Publisher&oldid=836261861
