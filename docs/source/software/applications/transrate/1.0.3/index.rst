.. _1.0.3-index:

.. role:: bash(code)
   :language: bash

Transrate 1.0.3
===============

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** http://hibberdlab.com/transrate/
- **License:** MIT License
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
  , :ref:`Cronos <about_cronos>`


Tested on (Requirements)
------------------------

* **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6 (Rocks 6.2)

Installation
------------

The following procedure is the easiest way to install Transrate in a cluster.

#. Download the binaries and unzip the file:

   .. code-block:: bash

         $ mkdir build && cd build
         $ wget https://bintray.com/artifact/download/blahah/generic/transrate-1.0.3-linux-x86_64.tar.gz
         $ tar -xzvf transrate-1.0.3-linux-x86_64.tar.gz



#. Then we add the directory path to the PATH environment variable:

    .. code-block:: bash

        $ cd transrate-1.0.3-linux-x86_64
        $ export PATH=$(pwd):$PATH


#. After, the ruby module is loaded (version 2.6.4)

    .. code-block:: bash

        $ module load ruby/2.6.4p104_intel-19.0.4

#. Now, we proceed to install the dependencies and the application itself:

    .. code-block:: bash

        $ transrate --install-deps all
        $ gem install transrate

#. After the installation is completed you have to create the corresponding module for Transrate 1.0.3

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## modulefile transrate/1.0.3_ruby-2.6.4p104_intel-19.0.4
        ##
        ## Written by Hamilton Tobon Mosquera.

        proc ModulesHelp { } {
            global version modroot
            puts stderr "\ttransrate - Software for de-novo transcriptome assembly \
                        \n\tquality analysis.\n"
        }

        module-whatis "\n\n\tSets the environment for using transrate 1.0.3 ruby gem."

        conflict transrate

        # for Tcl script use only
        set     topdir       ~/.local
        set     version      1.0.3
        set     sys          x86_64-redhat-linux

        module load ruby/2.6.4p104_intel-19.0.4


Running Examples
----------------

This guide will take you through the basic ways of using Transrate. It's worth reading
through once even if you're familiar with running command-line tools, as it provides
guidance about proper selection of input data [1]_ .

Get Some Data
~~~~~~~~~~~~~

If you don't have your own data, you can use our small example dataset to try out the
contig and read-based metrics:

.. code-block:: bash

        $ mkdir example && cd example
        $ wget https://bintray.com/artifact/download/blahah/generic/example_data.tar.gz
        $ tar -xzvf example_data.tar.gz
        $ cd example_data


To continue reviewing the examples worked with this file and the functionality
of transrate check the following link: http://hibberdlab.com/transrate/getting_started.html




References
----------

.. [1] TransRate: reference free quality assessment of de-novo transcriptome assemblies (2016). Richard D Smith-Unna,
       Chris Boursnell, Rob Patro, Julian M Hibberd, Steven Kelly.
       Genome Research doi: http://dx.doi.org/10.1101/gr.196469.115

Authors
-------

- Santiago Hidalgo Ocampo <shidalgoo1@eafit.edu.co>
- Samuel David Palacios <sdpalaciob@eafit.edu.co>
