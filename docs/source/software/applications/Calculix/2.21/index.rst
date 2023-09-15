.. _ Calculix-2.21-index:

.. contents:: Table of Contents

*************
Calculix 2.21
*************


- **Installation date:** 01/09/2023
- **URL:** http://www.dhondt.de
- **Apolo version:** Apolo II
- **License:** ACADEMIC LICENSE

Dependencies
------------
- GCC = 9.3.0

Installation
------------

We load the necessary module:

    .. code-block:: bash

        module load gcc/9.3.0

we download and unzip the source code from this repository, this file will help us to compile Calculix easier

    .. code-block:: bash

        mkdir calculix
        cd calculix
        wget https://codeload.github.com/calculix/ccx_prool/zip/refs/heads/master
        unzip master

We enter the folder and edit the makefile

    .. code-block:: bash

        cd ccx_prool-master
        vim Makefile

It should look like this, remember that in line 7 and 9 there must be version 2.21

    .. image:: images/Makefile.png
        :align: center
        :alt: Makefile

We can enter the Calculix folder and delete versions that we don't need, so that only 2.21 remains.

    .. code-block:: bash

        cd CalculiX
        rm -r ccx_2.1* ccx_2.20 ccx_2.8p2 ccx_2.9
        cd ..

Now we compile

    .. code-block:: bash

        make
