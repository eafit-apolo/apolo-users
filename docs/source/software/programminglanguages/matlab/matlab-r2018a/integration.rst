.. _matlab-r2018a-integration:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

.. sidebar:: Contents

   .. contents::
      :depth: 2
      :local:

MDCS_ using a local Matlab client
--------------------------------

#. Add the MATLAB integration scripts to your Matlab path by placing the 
   integration scripts into :bash:`$MATLAB_ROOT/toolbox/local` directory.

      .. admonition:: Linux / macOS
 
         .. code-block:: bash

            mkdir $HOME/matlab-integrations
            cp $path/to/file/matlab-apolo-ii.zip$ $HOME/matlab-integrations
            cp $path/to/file/matlab-cronos.zip$ $HOME/matlab-integrations
            cd $HOME/matlab-integrations
            unzip matlab-apolo-ii.zip
            unzip matlab-cronos.zip
            rm matlab-apolo-ii.zip matlab-cronos.zip 



      .. admonition:: Windows

         To-Do

#. Open your Matlab Client

   .. image:: images/matlab-client.png
      :alt: Matlab client

#. Set Path

   Add the integrations scripts to the Matlab PATH

   - Press the **Set Path** button

     .. image:: images/set-path.png
        :alt: Set Path button

   - Press the **Add with Subfolders** button and choose the directories where
     you decompress the integrations scripts (Apolo II and Cronos):
     
     - :bash:`/home/$USER/matlab-integrations/apolo-ii`
     - :bash:`/home/$USER/matlab-integrations/cronos`

     .. image:: images/subfolders.png
        :alt: Subfolders

MDCS_ using APOLO's Matlab client
--------------------------------

Matlab on APOLO
---------------

Unattended Job
^^^^^^^^^^^^^^

Interactive Job
^^^^^^^^^^^^^^^

.. _MDCS: https://la.mathworks.com/products/distriben.html


