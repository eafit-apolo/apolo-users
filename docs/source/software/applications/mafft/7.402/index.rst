.. _mafft-7.402-index:

.. role:: bash(code)
   :language: bash

.. role:: raw-html(raw)
   :format: html

MAFFT-7.402
===========

Basic Information
-----------------

- **Deploy date:** 27 July 2018.
- **Official Website:** https://mafft.cbrc.jp/alignment/software/
- **License:** BSD License.
  
  - **Extensions:**
    
    - **Mxcarna:** BSD License (For more information check README file in :bash:`mafft-7.402-with-extensions/extensions/mxscarna_src/`.
    - **Foldalign:** GNU GPL-2.
    - **Contrafold:** BSD License.
      
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`, 
  :ref:`Cronos <about_cronos>`

Installation
------------

This entry covers the entire process performed for the installation and configuration of MAFFT with extensions (MXSCARNA, Foldalign and CONTRAfold) on a cluster.

.. toctree::
   :maxdepth: 2

   installation

Usage
-----

This section desribes the method to submit jobs with the resource manager SLURM.

#. Load the necessary environment.

   .. code-block:: bash

      module load mafft/7.402-with-extensions_intel-17.0.1

#. Run the SLURM script.

   An example of a SLURM script:

   .. note::
      
      This example was test with ITS.fa that contains unlined DNA secuences. :download:`ITS.fa <src/ITS.fa>`

   .. code-block:: bash

      #!/bin/bash
   
      #SBATCH --partition=longjobs
      #SBATCH --nodes=1
      #SBATCH --ntasks-per-node=32
      #SBATCH --time=120:00:00
      #SBATCH --job-name=test
      #SBATCH -o result_%N_%j.out      # File to which STDOUT will be written
      #SBATCH -e result_%N_%j.err      # File to which STDERR will be written
      #SBATCH --mail-type=ALL   
      #SBATCH --mail-user=test@example.com

      export SBATCH_EXPORT=NONE
      export OMP_NUM_THREADS=1

      mafft --quiet --auto --thread $SLURM_NTASKS ITS.fa > ITS_al.fa

   **Options**

   - ``quiet`` :raw-html:`&rarr;` Do not report progress.
   - ``auto`` :raw-html:`&rarr;` Automatically selects an appropriate strategy from L-INS-i, FFT-NS-i and FFT-NS-2, according to data size.
   - ``thread`` :raw-html:`&rarr;` Number of threads
   |
   .. note::
      
      For more information, please read the manual entry for Mafft :bash:`man mafft` or :bash:`mafft -h`
   

Authors
-------

- Manuela Carrasco Pinzón <mcarras1@eafit.edu.co>
