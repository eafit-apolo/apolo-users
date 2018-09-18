.. _ovftool:

============
**OVF TOOL**
============

**VMware OVF Tool** is an utility that allows the system administrator to package or unpackage virtual machines using the Open Virtualization Format from the command line.

In this entry we will cover the steps needed to package a VM controlled by a VMware host, by connecting to the host from your PC.

.. note::
	You can find official VMware documentation by following `this link`_.
.. _this link: https://www.vmware.com/support/developer/ovf/
	

Installation
------------

Do the following process in your machine.

You need a VMware user account in order to download this tool. Once you are registered you can download this tool from `here`_. 

.. _here: https://my.vmware.com/group/vmware/details?downloadGroup=OVFTOOL430&productId=742


To install on a **linux system**:

1. Give the necessary permissions to the downloaded file:

``$ chmod +x VMware-ovftool-4.0.0-2301625-lin.x86_64.bundle``

2. Execute the file as **root**:

``$ sudo ./VMware-ovftool-4.0.0-2301625-lin.x86_64.bundle``

.. note::
	If you are on Windows or OS X install it the way you normally would.

Create a OVF from a virtual machine
___________________________________ 


1. Find the exact name of the virtual machine that you want to package by using the following command:

``$ ovftool vi://root@<host's-ip>/``

After you enter the root password it will raise an error message like the following::
	
	Error: Found wrong kind of object (ResourcePool). Possible completions are:
	  Virtual-machine1
   	  Virtual-machine2
   	  Virtual-machine3

2. In order to export the virtual machine:

``$ ovftool vi://root@<host's-ip>/<vm_name> <exportFileName>.ovf``

You may be prompted to use the following option: **--allowExtraConfig**. 

``$ ovftool --allowExtraConfig vi://root@<host's-ip>/<vm_name> <exportFileName>.ovf``


.. note::
	Is safe to use "--allowExtraConfig". According to *ovftool* official manpage it specifies "whether we allow ExtraConfig options in white list. These options are safe as we have a white list to filter out the low-level and potential unsafe options on the VM."

