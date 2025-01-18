.. _sepp-4.5.5:


.. contents:: Table of Contents

*****
4.5.5
*****

- **URL:** https://github.com/smirarab/sepp
- **Apolo version:** Apolo II
- **License:** GPL-3.0

Dependencies
------------

- Python: Version >= 3.6
- Java: Version > 1.5

Installation
------------

After ensuring the dependencies are resolved (which, by default, are already taken care of), you can proceed with the installation of SEPP. You may choose to use any Miniconda module that suits your needs

1. You need to activate the Python environment where you want to install SEPP. Additionally, you can perform the installation in any directory within your own profile.

2. Download the version 4.5.5 of the software (Source code) (https://github.com/smirarab/sepp/archive/refs/tags/v4.5.5.tar.gz):

.. code-block:: bash

    wget https://github.com/smirarab/sepp/archive/refs/tags/v4.5.5.tar.gz
    tar -xvzf v4.5.5.tar.gz

3. Then you can proceed with the installation of the program (https://github.com/smirarab/sepp/blob/master/tutorial/sepp-tutorial.md):

.. code-block:: bash

    cd sepp-4.5.5/
    python setup.py config -c   # The -c option creates the .sepp/main.config file in the current directory instead of the home directory.
    pip install .

4. Aclarations:
    1. In the official documentation, the installation is performed using the command ``python setup.py install --user``, but this method is deprecated and its use is not recommended.
    2. Depending on your intended use, you may need to modify the **main.config file**. This file is located in the ``.sepp`` directory. If you perform the installation with the ``-c`` flag, the file will remain in the ``sepp-4.5.5`` directory
    3. It is very important to read the (https://github.com/smirarab/sepp/blob/master/tutorial/sepp-tutorial.md) because it explains how to configure the application, such as specifying the number of CPUs to use or adjusting parameters that affect the alignment subset decomposition in the **main.config** file.
    4. You can unninstall the aplication using ``pip unninstall sepp``.

5. Automatic instalation: All the procees including the dependencies validation can be performed with a bash script

.. code-block:: bash

    #!/bin/bash

    # Step 1: Dependencies
    echo "Verificando dependencias..."

    python_version=$(python3 --version 2>&1 | awk '{print $2}')
    python_major=$(echo $python_version | cut -d. -f1)
    python_minor=$(echo $python_version | cut -d. -f2)

    if [ "$python_major" -ge 3 ] && [ "$python_minor" -ge 6 ]; then
        echo "Python versión correcta: $python_version"
    else
        echo "Se requiere Python >= 3.6. Por favor, actualiza Python."
        exit 1
    fi

    java_version=$(java -version 2>&1 | head -n 1)
    if [[ $java_version =~ "1." ]]; then
        echo "Java versión correcta: $java_version"
    else
        echo "Se requiere Java versión > 1.5. Por favor, actualiza Java."
        exit 1
    fi

    # Step 2: Download
    wget https://github.com/smirarab/sepp/archive/refs/tags/v4.5.5.tar.gz -O v4.5.5.tar.gz
    tar -xvzf v4.5.5.tar.gz
    rm v4.5.5.tar.gz

    # Step 4: Installation
    cd sepp-4.5.5/
    python3 setup.py config -c
    pip install .

    # Ptep 4: Configuration
    echo "Recuerda leer la documentación oficial para más detalles sobre la configuración."
    echo "https://github.com/smirarab/sepp/blob/master/tutorial/sepp-tutorial.md"
    echo "https://github.com/smirarab/sepp/blob/master/README.SEPP.md"

Mode of use
-----------

After the installation, you can test the application using the sample data provided in the source code (this will create output files in the current directory). For more information, refer to the official documentation.

.. code-block:: bash

    python run_sepp.py -h   # This command displays the options to run the application
    # The following command will execute the application with sample data.
    python run_sepp.py -t test/unittest/data/mock/pyrg/sate.tre -r test/unittest/data/mock/pyrg/sate.tre.RAxML_info -a test/unittest/data/mock/pyrg/sate.fasta -f test/unittest/data/mock/pyrg/pyrg.even.fas

References
----------

- https://github.com/smirarab/sepp/blob/master/tutorial/sepp-tutorial.md
- https://github.com/smirarab/sepp/blob/master/README.SEPP.md

Author
------

- Julian Valencia Bolaños
