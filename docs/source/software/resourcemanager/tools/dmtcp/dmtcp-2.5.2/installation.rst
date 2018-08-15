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


Build process
-------------

This entry describes the installation process of DMTCP.

1. Get DMTCP latest version from its sourceforge page

2. Send the installation package to the master node on your cluster.

   .. code-block:: bash

      scp dmtcp-2.5.1.tar.bz2 root@<FQDN>:$installer_path$

3. Unzip and access the installer files.

   .. code-block:: bash

      ssh -X root@<FQDN>
      cd $installer_path$
      unzip dmtcp-2.5.1.tar.bz2

4. Create the installation directory.

   .. code-block:: bash

      mkdir -p /share/apps/dmtcp/2.5.2

5. Go to dmtcp path and build it with the acording flags presented here.

   .. code-block:: bash

      ./configure \ 
      --prefix=/share/apps/dmtcp/2.4.8 \ 
      --build=x86_64-redhat-linux \ 
      --enable-unique-checkpoint-filenames \ 
      --enable-infiniband-support \ 
      --enable-pthread-mutex-wrappers
      make && make install

6. After it finishes install the X32 compatibility following these commands.

   .. code-block:: bash

      ./configure \ 
      --prefix=/share/apps/dmtcp/2.4.8 \ 
      --build=x86_64-redhat-linux \ 
      --enable-unique-checkpoint-filenames \ 
      --enable-infiniband-support \ 
      --enable-pthread-mutex-wrappers \
      --enable--m32
      make clean
      make && make install

Module file
-----------

.. literalinclude:: src/2.5.2
   :language: tcl
   :caption: :download:`Module file <src/2.5.2>`
