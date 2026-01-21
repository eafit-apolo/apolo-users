.. _intel-2025-index:


INTEL 2025
===========

.. contents:: Table of Contents

Basic information11
-----------------

- **Official Website:** https://www.gnu.org/software/parallel/
- **Installed on:** APOLO II

Tested on (Requirements)
------------------------

- **OS base:** Rocky Linux 8.5 (x86_64) :math:`\boldsymbol{\ge}` 8

Installation
-------------

#. First of all, you need to buy the Intel OneAPI Base Toolkit from the official Intel website. Once you have purchased it, you can download the installer

    .. code-block:: bash
        $ wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/6bfca885-4156-491e-849b-1cd7da9cc760/intel-oneapi-base-toolkit-2025.1.1.36.sh

#. Then, execute the installer

    .. code-block:: bash
        $ sh intel-oneapi-base-toolkit-2025.1.1.36.sh

#. Then, finish the installation by following the instructions in the installer. You can choose the default options or customize them according to your needs

#. Finally, finish to run the following command to set up the environment variables for the Intel OneAPI Base Toolkit

    .. code-block:: bash
        $ source setvars.sh

#. If you want to save the environment variables set by `setvars.sh` to a file, you can use the following script:

    .. code-block:: bash

        #!/bin/bash

        # Ruta donde quieres guardar el dump
        DUMP_FILE="./setvars_dump.sh"

        # Guardar entorno antes
        env | sort > /tmp/env_before.txt

        # Ejecutar setvars.sh (en el shell actual)
        source ./setvars.sh

        # Guardar entorno después
        env | sort > /tmp/env_after.txt

        # Extraer solo las diferencias (nuevas/modificadas)
        comm -13 /tmp/env_before.txt /tmp/env_after.txt | while read line; do
          var_name=$(echo "$line" | cut -d'=' -f1)
          var_value=$(echo "$line" | cut -d'=' -f2- | sed 's/"/\\"/g')
          echo "export ${var_name}=\"${var_value}\""
        done > "$DUMP_FILE"

        echo "Archivo generado: $DUMP_FILE"

Author
------
 - Juan Manuel Gomez Piedrahita
