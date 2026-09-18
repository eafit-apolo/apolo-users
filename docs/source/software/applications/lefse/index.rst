.. _lefse-index:

LEfSe
=====

This document describes the installation and usage workflow for LEfSe.

Basic Information
-----------------

- **Official website:** https://github.com/SegataLab/lefse
- **Installed on:** APOLO II
- **Main dependency:** python/3.12_miniconda-24.7.1

Installation
------------

#. Clone the source code:

   .. code-block:: bash

      mkdir lefse
      cd lefse
      git clone https://github.com/SegataLab/lefse.git

#. Load the Python module:

   .. code-block:: bash

      module load python/3.12_miniconda-24.7.1

#. Activate the LEfSe environment:

   .. code-block:: bash

      conda activate lefse

Usage
-----

The most common LEfSe commands are:

.. code-block:: bash

   lefse-format_input.py -h
   lefse_run.py -h
   lefse_plot_res.py -h
   lefse_plot_cladogram.py -h
   lefse_plot_features.py -h
