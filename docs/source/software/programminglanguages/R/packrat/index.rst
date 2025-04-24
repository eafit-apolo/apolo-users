.. _packrat:

Packrat: a dependency management system for R
==============================================

Use packrat [1]_ to make your R projects more:

- **Isolated:** Installing a new or updated package for one project won’t break your other projects, and vice versa. That’s because packrat gives each project its own private package library.
- **Portable:** Easily transport your projects from one computer to another, even across different platforms. Packrat makes it easy to install the packages your project depends on.
- **Reproducible**: Packrat records the exact package versions you depend on, and ensures those exact versions are the ones that get installed wherever you go.

When you are using packrat you are no longer in an ordinary R project; you are in a Packrat project. The main difference is that a packrat project has its own private package library. Any packages you install from inside a packrat project are only available to that project; and packages you install outside of the project are not available to the project. [2]_

.. contents:: Table of Contents

Basic concepts
--------------

Packrat enhances your project directory by storing your package dependencies inside it, rather than relying on your personal R library that is shared across all of your other R sessions. We call this directory your **private package library** (or just **private library**). When you start an R session in a packrat project directory, R will only look for packages in your private library; and anytime you install or remove a package, those changes will be made to your private library.

Unfortunately, private libraries don’t travel well; like all R libraries, their contents are compiled for your specific machine architecture, operating system, and R version. Packrat lets you **snapshot** the state of your private library, which saves to your project directory whatever information packrat needs to be able to recreate that same private library on another machine. The process of installing packages to a private library from a snapshot is called **restoring**. [1]_

Installation
------------

#. Load the R module that best suits your needs, for example:

   .. code-block:: bash

        $ module load r/3.6.3_gcc-7.4.0

  .. note::
      The necessary dependencies will be loaded automatically once the R module is loaded.

#. start R by typing R in the terminal:

   .. code-block:: bash

        $ R

        R version 3.6.3 (2020-02-29) -- "Holding the Windsock"
        Copyright (C) 2020 The R Foundation for Statistical Computing
        Platform: x86_64-pc-linux-gnu (64-bit)

        R is free software and comes with ABSOLUTELY NO WARRANTY.
        You are welcome to redistribute it under certain conditions.
        Type 'license()' or 'licence()' for distribution details.

          Natural language support but running in an English locale

        R is a collaborative project with many contributors.
        Type 'contributors()' for more information and
        'citation()' on how to cite R or R packages in publications.

        Type 'demo()' for some demos, 'help()' for on-line help, or
        'help.start()' for an HTML browser interface to help.
        Type 'q()' to quit R.
        >

#. Once R has started we must install the packrat package.


   .. code-block:: bash

        > install.packages("packrat")

#. The following warning will appear since you as a user do not have permission to save packages in the default library.

   .. code-block:: bash

        Warning in install.packages("packrat") :
          'lib = "/share/apps/r/3.6.3/gcc/7.4.0/lib64/R/library"' is not writable
        Would you like to use a personal library instead? (yes/No/cancel)


    R is going to ask you if you want to create a personal library, it will save the packages you install, so type **yes**.

   .. code-block:: bash

        Would you like to use a personal library instead? (yes/No/cancel) yes
        Would you like to create a personal library
        ‘~/R/x86_64-pc-linux-gnu-library/3.6’
        to install packages into? (yes/No/cancel) yes

#. Now you are going to choose a mirror to download the package, it is recommended to choose the closest to your location for a faster download. In this case we will choose Colombia (21).

   .. code-block:: bash

        --- Please select a CRAN mirror for use in this session ---
        Secure CRAN mirrors

         1: 0-Cloud [https]
         2: Australia (Canberra) [https]
         3: Australia (Melbourne 1) [https]
         4: Australia (Melbourne 2) [https]
         5: Australia (Perth) [https]
         6: Austria [https]
         7: Belgium (Ghent) [https]
         8: Brazil (BA) [https]
         9: Brazil (PR) [https]
        10: Brazil (RJ) [https]
        11: Brazil (SP 1) [https]
        12: Brazil (SP 2) [https]
        13: Bulgaria [https]
        14: China (Beijing 1) [https]
        15: China (Beijing 2) [https]
        16: China (Hong Kong) [https]
        17: China (Guangzhou) [https]
        18: China (Lanzhou) [https]
        19: China (Nanjing) [https]
        20: China (Shanghai 1) [https]
        21: Colombia (Cali) [https]
        ...

        Selection: 21

#. To start your private library just run the following command and from this point on all the packages you install will be in the project's private library.

   .. code-block:: bash

        > packrat::init("<project_directory path>")

  .. note::
        If you are located in the project's directory, you can omit the path.


Commands
--------

Some common commands in packrat. [2]_

- To create a packrat project.

   .. code-block:: bash

        > packrat::init("<project_directory_path>")

- To install a required package.

   .. code-block:: bash

        > install.packages("<package_name>")

- To snapshot the project to save the changes.

   .. code-block:: bash

        > packrat::snapshot()

- To see the current status of the project.

   .. code-block:: bash

        > packrat::status()

- To remove a package.

   .. code-block:: bash

        > remove.packages("<package_name>")

- To restore the removed packages.

   .. code-block:: bash

        > packrat::restore()


.. note::

    Remember to save your workspace before exiting. The next time you run R in the project directory, packrat will be automatically activated.


References
----------

.. [1] https://rstudio.github.io/packrat/

.. [2] https://rstudio.github.io/packrat/walkthrough.html


:Author:

    - Laura Sánchez Córdoba <lsanchezc@eafit.edu.co>
