.. _fairhsare-slurm:

.. role:: bash(code)
          :language: bash

.. role:: raw-html(raw)
          :format: html

**Fairshare**
=============

.. contents:: Contents
              :local:

Tested
------

- **Installation date:** 30/04/2021
- **Apolo version:** Apolo Test Environment

Fair-share Factor
-----------------
The fair-share is a penalty policy not implemented in slurm by default, its component to a job's priority influences the order in which a user's queued jobs are scheduled to run based on the portion of the computing resources they have been allocated and the resources their jobs have already consumed. The fair-share factor does not involve a fixed allotment, whereby a user's access to a machine is cut off once that allotment is reached.

Instead, the fair-share factor serves to prioritize queued jobs such that those jobs charging accounts that are under-serviced are scheduled first, while jobs charging accounts that are over-serviced are scheduled when the machine would otherwise go idle.

Slurm's fair-share factor is a floating point number between 0.0 and 1.0 that reflects the shares of a computing resource that a user has been allocated and the amount of computing resources the user's jobs have consumed. The higher the value, the higher is the placement in the queue of jobs waiting to be scheduled.

.. note::

	Computing the fair-share factor requires the installation and operation of the Slurm Accounting Database to provide the assigned shares and the consumed, computing resources described below.

Regenerate the initram on CentOS 8
----------------------------------

In CenOS 8 you need to use the ``dracut`` tool to manage the initram. In order to regenerate and install the ``initram``:

.. code-block:: bash

	dracut --force # This will force the generation and installation when an initram already exists

.. warning::

	Apolo is currently supported by CentOS 6.6, which makes it impossible to use initram.

Plugins
-------
Multifactor Priority Plugin
***************************

The Multi-factor Job Priority plugin provides a very versatile facility for ordering the queue of jobs waiting to be scheduled.

.. note::

	The multi-factor priority plugin is already installed in the Apolo cluster.

Slurm.conf
----------

The slurm.conf file describes general Slurm configuration information. Here we may put the plugins we want to use to manage our cluster resources. In our case we are going to use the ``PriorityWeightFairshare=2000`` in the section ``PriorityType=priority/multifactor``. Equal to 2000 since in the previous configuration of other factors such as ``PriorityWeightPartition`` is equal to 2000, in general all factors should be equal to the same amount.

.. note::

	Fairshare is only supported on CentOS 7 onwards.

.. warning::

	slurmdbd must be restarted when making changes to slurm.conf.

¿How do I configure Slurm Fair Shares?
--------------------------------------

Slurm Fair Sharing can be configured using the sacctmgr tool. The following example illustrates how 50% Fair Sharing between two Users, User1 and User2, can be configured.

#.	The Fairshare of the parent account must be modified.
		.. code-block:: bash

			sacctmgr modify where account=science set fairshare=50

#. 	The Fairshare of the account must be modified.
		.. code-block:: bash

			sacctmgr modify where account=chemistry set fairshare=30

			sacctmgr modify where account=physics set fairshare=20

#. 	Enroll two users into the physics accounts with 0.5 of the resources assigned to each user:
		.. code-block:: bash

			sacctmgr modify where user name=User1 cluster=apolito account=physics fairshare=10

			sacctmgr modify where user name=User2 cluster=apolito account=physics fairshare=10

#.  The fair share configurations can be reviewed for a particular cluster as follows:
		.. code-block:: bash

			sacctmgr list associations cluster=apolito format=Account,Cluster,User,Fairshare


.. note::

	In this case the fairshare has been configured with small values, since it has been tested in Apolo test environment, which has few resources and is used for testing before moving to production, also has the CentOS 8 operating system.

More information
-----------------

 * `Quick Start User Guide <https://slurm.schedmd.com/quickstart.html>`_.
 * `Slurm + tutorial - Software and Environment Module <https://support.ceci-hpc.be/doc/_contents/QuickStart/SubmittingJobs/SlurmTutorial.html>`_
 * `SLURM: Simple Linux Utility for Resource Management <http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.10.6834>`_.

Authors
-------

Bryan López Parra <blopezp@eafit.edu.co>
