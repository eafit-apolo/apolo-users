.. _configure_vpn:

Windows and Mac OSX
-------------------
To configure the VPN on Windows and Mac OS X systems, you must follow exactly the same procedure. Here are the steps
for configuration:

    - Open your favorite browser and enter to https://leto.eafit.edu.co
    - Login with your username and password given by University or system administrator. The external users must login with
      the username and password given by Apolo's system administrators
    - Download and install the version of Global Protect client according your operating system
    - Execute the Global Protect application
    - Accept the Invalid Certificate
    - Fill the fields with the following information:
        - **Portal:** leto.eafit.edu.co
        - **Username:** The username assigned by EAFIT or the System Administrator
        - **Password:** The password of your EAFIT account or the password assigned by the system administrator
    - Once connected to the VPN, you can make ssh and sftp connections to the different clusters of the center.

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
    :caption: Tested on Linux Mint 19

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
    $

Once the correct package is installed according to your distribution, we proceed to configure the VPN client.

.. warning::

    The following procedure may vary depending on the package installed. We are going to use the configuration for network-manager-vpnc-gnome
    due this is the most common package on usual Linux distributions.

#. Open the main menu and System Settings

#. Open the Network Connections in Hardware Section

#.


Troubleshooting
---------------
.. seealso::
    You can find a Global Protect example for windows or mac configuration on the following screencast:

        .. raw:: html

            <iframe align="middle" width="560" height="315" src="https://www.youtube.com/embed/UucKgiEbBrM" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

.. warning::
    Please take in account that you must to use **https** and not **http** protocol to enter in https://leto.eafit.edu.co
