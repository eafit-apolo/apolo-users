.. _connect-to-apolo:

Connect to Apolo
================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

The Apolo clusters are only reachable through the Apolo VPN. This guide takes
you from a computer with nothing installed to a terminal on the cluster: first
you connect to the VPN, then you log in with SSH.

Before you start
----------------

- You have your VPN and cluster credentials. If not,
  :ref:`request an account <request-an-account>`.
- You know which cluster your account is on: Apolo II, Apolo 3 or both. If
  you do not know, ask the Apolo staff.

Step 1: Connect to the VPN
--------------------------

#. Install and configure the VPN client for your operating system:

   - **Windows and macOS:** GlobalProtect, with the portal
     ``leto.omega.eafit.edu.co``. Follow :ref:`the Windows and macOS instructions <vpn-windows-macos>`.
   - **Linux:** follow :ref:`the Linux instructions <vpn-linux>`.

#. Open the VPN client and connect with your VPN username and password.

Keep the VPN connected for as long as you work on the cluster, including
while you transfer files.

Step 2: Log in with SSH
-----------------------

Open a terminal (on Windows 10 and later, open **PowerShell**, which
includes the ``ssh`` command) and run the command for your cluster:

.. tab-set::

   .. tab-item:: Apolo 3

      .. code-block:: bash

         ssh <username>@200.12.187.180

   .. tab-item:: Apolo II

      .. code-block:: bash

         ssh <username>@200.12.187.162

Replace ``<username>`` with your cluster username, and type your cluster
password when asked. Nothing appears on the screen while you type the
password; that is normal.

The first time you connect, SSH asks you to confirm the identity of the
cluster:

.. code-block:: text

   Are you sure you want to continue connecting (yes/no/[fingerprint])?

Type ``yes`` and press :kbd:`Enter`. SSH only asks this once per cluster.

When you are logged in, the prompt changes and every command you type runs
on the cluster. To end the session, type ``exit``.

.. tip::

   To avoid typing the address every time, add an entry to the file
   :file:`~/.ssh/config` on your computer:

   .. code-block:: text

      Host apolo3
          HostName 200.12.187.180
          User <username>

   Then connect with ``ssh apolo3``. The same name works with ``scp`` and
   ``rsync``.

If something goes wrong
-----------------------

- **ssh waits a long time and ends with** ``Connection timed out``. The VPN
  is not connected. Connect it and try again.
- **The VPN client does not connect.** See :ref:`VPN troubleshooting <vpn-troubleshooting>`.
- ``Permission denied, please try again.`` The username or password is
  wrong. Check that you are using your **cluster** credentials, not your VPN
  credentials, and the address of the cluster your account is on.

More problems and their solutions are in :ref:`frequent-problems`.

Next step
---------

:ref:`Run your first job <run-your-first-job>`.
