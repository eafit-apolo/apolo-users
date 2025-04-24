.. _dmtcp-2.5.2-installation:

.. role:: bash(code)
   :language: bash

.. sidebar:: Contents

   .. contents::
      :depth: 2
      :local:

Tested on (Requirements)
------------------------
* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
* **Scheduler:** SLURM :math:`\boldsymbol{\ge}` 16.05.6
* **Compiler:** GNU GCC :math:`\boldsymbol{\ge}` 4.4.7-11


Build process
-------------
This entry describes the installation process of DMTCP.

#. Get DMTCP latest version from its sourceforge page
   (`page <https://sourceforge.net/projects/dmtcp/files/2.5.2/dmtcp-2.5.2.tar.gz/download>`_)

#. Send the installation package to the master node on your cluster.

   .. code-block:: bash

      scp dmtcp-2.5.2.tar.gz <usename>t@<FQDN>:$installer_path$

#. Unzip and access the installer files.

   .. code-block:: bash

      ssh -X root@<FQDN>
      cd $installer_path$
      tar xf dmtcp-2.5.2.tar.gz

#. Create the installation directory and change its owner to the user that it is
   doing this process.

   .. code-block:: bash

      mkdir -p /share/apps/dmtcp/2.5.2
      chown <username>.<user group> /share/apps/dmtcp/2.5.2

#. Go to DMTCP path and build it with the acording flags presented here.

   .. code-block:: bash

      ./configure \
      --prefix=/share/apps/dmtcp/2.5.2 \
      --build=x86_64-redhat-linux \
      --enable-infiniband-support \
      --enable-pthread-mutex-wrappers
      make && make install

#. After this process, repeat the configure process to install the (**32 Bits**)
   compatibility following these commands.

   .. code-block:: bash

      ./configure \
      --prefix=/share/apps/dmtcp/2.5.2 \
      --build=x86_64-redhat-linux \
      --enable-infiniband-support \
      --enable-pthread-mutex-wrappers \
      --enable-m32
      make clean
      make && make install

#. Change the owner of the installation directory to finish this process.

   .. code-block:: bash

      chown root.root /share/apps/dmtcp/2.5.2

Module file
-----------

.. literalinclude:: src/2.5.2
   :language: tcl
   :caption: :download:`Module file <src/2.5.2>`
