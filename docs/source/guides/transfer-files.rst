.. _transfer-files:

Transfer files to and from Apolo
================================

:Authors: Byron Arenilla
:Maintainer: Byron Arenilla
:Last reviewed: 2026-09-28
:Applies to: Apolo II, Apolo 3

This guide shows how to copy files between your computer and your home
directory on the cluster, from the command line or with a graphical program.

Before you start
----------------

- You are connected to the VPN (see :ref:`connect-to-apolo`). File transfers
  use the same connection as SSH, so without the VPN they fail too.
- You know the address of your cluster:

  .. list-table::
     :header-rows: 1

     * - Cluster
       - Address
     * - Apolo 3
       - ``apolo-3.eafit.edu.co``
     * - Apolo II
       - ``apolo.eafit.edu.co``

In the commands below, replace ``<username>`` with your cluster username and
``<cluster-address>`` with the address of your cluster. Run them **on your
computer**, not on the cluster.

Copy a few files with scp
-------------------------

``scp`` works like ``cp``, but one side is on the cluster.

- **From your computer to the cluster** (to your home directory, ``~/``):

  .. code-block:: bash

     scp results.csv <username>@<cluster-address>:~/

- **From the cluster to your computer** (to the current directory, ``.``):

  .. code-block:: bash

     scp <username>@<cluster-address>:~/first-job/first-job-123456.out .

- **A whole directory**, with ``-r``:

  .. code-block:: bash

     scp -r input-data <username>@<cluster-address>:~/project/

Copy large amounts of data with rsync
-------------------------------------

For many files or large files, use ``rsync``. It only copies what changed,
and if the transfer is interrupted, running the same command again continues
where it stopped.

.. code-block:: bash

   rsync -avP input-data/ <username>@<cluster-address>:~/project/input-data/

- ``-a`` keeps the directory structure, permissions and dates.
- ``-v`` lists the files as they are copied.
- ``-P`` shows the progress and keeps partially transferred files, so an
  interrupted transfer can resume.

.. warning::

   The trailing ``/`` matters. ``input-data/`` copies the **contents** of the
   directory; ``input-data`` (without ``/``) copies the directory itself, so
   you would end up with :file:`input-data/input-data`.

Use a graphical program
-----------------------

Any SFTP client works, for example `FileZilla <https://filezilla-project.org/>`_
(Windows, macOS, Linux) or `WinSCP <https://winscp.net/>`_ (Windows). Create
a connection with these settings:

.. list-table::
   :header-rows: 1

   * - Setting
     - Value
   * - Protocol
     - SFTP
   * - Host
     - The address of your cluster
   * - Port
     - ``22``
   * - Username and password
     - Your cluster credentials

Then drag files between the two panels.

If something goes wrong
-----------------------

- ``Connection timed out``: the VPN is not connected.
- ``Permission denied``: check the username, the password and the address of
  the cluster your account is on.
- ``No such file or directory``: check the path. On the cluster side, ``~/``
  is your home directory; on your side, paths are relative to the directory
  where you run the command.

More problems and their solutions are in :ref:`frequent-problems`.
