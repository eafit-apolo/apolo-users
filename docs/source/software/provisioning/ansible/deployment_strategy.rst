Overview
------------------------

The proposed architecture aims to provision a system by following the steps below:

#. Run a one-shot script (called bootstrap in this guide)
   to perform an initial setup of the environment required for ansible
   to run properly during and after deployment, followed by the actual
   software's execution.
#. Check the bootstrap log and verify there were no errors and/or
   unexpected behaviors.
#. If errors arose, fix them and re-run the bootstrap script.

bootstrap
---------

By means of a few initial instructions the script should install ansible
in the target system, prepare the environment it requires and
trigger its first run. To further review whether the bootstrap failed
or succeeded, and take apropriate actions, it is strongly recommended to log
the output. Take the following program for example:

.. literalinclude:: src/scripts/bootstrap.sh
   :language: bash
   :linenos:


Wrappers
--------

Ansible launcher
~~~~~~~~~~~~~~~~~~


One-shot playbooks
------------------
