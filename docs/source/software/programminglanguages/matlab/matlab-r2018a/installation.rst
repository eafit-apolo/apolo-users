.. _matlab-r2018a-installation:

.. highlight:: rst

.. role:: bash(code)
    :language: bash


License Manager
^^^^^^^^^^^^^^^
The *License Manager* provides a network license support to allow the access to 
the different Matalab features.

In this case we have two kind of licenses, the first one is for the Matlab
Distributed Computing Engine and the second one for Matlab client with all the
toolboxes available.

Next steps will describe the installation and configuration process for the MLM 
(Matlab License Manager based on `FlexLM <>`)

#. Get the online installer using your Matlab account

#. Send the installation media to the License Manager machine.

   .. code-block:: bash
 
      scp matlab_R2018a_glnxa64.zip root@lm.apolo.eafit.edu.co:$installer_path$

#. Follow the next steps to run the Matlab installer.
   
   #. Descompress and access the installer files
  
      .. code-block:: bash

         ssh -X root@lm.apolo.eafit.edu.co
         cd $installer_path$
         mkdir matlab-R2018a
         mv matlab-R2018a matlab_R2018a_glnxa64.zip
         cd matlab-R2018a
         unzip matlab_R2018a_glnxa64.zip

   #. Execute the installer
  
      .. code-block:: bash
    
         ./install

   #. Select the installation method (by Matlab account)

      .. image:: images/installer.png
     
   #. Accept license agreement (yes)
   
      .. image:: images/terms.png

   #. Login (username and password)
  
      .. image:: images/login.png

   #. Select license (MDCE license)

      .. image:: images/select.png

   #. Folder selection (/usr/local/MATLAB/R2018a)

      .. image:: images/folder.png

   #. Products selection (License Manager 11.14.1.2)

      .. image:: images/lm.png

   #. License file 
    
      .. note::

         Login to Matlab admin account and download the license file 
         (*license.dat*) created for this features (MDCE - Matlab Distributed 
         Computign Engine) and upload it to *License Manager* machine in the 
         :bash:`/usr/local/MATLAB/R2018a/etc/license.lic` directory.
          - :bash:`scp license.lic root@lm.apolo.eafit.edu.co:
            /usr/local/MATLAB/R2018a/etc`

      .. image:: images/license.png

   #. Finish the installation process
       


