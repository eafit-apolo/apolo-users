.. _configure_vpn:

Windows and Mac OSX
-------------------
To configure the VPN on Windows and Mac OS X systems, you must follow exactly the same procedure. Here are the steps to
download and configurate the VPN client:

#. Open your favorite browser and go to https://leto.eafit.edu.co

    .. image:: images/1-browser-leto.PNG
        :align: center
        :alt: Open your browser

#. Accept the not issued certificate

    .. image:: images/2-browser-leto.PNG
        :align: center
        :alt: Access to the not certified web page

#. Login with your **username** and **password** given by EAFIT or Apolo's staff

    .. image:: images/3-browser-leto.PNG
        :align: center
        :alt: Login

#. Download and install the version of Global Protect client according your operating system
    .. image:: images/4-browser-leto.PNG
        :align: center
        :alt: Download the proper version

#. Install the Global Protect application

    .. image:: images/5-globalprotect-install.PNG
        :align: center
        :alt: Install app

#. Choose where to install it, take in account your permissions on the system

    .. image:: images/6-globalprotect-install.PNG
        :align: center
        :alt: Install app

#. Finish installation

    .. image:: images/7-globalprotect-install.PNG
        :align: center
        :alt: Install app

#. Close installation

    .. image:: images/8-globalprotect-install.PNG
        :align: center
        :alt: Close Install app

#. Launch the Global Protect application and fill the portal input **Portal** with *leto.eafit.edu.co*

    .. image:: images/9-globalprotect-conf.PNG
        :align: center
        :alt: Configuration of the application

#. Accept the untrusted certificate

    .. image:: images/10-globalprotect-conf.PNG
        :align: center
        :alt: Accept the invalid certificate

#. Fill the fields with the following information:

    .. image:: images/11-globalprotect-conf.PNG
        :align: center
        :alt: Fill the fields

    - **Portal:** leto.eafit.edu.co
    - **Username:** The username assigned by EAFIT or the System Administrator
    - **Password:** The password of your EAFIT account or the password assigned by the system administrator

#. Once connected to the VPN, you will see the word Connected as showed in the image

    .. image:: images/12-globalprotect-conf.PNG
        :align: center
        :alt: Connected!

#. You can see some network parameter in the Details tab

    .. image:: images/13-globalprotect-conf.PNG
        :align: center
        :alt: Details


Linux
-----
.. note::
    Depending on your distribution this procedure could change.

To configure the VPN on Linux, you have to use your package manager to install a Cisco Compatible VPN client. The most
common client is vpnc, which is embedded on a set of scripts in the package. Usually the package with this scripts is
called `network-manager-vpnc`. If you use Gnome or a Gnome compatible window manager you can install the package
network-manager-vpnc-gnome. If you use KDE or a KDE compatible window manager you can install the package kvpnc.

.. code-block:: bash
    :emphasize-lines: 3,9
    :caption: **Tested on Linux Mint 19**

    $ sudo apt search vpnc
    [sudo] password for user:
    p   kvpnc                             - frontend to VPN clients
    p   kvpnc:i386                        - frontend to VPN clients
    p   kvpnc-dbg                         - frontend to VPN clients - debugging symbols
    p   kvpnc-dbg:i386                    - frontend to VPN clients - debugging symbols
    p   network-manager-vpnc              - network management framework (VPNC plugin core)
    p   network-manager-vpnc:i386         - network management framework (VPNC plugin core)
    p   network-manager-vpnc-gnome        - network management framework (VPNC plugin GNOME GUI)
    p   network-manager-vpnc-gnome:i386   - network management framework (VPNC plugin GNOME GUI)
    p   vpnc                              - Cisco-compatible VPN client
    p   vpnc:i386                         - Cisco-compatible VPN client
    p   vpnc-scripts                      - Network configuration scripts for VPNC and OpenConnect
    $ sudo apt install network-manager-vpnc-gnome

Once the correct package is installed according to your distribution, you can proceed to configure the VPN client.

.. warning::

    The following procedure may vary depending on the package installed. We are going to use the configuration for network-manager-vpnc-gnome
    due this is the most common package on usual Linux distributions.

#. Open the main menu and System Settings

    .. image:: images/systemsettings.png
        :align: center
        :alt: System Settings

#. Look for Network item on Hardware section

    .. image:: images/systemsettingsnetwork.png
        :align: center
        :alt: Look for Network

#. Click on the plus symbol to add a new connection

    .. image:: images/systemsettingsnetworkadd.png
        :align: center
        :alt: Add a new connection

#. Choose Cisco Compatible VPN (vpnc)

    .. image:: images/systemsettingsnetworkchoose.png
        :align: center
        :alt: Add a new connection

#. Configure with the following parameters and later click on advanced

    .. image:: images/systemsettingsnetworkconfig.png
        :align: center
        :alt: Fill the fields

    - **Gateway:** leto.eafit.edu.co
    - **User name:** your username on EAFIT or the given by system administrator
    - **User password:** your given on EAFIT or the given by system administrator
    - **Group name:** Ask for this group name to the system administrator
    - **Group password:** Ask for this group password to the system administrator
    - **Use hybrid authentication:** leave unchecked
    - **CA File:** leave in (None)

#. On advanced options fill the field **Domain** with *eafit.edu.co*

    .. image:: images/systemsettingsnetworkconfigadvanced.png
        :align: center
        :alt: Advanced configuration

#. Now you can connect to the cluster across the VPN

Troubleshooting
---------------
.. seealso::
    You can find a Global Protect example for windows or mac configuration on the following screencast:

        .. raw:: html

            <iframe align="middle" width="560" height="315" src="https://www.youtube.com/embed/UucKgiEbBrM" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

.. warning::
    Please take in account that you must to use **https** and not **http** protocol to enter in https://leto.eafit.edu.co
