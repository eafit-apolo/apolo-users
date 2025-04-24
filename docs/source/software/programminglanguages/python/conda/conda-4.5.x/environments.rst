.. _conda-environments:

.. role:: bash(code)
    :language: bash

Conda environments
==================

What is a virtual environment
+++++++++++++++++++++++++++++
A virtual environment [1]_ is a named, isolated, working copy of Python that maintains its own files, directories, and paths so that you can work with specific versions of libraries or Python itself without affecting other Python projects.

Creating a virtual environment
++++++++++++++++++++++++++++++
To create a virtual environment run:

.. code-block:: bash

    conda create -n <virtual-environment>

Then Conda will ask for permission to proceed, press :bash:`y`. Remember, the environment usually is created in the user's home directory :bash:`.conda/envs/environment-name>`.

Activate a virtual environment
++++++++++++++++++++++++++++++
To activate or switch into a virtual environment run:

.. code-block:: bash

    source activate <environment-name>

Remember that it's not necessary to deactivate the actual environment to switch into another environment. Also, your shell should change to indicate the name of the current conda environment :bash:`(<environment-name>)user@hostname`.

.. note::

    To list all your environments use:
    :bash:`conda env list`

Deactivate a virtual environment
++++++++++++++++++++++++++++++++
To end a session in the current environment run:

.. code-block:: bash

    source deactivate

It is not necessary to specify the environment name, it takes the current environment and deactivates it.

Delete a virtual environment
++++++++++++++++++++++++++++
If the user wants to delete a non-using environment run the following command:

.. code-block:: bash

    coda env remove -n <environment-name>

Export an environment
+++++++++++++++++++++
To export an environment file use the following command after activate the environment to export, the file will be create in the actual directory:

.. code-block:: bash

    conda env export > <environment-name>.yml

Then to use an environment that was exported run:

.. code-block:: bash

    conda env create -f <environment-name>.yml

where :bash:`-f` means the environment export file.

Other useful commands
+++++++++++++++++++++

Create a requirements file
^^^^^^^^^^^^^^^^^^^^^^^^^^
The requirements file is a way to get pip to install specific packages to make up an environment [2]_, also this file list all the packages that are used to documentation. In Conda, you can create this file using:

.. code-block:: bash

    conda list -e > requirements.txt


References
++++++++++
.. [1] Jekyll. (2014, November 20). Create virtual environments for python with conda. Retrieved from https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/

.. [2] (2019, June 24). Requirements file. Retrieved from https://pip.readthedocs.io/en/1.1/requirements.html