#. Configure MLM (FlexLM)

   #. Access the *License Manager* machine via **SSH**.

   #. Create a system user without privilages to run MLM.

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

   #. Configure MLM ports and firewall on the license manager machine
      
      - Review the server port (27000) and specify MLM daemon port (53200) at 
        the top of the license file 
        (:bash:`/usr/local/MATLAB/R2018a/etc/license.dat`)

        .. code-block:: bash

           SERVER <HOSTNAME> <HOSTID> 27000 
           DAEMON MLM "/usr/local/MATLAB/R2018a/etc/MLM" port=53200
           ...

      - Open those ports in License manager machine's firewall (CentOS 7)

        .. code-block:: bash
 
           firewall-cmd --permanent --add-port=53200/tcp
           firewall-cmd --permanent --add-port=27000/tcp


   #. Enable the daemon and start it
 
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
         8:49:38 (lmgrd) FlexNet Licensing (v11.14.1.2 build 208719 x64_lsb) started on lm.apolo.eafit.edu.co (linux) (7/18/2018)
         8:49:38 (lmgrd) Copyright (c) 1988-2017 Flexera Software LLC. All Rights Reserved.
         8:49:38 (lmgrd) World Wide Web:  http://www.flexerasoftware.com
         8:49:38 (lmgrd) License file(s): /var/tmp/lm_TMW.dat
         8:49:38 (lmgrd) lmgrd tcp-port 27000
         8:49:38 (lmgrd) (@lmgrd-SLOG@) ===============================================
         8:49:38 (lmgrd) (@lmgrd-SLOG@) === LMGRD ===
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Start-Date: Wed Jul 18 2018 08:49:38 -05
         8:49:38 (lmgrd) (@lmgrd-SLOG@) PID: 19339
         8:49:38 (lmgrd) (@lmgrd-SLOG@) LMGRD Version: v11.14.1.2 build 208719 x64_lsb ( build 208719 (ipv6))
         8:49:38 (lmgrd) (@lmgrd-SLOG@)
         8:49:38 (lmgrd) (@lmgrd-SLOG@) === Network Info ===
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Listening port: 27000
         8:49:38 (lmgrd) (@lmgrd-SLOG@)
         8:49:38 (lmgrd) (@lmgrd-SLOG@) === Startup Info ===
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Server Configuration: Single Server
         8:49:38 (lmgrd) (@lmgrd-SLOG@) Command-line options used at LS startup: -z -c /var/tmp/lm_TMW.dat
         8:49:38 (lmgrd) (@lmgrd-SLOG@) License file(s) used:  /var/tmp/lm_TMW.dat
         8:49:38 (lmgrd) (@lmgrd-SLOG@) ===============================================
         8:49:38 (lmgrd) Starting vendor daemons ...
         8:49:38 (lmgrd) Using vendor daemon port 53200 specified in license file
         8:49:38 (lmgrd) Started MLM (internet tcp_port 53200 pid 19341)
         8:49:38 (MLM) FlexNet Licensing version v11.14.1.2 build 208719 x64_lsb
         8:49:38 (MLM) SLOG: Summary LOG statistics is enabled.
         8:49:38 (MLM) SLOG: FNPLS-INTERNAL-CKPT1
         8:49:38 (MLM) SLOG: VM Status: 0
         8:49:38 (MLM) Server started on lm.apolo.eafit.edu.co for:      MATLAB_Distrib_Comp_Engine
         8:49:38 (MLM) MATLAB            SIMULINK        PolySpace_Bug_Finder
         8:49:38 (MLM) PolySpace_Bug_Finder_Engine Aerospace_Blockset Aerospace_Toolbox
         8:49:38 (MLM) Antenna_Toolbox Audio_System_Toolbox Automated_Driving_Toolbox
         8:49:38 (MLM) Bioinformatics_Toolbox Communication_Toolbox Video_and_Image_Blockset
         8:49:38 (MLM) Control_Toolbox Curve_Fitting_Toolbox Signal_Blocks
         8:49:38 (MLM) Data_Acq_Toolbox Database_Toolbox Datafeed_Toolbox
         8:49:38 (MLM) Econometrics_Toolbox RTW_Embedded_Coder Filter_Design_HDL_Coder
         8:49:38 (MLM) Fin_Instruments_Toolbox Financial_Toolbox Fixed_Point_Toolbox
         8:49:38 (MLM) Fuzzy_Toolbox     GPU_Coder       GADS_Toolbox
         8:49:38 (MLM) Simulink_HDL_Coder EDA_Simulator_Link Image_Acquisition_Toolbox
         8:49:38 (MLM) Image_Toolbox     Instr_Control_Toolbox LTE_HDL_Toolbox
         8:49:38 (MLM) LTE_Toolbox       MATLAB_Coder    MATLAB_Builder_for_Java
         8:49:38 (MLM) Compiler  MATLAB_Report_Gen MAP_Toolbox
         8:49:38 (MLM) MPC_Toolbox       MBC_Toolbox     Neural_Network_Toolbox
         8:49:38 (MLM) OPC_Toolbox       Optimization_Toolbox Distrib_Computing_Toolbox
         8:49:38 (MLM) PDE_Toolbox       Phased_Array_System_Toolbox PolySpace_Server_C_CPP
         8:49:38 (MLM) Powertrain_Blockset Pred_Maintenance_Toolbox RF_Blockset
         8:49:38 (MLM) RF_Toolbox        Risk_Management_Toolbox Robotics_System_Toolbox
         8:49:38 (MLM) Robust_Toolbox    Signal_Toolbox  SimBiology
         8:49:38 (MLM) SimEvents SimDriveline    SimElectronics
         8:49:38 (MLM) SimHydraulics     SimMechanics    Power_System_Blocks
         8:49:38 (MLM) Simscape  Virtual_Reality_Toolbox SL_Verification_Validation
         8:49:38 (MLM) Simulink_Code_Inspector Real-Time_Workshop Simulink_Control_Design
         8:49:38 (MLM) Simulink_Coverage Simulink_Design_Optim Simulink_Design_Verifier
         8:49:38 (MLM) Real-Time_Win_Target Simulink_PLC_Coder XPC_Target
         8:49:38 (MLM) SIMULINK_Report_Gen Simulink_Requirements Simulink_Test
         8:49:38 (MLM) Excel_Link        Stateflow       Statistics_Toolbox
         8:49:38 (MLM) Symbolic_Toolbox Identification_Toolbox Text_Analytics_Toolbox
         8:49:38 (MLM) Trading_Toolbox Vehicle_Dynamics_Blockset Vehicle_Network_Toolbox
         8:49:38 (MLM) Vision_HDL_Toolbox WLAN_System_Toolbox Wavelet_Toolbox
         8:49:38 (MLM) EXTERNAL FILTERS are OFF
         8:49:38 (lmgrd) MLM using TCP-port 53200
         8:49:38 (MLM) License verification completed successfully.
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
         8:49:38 (MLM) (@MLM-SLOG@) Host used in license file: lm.apolo.eafit.edu.co
         8:49:38 (MLM) (@MLM-SLOG@) Running on Hypervisor: Not determined - treat as Physical
         8:49:38 (MLM) (@MLM-SLOG@) ===============================================
         

         
MDCS
^^^^

