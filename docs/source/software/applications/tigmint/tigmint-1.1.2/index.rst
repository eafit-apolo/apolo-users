.. tigmint-1.1.2:

Tigmint 1.1.2
=============

Basic information
-----------------

- **Deploy date:** 3 December 2019
- **Official Website:** https://github.com/bcgsc/tigmint
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Dependencies:**
    - Miniconda 4.5.1 or greather
    - Bedtools
    - Bwa
    - Samtools
- **Optional dependencies:**
    - :ref:`Pigz <pigz>`. Recommended for parallel compression

Installation
------------
#. Before installing Tigmint install all its dependencies. After installing all the dependencies run:

    .. code-block:: bash

        $ mkdir -p /share/apps/tigmint/1.1.2/miniconda/4.5.1
        $ git clone https://github.com/bcgsc/tigmint
        $ sudo cp -r tigmint/* /share/apps/tigmint/1.1.2/miniconda/4.5.1/

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/1.1.2_miniconda-4.5.1
        :language: bash
        :caption: :download:`1.1.2_miniconda-4.5.1 <src/1.1.2_miniconda-4.5.1>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/tigmint
        $ sudo mv 1.1.2_miniconda-4.5.1 /share/apps/modules/tigmint/

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
