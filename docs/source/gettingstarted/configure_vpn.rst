.. _configure_vpn:

Windows and Mac OSX
-------------------
To configure the VPN on Windows and Mac OS X systems, you must follow exactly the same procedure. Here are the steps to
download and configure the VPN client:

#. Open your favorite browser and go to https://leto.eafit.edu.co and log in with your **username** and **password** given by EAFIT or Apolo's staff


    .. image:: images/vpnwin/vpnwin1.png
        :align: center
        :alt: Open your browser


#. Download and install the version of Global Protect client according to your operating system

    .. image:: images/vpnwin/vpnwin2.png
        :align: center
        :alt: Download the proper version

#. Install the Global Protect application

    .. image:: images/vpnwin/vpnwin3.png
        :align: center
        :alt: Install app

#. Choose where to install it, take into account your permissions on the system

    .. image:: images/vpnwin/vpnwin4.png
        :align: center
        :alt: Install app

#. Finish installation

    .. image:: images/vpnwin/vpnwin5.png
        :align: center
        :alt: Install app

#. Close installation

    .. image:: images/8-globalprotect-install.PNG
        :align: center
        :alt: Close Install app

#. Launch the Global Protect application and fill the portal input **Portal** with *leto.eafit.edu.co*

    .. image:: images/vpnwin/vpnwin6.png
        :align: center
        :alt: Configuration of the application

#. Fill the fields with the following information:

    .. image:: images/vpnwin/vpnwin8.png
        :align: center
        :alt: Fill the fields

    - **Username:** The username assigned by the Apolo's system administrator.
    - **Password:** The password used to log in to the clusters.

    .. warning::
        The password sent to your email is one-time password, the first time you login
        to our clusters the system will ask you for changing the password, after that the
        new password will be used to log in to the VPN.

    .. warning::
        Remember your password will expire every three (3) months.

#. Once connected to the VPN, go to the Taskbar as you see in the image

    .. image:: images/vpnwin/vpnwin9.png
        :align: center
        :alt: Connected Taskbar

#. You will see the word Connected as shown in the image

    .. image:: images/vpnwin/vpnwin10.png
        :align: center
        :alt: Connected!

#. You can see some network parameter in the Details tab, go to the menu and click on Configuration

    .. image:: images/vpnwin/vpnwin11.png
        :align: center
        :alt: Details

#. See the network parameters

    .. image:: images/vpnwin/vpnwin12.png
        :align: center
        :alt: Details


.. warning::
    You must login for the next 5 hours or the account will be deactivated.



-----

Linux
-----
.. note::
    Depending on your distribution this procedure could change.

To configure the VPN on Linux, you have to use your package manager to install a Cisco Compatible VPN client. The most
common client is vpnc, which is embedded on a set of scripts. Usually, the package with these scripts is
called :code:`vpnc`.

Connection through a GUI
^^^^^^^^^^^^^^^^^^^^^^^^

If you use Gnome or a Gnome compatible window manager you should install the :code:`network-manager-vpnc-gnome` and :code:`vpnc` packages. If you use KDE or a KDE compatible window manager you'll need to install the :code:`plasma-nm` and :code:`vpnc` packages instead.

.. code-block:: bash
    :emphasize-lines: 9,10,12,13
    :caption: **Tested on Ubuntu 18.04**

    $ sudo apt search vpnc
    [sudo] password for user:
    kvpnc/bionic 0.9.6a-4build1 amd64
    frontend to VPN clients

    kvpnc-dbg/bionic 0.9.6a-4build1 amd64
    frontend to VPN clients - debugging symbols

    network-manager-vpnc/bionic-updates,bionic-security,now 1.2.4-6ubuntu0.1 amd64
    network management framework (VPNC plugin core)

    network-manager-vpnc-gnome/bionic-updates,bionic-security,now 1.2.4-6ubuntu0.1 amd64
    network management framework (VPNC plugin GNOME GUI)

    vpnc/bionic,now 0.5.3r550-3 amd64
    Cisco-compatible VPN client

    vpnc-scripts/bionic,bionic,now 0.1~git20171005-1 all
    Network configuration scripts for VPNC and OpenConnect


.. code-block:: bash

    $ sudo apt install vpnc network-manager-vpnc-gnome


Once the correct package is installed according to your distribution, you can proceed to configure the VPN client.

.. warning::

    It is strongly recommended to log out and log in before to start the following steps because there are some cases where the VPN connection does not
    work until log out or reboot is performed after the package installation.

.. warning::

    The following procedure may vary depending on the package installed. We are going to use the configuration for network-manager-vpnc-gnome
    due this is the most common package on usual Linux distributions.

#. Open the main menu and System Settings.

    .. image:: images/vpnlin/menu.png
        :align: center
        :alt: System Settings

#. Look for Network item and click on the plus symbol to add a new connection.

    .. image:: images/vpnlin/add_vpn.png
        :align: center
        :alt: Add a new connection

#. Choose Import from file...

    .. note:: The VPN file will be provided by the system administrator, please request it before to continue with this guide.

    .. image:: images/vpnlin/choose_import.png
        :align: center
        :alt: Add a new connection

#. Once the file has been imported you just need to add your username and password provided by the administrator. **Note that
   the group password is filled automatically by the imported file**.

    .. image:: images/vpnlin/config_id.png
        :align: center
        :alt: Fill the fields

#. On IPv4 options on the left panel, please add the following route and apply the configuration.

    .. image:: images/vpnlin/config_ipv4.png
        :align: center
        :alt: Advanced configuration

#. Now you can connect to the cluster through the VPN.

    .. image:: images/vpnlin/connected.png
        :align: center
        :alt: Connected

Connect through the terminal
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Troubleshooting
---------------
.. seealso::
    You can find a Global Protect example for windows or mac configuration on the following screencast:

        .. raw:: html

            <iframe align="middle" width="560" height="315" src="https://www.youtube.com/embed/C7LXgZ3hCsQ" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


.. seealso::
    **Issue:** After installing or upgrading the Mac GlobalProtect client, the client never connects and just "spins". 
    
    **Solution:**
    
    1. Click the Apple icon in the upper left hand corner, then click 'System Preferences', then 'Security'.                                             
    
    2. Look for a message at the bottom of the window stating "System software from developer was blocked from loading."  
    
    3. To allow the software to load again, click the Allow button. 
    
    If that doesn't work, try the following: https://docs.paloaltonetworks.com/globalprotect/4-0/globalprotect-agent-user-guide/globalprotect-agent-for-mac/remove-the-globalprotect-enforcer-kernel-extension

.. seealso::
    Sometimes, When you close the mac with the VPN open, there may be problems in re-establishing the connection to the VPN, so it is suggested that you close the program and reopen it.
