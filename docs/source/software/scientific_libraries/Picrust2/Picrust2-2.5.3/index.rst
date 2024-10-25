.. _picrust2-2.5.3:

PICRUSt2 Version 2.5.3
======================

.. contents:: Table of Contents

Basic Information
-----------------

- **Installation Date:** 24/10/2024
- **URL:** https://github.com/picrust/picrust2
- **Apolo Version:** Apolo II or later
- **License:** GNU General Public License v3.0 (GPL-3.0) [1]_

Dependencies
------------

* **Operating System Base:** Rocky Linux 8.10 or later
* **Dependencies Required to Run PICRUSt2:**
    * `biom-format >=2.1.10`
    * `cython`
    * `epa-ng=0.3.8`
    * `dendropy=4.5.2`
    * `gappa >=0.8.0,<=0.8.5`
    * `glpk >=4.65`
    * `h5py >=2.10.0`
    * `hmmer >=3.1b2,<=3.2.1`
    * `jinja2 >=2.11.3`
    * `joblib >=1.0.1`
    * `numpy >=1.19.5`
    * `pandas >=1.1.5`
    * `pytest >=4.4.1`
    * `pytest-cov >=2.6.1`
    * `python >=3.5`
    * `r-base >=3.5.1`
    * `r-castor >=1.7.2`
    * `scipy >=1.2.1`
    * `sepp=4.4.0`

Installation
------------

The following instructions describe the easiest way to install the software PICRUSt2 in a cluster environment. Since PICRUSt2 is written in Python, we will create a conda environment to run it. Below are two methods:

1. **Installing PICRUSt2 from Bioconda (Unrecommended option)**:

   - First, create a new conda environment with Picrust2:

     .. code-block:: bash
     
        conda create -n picrust2_env -c conda-forge -c bioconda picrust2
   
   - Activate the environment:
     
     .. code-block:: bash
     
        conda activate picrust2_env
   
   PICRUSt2 is now ready to use within this environment.

2. **Manual Installation from GitHub using Conda**:
   
   If you prefer to manually install PICRUSt2 from the GitHub repository, follow these steps:

   - Download the source file:

     .. code-block:: bash
     
        wget https://github.com/picrust/picrust2/archive/v2.5.3.tar.gz
        tar xvzf v2.5.3.tar.gz
        cd picrust2-2.5.3/
   
   - Create a new conda environment with the required dependencies:

     .. code-block:: bash
     
        conda env create -f picrust2-env.yaml
        conda activate picrust2-env
   
   - Finally, install PICRUSt2 using pip. Make sure you are in the `picrust2-2.5.3` directory:

     .. code-block:: bash
     
        pip install --editable .

Module File
-----------

Since there are no compiled files, it is not necessary to create a module file for this software.

Test Suite
-----

To test the installation, you can run the following command, (you need to clone the repository and make sure you are in the `picrust2-2.5.3` directory, the test cases are in the `tests` directory, pytest will be able if you have installed picrust2 with the second method):

.. code-block:: bash

   pytest

Another option is activate the conda environment and run an specific test, for example:

.. code-block:: bash

   python tests/test_metagenome_pipeline.py

References
----------

.. [1] https://www.gnu.org/licenses/gpl-3.0.en.html

Author
-------

- Julian Estiven Valencia Bolaños <jevalencib@eafit.edu.co>