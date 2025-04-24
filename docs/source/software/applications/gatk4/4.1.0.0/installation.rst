.. _gatk4-4.1.0.0-installation:

.. role:: bash(code)
    :language: bash

Tested on (Requirements)
------------------------

- **OS base:** CentOS (x86_64) :math:`\boldsymbol{\ge}` 6.6
- Java 1.8.
- Python :math:`\boldsymbol{\ge}` 2.6.
- Git :math:`\boldsymbol{\ge}` 1.8.2 with git-lfs.

Build process
-------------

This entry described the installation process of GATK4.

#. Clone the GATK4 repository.

   .. code-block:: bash

      git clone https://github.com/broadinstitute/gatk

#. Load the Java module.

   .. code-block:: bash

      module load java/jdk-1.8.0_112

#. Enter the directory and compile it.

   .. note::

      You can choose tha way to build:

      - ./gradlew bundle or ./gradlew

        * This creates a zip archive in the build/ directory with a name like gatk-VERSION.zip containing a complete standalone GATK distribution, you can also run GATK commands directly from the root of your git clone after running this command.

      - ./gradlew installDist

        * Does a fast build that only lets you run GATK tools from inside your git clone, and locally only (not on a cluster).

      - ./gradlew installAll

        * Does a semi-fast build that only lets you run GATK tools from inside your git clone, but works both locally and on a cluster.

      - ./gradlew localJar

        * Builds only the GATK jar used for running tools locally (not on a Spark cluster). The resulting jar will be in build/libs with a name like gatk-package-VERSION-local.jar, and can be used outside of your git clone.

      - ./gradlew sparkJar

        * Builds only the GATK jar used for running tools on a Spark cluster (rather than locally).

   .. code-block:: bash

      cd gatk
      ./gradlew installDist

#. Move your compile files to the path where you want GATK4.

   .. code-block:: bash

      mv gatk/ /your/path/

#. Create the module.

Module Files
------------
Apolo II
^^^^^^^^

.. literalinclude:: src/4.1.0.0
   :language: tcl
   :caption: :download:`GATK4-4.1.0.0 <src/4.1.0.0>`
