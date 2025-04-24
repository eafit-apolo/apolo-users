.. _lmod-8.2.7-index:

.. role:: bash(code)
   :language: bash

Lmod 8.2.7
==========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://lmod.readthedocs.io/en/latest/
- **Package's Information:** https://centos.pkgs.org/8/epel-x86_64/Lmod-8.2.7-1.el8.x86_64.rpm.html
- **License:** MIT and LGPLv2
- **Installed on:** Apolo II

Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 8
* **Dependencies to run Lmod:**
    * lua-filesystem
    * lua-posix
    * lua-term
    * coreutils

Installation
------------

The following procedure is the easiest way to install and configure Lmod V8.2.7 in a cluster.

#. Install epel-release package and enable all the necessary repositories (epel and PowerTools for Centos 8) and install Lmod.

    .. code-block:: bash

        $ dnf install epel-release
        $ dnf upgrade -y
        $ dnf --enablerepo=PowerTools,epel install Lmod


#. Now, we will add our custom modulefiles path in the Lmod configuration files.

    With the ``00-modulepath.sh``.

    .. code-block:: bash

        $ cd /etc/profile.d/
        $ nano 00-modulepath.sh

    Go to where it says "export MODULEPATH="

    *  Before the ``|| :`` add the following ``:/share/apps/modules/``
    * Save the file.

    Your file should look like this:

    .. code-block:: bash

        [ -z "$MODULEPATH" ] &&
          [ "$(readlink /etc/alternatives/modules.sh)" = "/usr/share/lmod/lmod/init/profile" -o -f /etc/profile.d/z00_lmod.sh ] &&
          export MODULEPATH=/etc/modulefiles:/usr/share/modulefiles:/share/apps/modules/ || :



    Now, with the ``00-modulepath.csh``.

    .. code-block:: bash

        $ cd /etc/profile.d/
        $ nano 00-modulepath.csh

    Go to where it says "setenv MODULEPATH"

    * Add the following at the end of the line ``:/share/apps/modules/``
    * Save the file.

    Your file should look like this:

    .. code-block:: bash

        if (! $?MODULEPATH && ( `readlink /etc/alternatives/modules.csh` == /usr/share/lmod/lmod/init/cshrc || -f /etc/profile.d/z00_lmod.csh ) ) then
          setenv MODULEPATH /etc/modulefiles:/usr/share/modulefiles:/share/apps/modules/
        endif



    .. note::

        ``/share/apps/modules/`` is our custom location for modules, you need to add in the configuration files your own path.


#. Now, lets configure one last thing, these are the files needed to load pre-defined modules when an user logs into your cluster:

    .. code-block:: bash

        $ cd /etc/profile.d/
        $ nano z01_StdEnv.sh

    Inside the newly created ``z01_StdEnv.sh`` file, add the following:

    .. code-block:: bash

        if [ -z "$__Init_Default_Modules" ]; then
           export __Init_Default_Modules=1;

           ## ability to predefine elsewhere the default list
           LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"StdEnv"}
           export LMOD_SYSTEM_DEFAULT_MODULES
           module --initial_load --no_redirect restore
        else
           module refresh
        fi


    .. code-block:: bash

        $ cd /etc/profile.d/
        $ nano z01_StdEnv.csh

    Inside the newly created ``z01_StdEnv.csh`` file, add the following:

    .. code-block:: bash

        if ( ! $?__Init_Default_Modules )  then
          setenv __Init_Default_Modules 1
          if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
            setenv LMOD_SYSTEM_DEFAULT_MODULES "StdEnv"
          endif
          module --initial_load restore
        else
          module refresh
        endif


#. We create the StdEnv.lua file, which has the modules that we want to load from the beginning. For this example, we will use SLURM and Munge.

    .. code-block:: bash

        $ cd /share/apps/modules
        $ nano StdEnv.lua

    Inside the newly created ``StdEnv.lua`` file, add the following:

    .. code-block:: bash

        load("slurm","munge")



    .. note::

        Make sure you already have the modules created, Lmod supports both lua modulefiles and tcl modulefiles.


Lmod Module hierarchy
---------------------

In this section, we will explain how your modules should be saved in order for Lmod to load them correctly.

#.  First, we go to our custom modulefiles path

    .. code-block:: bash

        $ cd /share/apps/modules
        $ ls
        slurm/ munge/ gcc/ StdEnv.lua

    As you can see, all apps have their own directory.

    .. code-block:: bash

        $ cd slurm/
        $ ls
        20.02.0

    This is a tcl modulefile, the name is the version of the program.

    .. code-block:: bash

        $ cd /share/apps/modules/gcc
        $ ls
        5.4.0.lua

    This is a lua modulefile, as you see, Lmod supports both pretty well.

#. Conclusion, each app needs its own directory (the directory should have the app's name). And inside the directory, the modulefiles' name should be the app's version.

    .. note::

        If you make a lua modulefile, you need to add the file extension ``.lua`` to the modulefile, if it's an tcl modulefile, no file extension is needed.


References
----------

Robert McLay - Lmod: A New Environment Module System.
       Retrieved May 15, 2020, from https://lmod.readthedocs.io/en/latest/

Robert McLay - How to use a Software Module hierarchy.
       Retrieved May 15, 2020, from https://lmod.readthedocs.io/en/latest/080_hierarchy.html

Robert McLay - Converting from TCL/C Environment Modules to Lmod.
       Retrieved May 15, 2020, from https://lmod.readthedocs.io/en/latest/073_tmod_to_lmod.html

Robert McLay - Lua Modulefile Functions.
       Retrieved May 15, 2020, from https://lmod.readthedocs.io/en/latest/050_lua_modulefiles.html

Robert McLay - An Introduction to Writing Modulefiles.
       Retrieved May 15, 2020, from https://lmod.readthedocs.io/en/latest/015_writing_modules.html

Robert McLay - How Lmod Picks which Modulefiles to Load.
       Retrieved May 15, 2020, from https://lmod.readthedocs.io/en/latest/060_locating.html

Robert McLay - Providing A Standard Set Of Modules for all Users.
       Retrieved May 15, 2020, from https://lmod.readthedocs.io/en/latest/070_standard_modules.html

Packages Search for Linux and Unix - Lmod-8.2.7-1.el8.x86_64.rpm.
       Retrieved May 15, 2020, from https://centos.pkgs.org/8/epel-x86_64/Lmod-8.2.7-1.el8.x86_64.rpm.html


:Authors:

- Tomas David Navarro Munera <tdnavarrom@eafit.edu.co>
- Santiago Alzate Cardona <salzatec1@eafit.edu.co>
