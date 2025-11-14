. _installation:

Installation and Compilation of lefse
======================================

This document describes the steps to install and compile lefse

System Requirements
-------------------

- **Compiler:** python/3.12_miniconda-24.7.1
- **Dependencies:**

Downloading and Extracting the Source Code
------------------------------------------

To download and extract the lefse source code, run:

.. code-block:: bash
    mkdir lefse
    git clone https://github.com/SegataLab/lefse.git

    Before compilation, load the necessary modules:

.. code-block:: bash
    module load python/3.12_miniconda-24.7.1

Compiling lefse
----------------
conda activate lefse

# Running the LEfSe commands with -h gives the list of available options

# lefse-format_input.py convert the input data matrix to the format for LEfSe.

# lefse_run.py performs the actual statistica analysis
#
# Apply LEfSe on the formatted data producing the results (to be further processed
# for visualization with the other modules). The option available
# can be listed using the -h option

# lefse_plot_res.py visualizes the output
#
# Plot the list of biomarkers with their effect size
# Severak graphical options are available for personalizing the output

# lefse_plot_cladogram.py visualizes the output on a hierarchical tree
#
# Plot the representation of the biomarkers on the hierarchical tree

# lefse_plot_features.py visualizes the raw-data features
#
# The module for exporting the raw-data representation of the features.
# With the default options we will obtain the images for all the features that are
# detected as biomarkers
