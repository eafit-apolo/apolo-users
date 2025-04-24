.. blat-36:

.. role:: bash(code)
   :language: bash

BLAT 36
=======

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://genome.ucsc.edu/cgi-bin/hgBlat
- **License:** `Custom license <http://www.kentinformatics.com/>`_
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------
#. To download run:

    .. code-block:: bash

        $ module load intel/19.0.4
        $ wget https://genome-test.gi.ucsc.edu/~kent/src/blatSrc.zip
        $ unzip batSrc.zip && cd blatSrc

    To use the Intel's compiler modify the file :bash:`inc/common.mk`: like this:

    .. code-block:: bash

        CC=icc
        COPT=-O3 -xHost

    Create the makefile's needed directory :bash:`~/bin/x86_64`.

    .. code-block:: bash

        mkdir -p ~/bin/x86_64

    Compile:

    .. code-block:: bash

        make -j6

    Install:

    .. code-block:: bash

        $ sudo mkdir -p /share/apps/blat/36/intel/19.0.4/bin

        # Make sure that the directory ~/bin/x86_64 has only the BLAT's installation
        $ sudo cp -r ~/bin/x86_64/* /share/apps/blat/36/intel/19.0.4/bin

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/36_intel-19.0.4
        :language: bash
        :caption: :download:`36_intel-19.0.4 <src/36_intel-19.0.4>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/blat
        $ sudo mv 36_intel-19.0.4 /share/apps/modules/blat/

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
