.. _gettingstarted-index:

Getting Started
###############

To compute in Apolo it is necessary to take into account several considerations. In this section you will find
the minimum conditions you must meet to be able to compute on the clusters of the center and what is the procedure to do it.

How to apply for computing time on Apolo
========================================

The first contact to evaluate the viability of computing in Apolo is by means of an email to apolo@eafit.edu.co or a
call +57 (4) 2619592. An appointment will be scheduled via physical or virtual to assess the needs of the user.
At Apolo, researchers from the Universidad EAFIT can compute for free. Other universities, academic institutions or
industrial companies can compute, applying costs on the **core-hour**, **gpu-hour** and **TiB-month** basis.

How to estimate time to use on Apolo
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sometimes, it can be difficult to estimate the time it will take to compute, depending on many factors, including the
order of the algorithm, processor clock speed, memory speed and the buses speed that interconnects them. Sometimes it
has to be estimated from experience.

To have a basis on which to estimate the cost of using Apolo, we have a unit known as the **core-hour**. The definition
of this unit is: having **one hour** of computing in a **core at 100% usage**. You should estimate how long it would take
if your work were serial and multiply the **core-hour** price which could be got from a quote writing to
apolo@eafit.edu.co.


Requirements on the software
==============================

The following items describes the ideal technical conditions of the software to compute on Apolo's supercomputers.

#. Scientific Software
#. Linux compatible
#. Already parallel or parallelizable
#. Distributed (Highly recommended)

If you answer affirmatively the previous questions then you are a good candidate to compute in Apolo. The next step is
to schedule an appointment to make the following verifications:

#. Your software is installed and ready to use it or we have to install it.
#. Your software is optimized and configured in a proper way or we have to reconfigure it.
#. You are already trained or need to be guided to use Apolo in a proper way.

Once all this things were analyzed, we can proceed to create the account on the clusters.

Get an account
==============

To use Apolo you will need to have the following items:

    - A VPN account, created by the system administrators. In the following section you will find a tutorial to
      configure the VPN account in different operating systems.
    - An account on Apolo's clusters, created by system administrators, this account is personal and non-transferable.
    - Test if your accounts are working and launch a job!

In order to get an account, you need to send an email to apolo@eafit.edu.co with the following information:

    - User
    - Mail
    - Name
    - Last Name
    - Cell Phone Number
    - Working or Investigation Group
    - Type of user (undergrad, master, phd, research)
    - Main usage of Apolo (CPU, memory, GPU, disk)
    - Operating System of the PC you will use to access to Apolo
    - Applications that you will use in Apolo.
    - Possible times for the introductory meeting

Configure VPN
==============
A Virtual Private Network or VPN is a mechanism that allows to make a secure channel across insecure public networks
like Internet. It creates a cyphered tunnel between your computer and the network segment of Apolo's supercomputers.
The use of VPN is important because it prevents intruders from seeing our users' network traffic and even attacking our
servers. Given these conditions, the use of the VPN is mandatory even though all traffic to and from Apolo is encrypted
by means of the ssh and sftp protocol. The following subsections explains how to configure the Apolo's VPN in your
particular operating system.

.. toctree::
    :maxdepth: 2

    configure_vpn


Educational Resources
=====================

For the scientific computing center it is very important that its users have the right knowledge to make good use of
resources. For this reason, the center offers workshops, conferences, and consulting services on the tools and skills
required in scientific computing. In addition to this, in this section you will find some online resources where you
can find the basic knowledge and skills to make good use of all the resources of the center.

.. toctree::
    :maxdepth: 2

    educational_resources

Apolo User Tools
================

Apolo staff has implemented a repository in GitHub that contains some scripts, tools and aliases to help our users with
some needs they have mainly about the system or SLURM. Also, it is a public repository and users could add new aliases
or commands to it.

.. toctree::
    :maxdepth: 2

    apolo_user_tools

Get Help
========

Always you can get help in all Apolo's related topics. You can call to +57 (4) 2619592 or write an email to
apolo@eafit.edu.co
