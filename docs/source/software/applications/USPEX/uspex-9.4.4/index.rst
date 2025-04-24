.. uspex-9.4.4:

*****
9.4.4
*****

.. contents:: Table of Contents

Basic information
-----------------
- **Installation Date:** 19/04/2017
- **URL:** http://uspex-team.org/
- **Apolo version:** II
- **License:** open source

Requirements
------------

- Octave 3.4 (recommended), currently use Octave 4.0.3
- python >= 2.7.11

Installation
------------

1. Download the installation medium of the following link https://uspex-team.org/en/uspex/downloads and enter with the credentials provided by Jorge David.

2 .Upload the file **USPEX-9.4.4.tar.gz** to Apollo and perform the following steps:

.. code-block:: bash

    scp USPEX-9.4.4.tar.gz 'USERNAME'@apolo:/home/$USER/apps/uspex/src
    cd /home/$USER/apps/uspex/src
    tar xf USPEX-9.4.4.tar.gz
    cd USPEX-9.4.4
    mkdir -p /share/apps/uspex/9.4.4
    module load octave/4.0.3_intel-2017_update-1 python/2.7.12_intel-2017_update-1
    ./install.sh

- The installation will automatically detect the octave PATH; The installation path for USPEX must be indicated (/share/apps/uspex/9.4.4)

3. The following file contains the Matlab or Octave PATH that will be used, in this case check that it has the path to the octave binary.

- /share/apps/uspex/9.4.4/CODEPATH

4. To "guarantee" the integration with Octave it is necessary to run the following commands:

.. code-block:: bash

    files=$(grep -lR "echo -e" /share/apps/uspex/9.4.4)
    for file in $files; do sed -i -- 's/echo -e/echo/g' $file; done

Module
------

.. code-block:: tcl

    #%Module1.0####################################################################
    ##
    ## module load uspex//share/apps/modules/uspex/9.4.4
    ##
    ## /share/apps/uspex/9.4.4
    ## Written by Mateo Gómez-Zuluaga
    ##

    proc ModulesHelp {} {
        global version modroot
        puts stderr "uspex/9.4.4 - sets the Environment for use USPEX in \
            \n\t\tthe shared directory /share/apps/uspex/9.4.4"
    }

    module-whatis "(Name________) uspex"
    module-whatis "(Version_____) 9.4.4"
    module-whatis "(Compiler____) "
    module-whatis "(System______) x86_64-redhat-linux"
    module-whatis "(Libraries___) "

    # for Tcl script use only
    set         topdir        /share/apps/uspex/9.4.4
    set         version       9.4.4
    set         sys           x86_64-redhat-linux

    conflict uspex

    module load octave/4.0.3_intel-2017_update-1
    module load python/2.7.12_intel-2017_update-1

    prepend-path PATH	$topdir

    setenv       USPEXPATH  /share/apps/uspex/9.4.4/src

Mode of use
-----------

module load uspex/9.4.4

TO-DO

References
----------

- User manual USPEX 9.4.4

Author
------

- Mateo Gómez Zuluaga
