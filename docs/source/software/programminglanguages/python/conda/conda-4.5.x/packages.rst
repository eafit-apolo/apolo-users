.. _conda-packages:

.. role:: bash(code)
    :language: bash

Packages
========

Install a package
^^^^^^^^^^^^^^^^^
To install a package in an environment use, when your environment are activate:

.. code-block:: bash

    conda install <package-name>

If the environment are not activate use:

.. code-block:: bash

    conda install -n <environment-name> <package-name>

Uninstall a package
^^^^^^^^^^^^^^^^^^^
To remove a list of packages from a specified conda environment use, when your environment are activate:

.. code-block:: bash 

    conda remove <package-name>

If the environment are not activate use:

.. code-block:: bash

    conda remove -n <environment-name> <package-name>

.. note::

    You can use remove or uninstall (that is an alias for remove)

Update packages
^^^^^^^^^^^^^^^^
update and upgrade

Others useful commands
^^^^^^^^^^^^^^^^^^^^^^
clean
list -e
search