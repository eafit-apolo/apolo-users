.. _pyrad:

.. contents:: Table of Contents

********
Pyrad
********

- **Installation date:** 06/02/2012
- **URL:** http://dereneaton.com/software/pyrad/
- **Apolo version:** Apolo II
- **License:** GPLv3

Dependencies
-------------

- python
- numpy
- scipy

Installation
------------

#. First download the tar from the main page

.. code-block:: bash

    $ wget https://github.com/dereneaton/pyrad/archive/3.0.66.tar.gz
    $ tar -zxvf 3.0.66.tar.gz

#. Software config

.. code-block:: bash

    cd pyrad-3.0.66
    module load python/2.7.12_intel-2017_update-1
    conda create -m -n <nombre proyecto> intelpython2_core python=2
    source activate <nombre proyecto>
    python setup.py install


Use mode
----------

.. code-block:: bash

    module load python/2.7.12_intel-2017_update-1
    module load vsearch/2.4.0_gcc-4.9.4
    module load muscle/3.8.31_gcc-4.9.4
    source activate <nombre proyecto>
    python
    >>> import pyrad


References
------------

- http://dereneaton.com/software/pyrad/

Author
------

- Alejandro Salgado Gómez
