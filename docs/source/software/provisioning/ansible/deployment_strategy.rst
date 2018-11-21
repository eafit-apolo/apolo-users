Deployment overview
------------------------

#. Run a one-shot script, called bootstrap for simplicity,
   to perform an initial setup required for ansible
   to run properly during and after deployment.
#. Check the bootstrap log and verify there were no errors and/or
   unexpected behaviors.

bootstrap
~~~~~~~~~

The script is meant to install ansible in the target system, prepare
the environment it requires and trigger its first run. By means of a
few initial instructions, it should introduce the rest of the program


Wrappers
--------

run_ansible script
~~~~~~~~~~~~~~~~~~


One-shot playbooks
------------------
