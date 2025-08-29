.. _HTSeq-0.10.0:

HTSeq 0.10.0
============

.. contents:: Table of Contents


Basic information
-----------------

- **Instalation date:** 12/07/2018
- **Official Website:** https://htseq.readthedocs.io/en/release_0.10.0/
- **Supercomputer:** Cronos
- **License:** GNU General Public License

Prerequisites
-------------

- Python 2.7, Python 3.4 o superior
- numpy
- Pysam
- matplotlib (Just in case you want to generate graphics)

Installation
------------

1. Charge Conda's environment:

    .. code-block:: bash

        $ conda create --name <envName> python=3.6
        $ source activate <envName>

2. Install numpy in the environment

    .. code-block:: bash

        $ conda install numpy

3. Install Pysam:

    .. code-block:: bash

        $ conda config --add channels r
        $ conda config --add channels bioconda
        $ conda install pysam

4. Download the official HTSeq repository (Source code - tar.gz) [1]_

    .. code-block:: bash

        $ cd /home/mgomezzul/apps/
        $ git clone https://github.com/simon-anders/htseq.git

5. Install HTSeq with the corresponding conda environment active:

    .. code-block:: bash

        $ cd htseq/
        $ python setup.py build
        $ python setup.py install

In this way HTSeq is installed in the Conda environment, and added to the Conda Python path.

Mode of use
-----------

    .. code-block:: bash

        $ source activate <envName>

This will load the Conda environment and the HTSeq routes will be added to the Path.

References
----------

.. [1] https://github.com/simon-anders/htseq

Author
------

Andrés Felipe Zapata Palacio
