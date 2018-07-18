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

      - After that open those ports in the firewall (CentOS 7)

        .. code-block:: bash
 
           firewall-cmd --permanent --add-port=53200/tcp
           firewall-cmd --permanent --add-port=27000/tcp


   #. Enable the daemon and start it
 
      .. code-block:: bash

         systemctl enable lm-matlab
         systemctl start  lm-matlab
 
                                                                                

MDCS
^^^^

