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
