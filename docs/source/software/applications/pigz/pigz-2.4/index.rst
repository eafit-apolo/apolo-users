.. pigz-2.4:

Pigz 2.4
========

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://zlib.net/pigz/
- **License:** :download:`Custom license <src/license.txt>`
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`

Installation
------------
#. Run:

    .. code-block:: bash

        $ wget https://zlib.net/pigz/pigz-2.4.tar.gz
        $ tar xvf pigz-2.4.tar.gz
        $ cd pigz-2.4

    The compiler used here is Intel 2019, therefore, modify the makefile like this:

    .. code-block:: bash

        CC=icc
        CXX=icpc
        CFLAGS=-O3 -xHost -ipo -Wall -Wextra -Wno-unknown-pragmas

    Then compile:

    .. code-block:: bash

        $ module load intel/19.0.4
        $ make -j4

    Install it:

    .. code-block:: bash

        $ sudo mkdir -p /share/apps/pigz/2.4/intel/19.0.4/bin
        $ sudo cp pigz unpigz /share/apps/pigz/2.4/intel/19.0.4/bin

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/2.4_intel-19.0.4
        :language: bash
        :caption: :download:`2.4_intel-19.0.4 <src/2.4_intel-19.0.4>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/pigz
        $ sudo mv 2.4_intel-19.0.4 /share/apps/modules/pigz/

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
