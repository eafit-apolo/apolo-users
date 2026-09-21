.. _lefse-1.1.2-index:


LEfSe 1.1.2
===========

.. contents:: Table of Contents

Basic information
-----------------

- **Official Website:** https://huttenhower.sph.harvard.edu/lefse/
- **Source repository:** https://github.com/SegataLab/lefse

Tested on (Requirements)
------------------------

* **Dependencies:**
    * python/3.12_miniconda-24.7.1

Installation
------------

LEfSe is distributed as a set of Python scripts and is installed into a Conda
environment rather than compiled.

#. Load the Miniconda module:

    .. code-block:: bash

        $ module load python/3.12_miniconda-24.7.1

#. Download the source code:

    .. code-block:: bash

        $ mkdir -p ~/apps/lefse && cd ~/apps/lefse
        $ git clone https://github.com/SegataLab/lefse.git

#. Create and activate the environment, then install LEfSe and its
   dependencies:

    .. code-block:: bash

        $ conda create -n lefse -c conda-forge -c bioconda lefse=1.1.2
        $ conda activate lefse

Use
---

Every command accepts ``-h`` to list its available options.

Formatting the input
~~~~~~~~~~~~~~~~~~~~

``lefse-format_input.py`` converts the input data matrix into the format
expected by LEfSe:

    .. code-block:: bash

        $ lefse-format_input.py input.txt formatted.in -c 1 -s 2 -u 3 -o 1000000

Running the analysis
~~~~~~~~~~~~~~~~~~~~

``lefse_run.py`` performs the statistical analysis, applying LEfSe to the
formatted data and producing the results that the plotting modules consume:

    .. code-block:: bash

        $ lefse_run.py formatted.in results.res

Visualizing the results
~~~~~~~~~~~~~~~~~~~~~~~

``lefse_plot_res.py`` plots the list of biomarkers with their effect size.
Several graphical options are available for personalizing the output:

    .. code-block:: bash

        $ lefse_plot_res.py results.res biomarkers.png

``lefse_plot_cladogram.py`` plots the representation of the biomarkers on a
hierarchical tree:

    .. code-block:: bash

        $ lefse_plot_cladogram.py results.res cladogram.png --format png

``lefse_plot_features.py`` exports the raw-data representation of the
features. With the default options it produces one image per feature detected
as a biomarker:

    .. code-block:: bash

        $ lefse_plot_features.py formatted.in results.res features/

Slurm template
~~~~~~~~~~~~~~

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --partition=longjobs
        #SBATCH --nodes=1
        #SBATCH --ntasks-per-node=1
        #SBATCH --time=1:00:00
        #SBATCH --job-name=lefse
        #SBATCH -o result_%N_%j.out
        #SBATCH -e result_%N_%j.err

        export SBATCH_EXPORT=NONE

        module load python/3.12_miniconda-24.7.1
        source activate lefse

        lefse_run.py formatted.in results.res

Resources
---------
 * https://huttenhower.sph.harvard.edu/lefse/
 * https://github.com/SegataLab/lefse
