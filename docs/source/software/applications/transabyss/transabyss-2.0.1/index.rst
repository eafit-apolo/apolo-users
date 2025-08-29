.. _transabyss-2.0.1:

Trans-ABySS 2.0.1
=================

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://github.com/bcgsc/transabyss
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Dependencies:**
    - :ref:`ABySS <abyss>`
    - Python 3.x
    - python-igraph 0.7.x
    - :ref:`BLAT <blat>`

Installation
------------
#. Before installing Trans-ABySS install :ref:`ABySS <abyss>` and :ref:`BLAT <blat>`. Then run:

    .. code-block:: bash

        $ module load python/3.6.5_miniconda-4.5.1

        # Instead of "biology" any name can be used.
        $ conda create -n biology python=3.7
        $ conda activate biology
        $ pip install python-igraph

    Test:

    .. code-block:: bash

        $ module load blat/36_intel-19.0.4
        $ module load abyss/2.2.3_gcc-5.4.0
        $ git clone https://github.com/bcgsc/transabyss.git
        $ cd transabyss
        $ bash sample_dataset/assemble.sh
        $ rm -rf sample_dataset/merged.fa  sample_dataset/test.k25  sample_dataset/test.k32

    Install the scripts. From the Trans-ABySS' directory:

    .. code-block:: bash

        $ sudo mkdir -p /share/apps/transabyss/2.0.1/miniconda-4.5.1
        $ sudo cp -r * /share/apps/transabyss/2.0.1/miniconda-4.5.1/*

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/2.0.1_miniconda-4.5.1
        :language: bash
        :caption: :download:`2.0.1_miniconda-4.5.1 <src/2.0.1_miniconda-4.5.1>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/transabyss
        $ sudo mv 2.0.1_miniconda-4.5.1 /share/apps/modules/transabyss/

Usage
-----
Always activate the conda environment where python-igraph was installed, in this case:

.. code-block:: bash

    conda activate biology

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
