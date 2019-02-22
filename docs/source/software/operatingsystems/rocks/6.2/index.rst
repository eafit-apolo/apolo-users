.. _rocks6.2-index:

.. role:: bash(code)
   :language: bash

Rocks 6.2
=========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://www.rocksclusters.org/downloads/2015-05-11-download-rocks-6-2-sidewinder.html
- **License:** http://www.rocksclusters.org/docs/licensing.html
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
  , :ref:`Cronos <about_cronos>`

Add NAS Appliance
-----------------
This section describes the required steps in Rocks to add a new NAS system appliance.

.. code-block:: bash

    # The first part will configure an IB interface for the NAS

    rocks add host nas-1 membership='NAS Appliance' cpus=48 rack=0 rank=1
    rocks add host interface nas-1 iface=ib1
    rocks set host interface subnet nas-1 iface=ib1 subnet=mpi-nfs
    rocks set host interface ip nas-1 iface=ib1 ip=<nas ip>
    rocks set host interface mac nas-1 iface=ib1 mac=<mac>
    rocks set host interface module nas-1 iface=ib1 module=ib_ipoib
    rocks set host attr nas-1 arch x86_64
    rocks set host attr nas-1 os linux
    rocks set host attr nas-1 managed false
    rocks set host attr nas-1 kickstartable false
    rocks set host installaction nas-1 action=os
    rocks set host boot nas-1 action=os
    rocks set attr Info_HomeDirSrv nas-1.mpi-nfs
    rocks sync config

    # This second part will configure a second interface for the NAS (admin network)

    rocks add network admin subnet=<subnet ip> netmask=<mask> dnszone=<domain> mtu=1500 servedns=False
    rocks add host interface nas-1 iface=em3
    rocks set host interface mac nas-1 iface=em3 mac=<mac>
    rocks set host interface ip nas-1 iface=em3 ip=<ip>
    rocks set host interface subnet nas-1 iface=em3 subnet=admin

Troubleshooting
----------------
This section is intended to be a quick reference for the most common errors produced in Rocks and its
solutions made by us.

Infiniband
~~~~~~~~~~~

Issue 1: Permanent connected-mode
 If we add the :code:`CONNECTED_MODE=yes` parameter to ib0 interface configuration, it works well but this parameter
 is removed when the command :bash:`rocks sync network` is run, therefore the connected mode is disabled.

 Solution
  There is an official way to enable the connected mode using the parameter :code:`SETIPOIBCM=yes` on
  (/etc/infiniband/openib.conf) file if you are using Mellanox OFED.
