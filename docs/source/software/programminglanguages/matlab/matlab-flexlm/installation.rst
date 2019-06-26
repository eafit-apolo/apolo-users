.. _matlab-flexlm-installation:

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

* **License Manager Server:** FlexNet Licensing v11.14.1.2 build 208719
* **OS base:** Virtual machine (CentOS 7 Minimal (x86_64))

License Manager
---------------
The *License Manager* provides a network license support to allow the usage of
the different MATLAB features on the clusters (Apolo II and Cronos).

In this case we have two types of licenses, the first one is for the MATLAB
Distributed Computing Engine (MDCE) and the second one for MATLAB client with
all the :ref:`toolboxes available <matlab-r2018a-toolboxes>`.

Next steps will describe the installation and configuration process for the MLM
(MATLAB License Manager based on FlexLM_ [1]_):

.. _FlexLM: https://en.wikipedia.org/wiki/FlexNet_Publisher

#. Get the online installer using your MATLAB account.

#. Send the installation package to the License Manager server (VM).

   .. code-block:: bash

      scp matlab_R2018a_glnxa64.zip root@<FQDN>:$installer_path

#. Follow the next steps to run the MATLAB installer.

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

   #. Folder selection (/usr/local/MATLAB/R2018a).

      .. image:: images/folder.png

   #. Products selection (License Manager 11.14.1.2).

      .. image:: images/lm.png

   #. License file.

      .. note::

         Login to the MATLAB admin account and download the license file
         (*license.dat*) created for this feature (MDCE - MATLAB Distributed
         Computign Engine) and upload it to the *License Manager* server in the
         :bash:`/usr/local/MATLAB/R2018a/etc` directory.

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


      .. literalinclude:: src/lm-matlab.service
         :language: bash
         :caption: :download:`lm-matlab.service <src/lm-matlab.service>`

   #. Configure MLM ports and firewall on the license manager machine.

      - Review the server port (27000) and specify MLM daemon port (53200) at
        the top of the license file
        (:bash:`/usr/local/MATLAB/R2018a/etc/license.dat`)

        .. code-block:: bash

           SERVER <HOSTNAME> <HOSTID> 27000
           DAEMON MLM "/usr/local/MATLAB/R2018a/etc/MLM" port=53200
           ...

      - Open those ports in License manager machine firewall (CentOS 7).

        .. code-block:: bash

           firewall-cmd --permanent --add-port=53200/tcp
           firewall-cmd --permanent --add-port=27000/tcp

   #. Configure both licenses (MDCE and MATLAB client with all the toolboxes).

      .. note::

         After the installation process, the MLM generates a new file license
         called *license.dat* on the :bash:`/usr/local/MATLAB/R2018a/etc`
         directory with the information given in *license.lic* file during the
         installation process (MDCE license).

      - Download the :bash:`license.lic` file related with MATLAB client and its
        toolboxes from the MATLAB administrator account, then open it with a
        text editor to copy all the **INCREMENTS** lines.

      - Append all (MATLAB client and its toolboxes) **INCREMENTS** lines
        (licensed products) to end of the :bash:`license.dat` on the *License
        Manager* server.

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

   #. Check the log file to see if everything works properly.
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

   #. After that, the license manager service should run without problems, if
      there is any trouble with the service you can debug this process checking
      the log file (:bash:`/var/tmp/lm_TMW.log`) to understand what is
      happening.

      .. code-block:: bash

         tailf /var/tmp/lm_TMW.log

.. [1] Wikipedia contributors. (2018, April 13). FlexNet Publisher.
       In Wikipedia, The Free Encyclopedia. Retrieved 20:44, July 18, 2018, from
       https://en.wikipedia.org/w/index.php?title=FlexNet_Publisher&oldid=836261861