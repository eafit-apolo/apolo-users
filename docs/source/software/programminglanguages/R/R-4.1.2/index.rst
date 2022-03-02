.. _R-4.1.2-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

R - 4.1.2
=========

Basic Information
-----------------

- **Installation Date:** 14/02/2022
- **URL:** https://www.r-project.org/
- **Apolo Version:** Apolo II and later
- **License:** https://www.r-project.org/Licenses/

Dependencies
------------

- OneApi compiler

Installation
------------

1. Load the miniconda module.

.. code-block:: bash

    $ module load miniconda3-4.10.3-oneapi-2022.0.0-2mgeehu

2. Change to a conda enviroment different from the base one.

.. code-block:: bash

    $ conda activate ENV_NAME

If you have not created a conda enviroment, you can create it with the command

.. code-block:: bash

    $ conda create --name ENV_NAME

3. Install R

.. code-block:: bash

    $ conda install -c conda-forge r-base=4.1.2

.. note:: We recommend using the conda-forge channel  for the installation as well as the installation of other R packages, since it has the most recent packages.

4. Check the installation.

.. code-block:: bash

    $ conda list r-base

You should be able to see the name of the package, version installed and the channel it was downloaded from.

Installing R packages
---------------------

1. Move to the conda enviroment you want to install the packages in.

.. code-block:: bash

    $ conda activate ENV_NAME

2. Install the package.

.. code-block:: bash

    $ conda install PACKAGE_NAME

.. note:: We recommend that the user looks up the name of the package in the anaconda repository before installing the package, to make sure that is the correct one.

Running Example
---------------
.. code-block:: bash

    #!/bin/bash

    #SBATCH --partition=longjobs                    # Partition
    #SBATCH --nodes=1
    #SBATCH --ntasks=1                              # Number of tasks (processes)
    #SBATCH --time=1:00                            # Walltime
    #SBATCH --job-name=test_r                       # Job name
    #SBATCH --output=%x_%j.out                      # Stdout (%x-jobName, %j-jobId)
    #SBATCH --error=%x_%j.err                       # Stderr (%x-jobName, %j-jobId)
    #SBATCH --mail-type=ALL                         # Mail notification
    #SBATCH --mail-user=jmonsalve@eafit.edu.co       # User Email


    ##### ENVIRONMENT CREATION #####
    source activate test1
    module load miniconda3-4.10.3-oneapi-2022.0.0-2mgeehu

    ##### JOB COMMANDS ####
    Rscript simple_script.r

Resources
---------

- https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/


:Authors:

- Jacobo Monsalve Guzman <jmonsalve@eafit.edu.co>
