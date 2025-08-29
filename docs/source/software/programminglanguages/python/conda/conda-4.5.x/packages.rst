.. _conda-packages:

.. role:: bash(code)
    :language: bash

Packages
========

Install a package
^^^^^^^^^^^^^^^^^
To install a package in the current environment use:

.. code-block:: bash

    conda install <package-name>

Also, you can specify an environment for the installation:

.. code-block:: bash

    conda install -n <environment-name> <package-name>

Additionally, you can install a specific package version:

.. code-block:: bash

    conda install <package-name>=<x.x.x>

    conda install scipy=0.15.0

.. note::

    You can install multiple packages at once.

    .. code-block:: bash

        conda install <package-name> <package-name>

        conda install <package-name>=<x.x.x> <package-name>=<x.x.x>

Uninstall a package
^^^^^^^^^^^^^^^^^^^
To remove a list of packages from your current environment use, you can use remove or uninstall (that is an alias for remove):

.. code-block:: bash

    conda remove <package-name>

Also, you can specify an environment:

.. code-block:: bash

    conda remove -n <environment-name> <package-name>

.. note::

    You can uninstall multiple packages at once.

    .. code-block:: bash

        conda remove <package-name> <package-name>

Update packages
^^^^^^^^^^^^^^^^
You can check if a new package update is available, you can choose to install it or not:

.. code-block:: bash

    conda update <package>

Others useful commands
^^^^^^^^^^^^^^^^^^^^^^
* **Clean:** Use this command to remove unused packages and caches
    :bash:`conda clean`
* **List:** List all the packages in the current environment
    :bash:`conda list`
* **Search:** Search for packages and display associated information.
    :bash:`conda search  <package-name>`
