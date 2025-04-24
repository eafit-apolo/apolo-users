.. _8.0:

CUDA-8.0
========

.. contents:: Table of Contents

Basic information
-----------------

- **Instalation Date:** 16/06/2017
- **Official name:** CUDA Multi-Process Service (MPS)
- **Apolo version:** Apolo II

Dependencies and Instalation
----------------------------

After compiling and building the driver for a compatible nvidia accelerator, it is required to install the toolkit for
the CUDA parallel computing platform. This installation will create in the /usr/bin/ directory the executables
**nvidia-cuda-mps-control** and **nvidia-cuda-mps-server**.

Both files must be present before enabling the service for use.

Activation
----------

The activation of the service is performed by executing nvidia-cuda-mps-control, which uses the environment variables CUDA_VISIBLE_DEVICES,
CUDA_MPS_PIPE_DIRECTORY and CUDA_MPS_LOG_DIRECTORY to determine the configuration to be used at runtime. The table found below explains in detail
the meaning of each one:

+-------------------------+--------------------------------------------------------------------------------------------------+
+ Hostname                | IP address                                                                                       |
+=========================+==================================================================================================+
+ CUDA_VISIBLE_DEVICES    | It is used to specify which GPU will be visible to a CUDA application. The variable can contain  |
+                         | positive integer values (separated by commas) starting with the number zero (0).                 |
+-------------------------+--------------------------------------------------------------------------------------------------+
+ CUDA_MPS_PIPE_DIRECTORY | The different MPS clients communicate through named pipes located by default in the              |
+                         | /tmp/nvidia-mps directory, which can be modified by assigning a different path to this variable. |
+-------------------------+--------------------------------------------------------------------------------------------------+
+ CUDA_MPS_LOG_DIRECTORY  | The MPS service control daemon uses the control.log file to record the status of the MPS         |
+                         | servers, commands executed by a user as well as their output, and starting and stopping          |
+                         | information for the daemon. The MPS server maintains the log server.log, where it stores data    |
+                         | about its startup, shutdown and status of each client. Both are stored by default in the         |
+                         | /var/log/nvidia-mps directory, which can be modified by assigning a different path to this       |
+                         | variable.                                                                                        |
+-------------------------+--------------------------------------------------------------------------------------------------+

Daemon initiation and single server
***********************************

By using the /var/log/nvidia-mps directory to store the activity logs, both the daemon and the MPS server restrict the use
of the service to the root user, since the permissions on the /var path make it impossible for other users access its content.
In order to start the daemon and the server without requiring the intervention of a superuser, it is necessary to use the
environment variables described above as illustrated in the following example:

.. code-block:: bash

    $ mkdir /tmp/mps_0
    $ mkdir /tmp/mps_log_0
    $ export CUDA_VISIBLE_DEVICES=0
    $ export  CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_0
    $ export  CUDA_MPS_LOG_DIRECTORY=/tmp/mps_log_0
    $ nvidia-cuda-mps-control -d

The use of CUDA_MPS_PIPE_DIRECTORY is optional, since the default path is accessible to all
users of the system; while CUDA_MPS_LOG_DIRECTORY must contain a path in which the user seeking to start the service has read and
write permissions

Initiation of multiple daemons and multiple servers
***************************************************

When having multiple nvidia accelerators, a daemon and an MPS server must be activated for each one. With this, and assuming
that we have two accelerators, the structure described in the example in the section "Daemon initiation and a single server"
must be transformed as follows:

    .. code-block:: bash

        NGPUS=2

        for (( i = 0; i < $NGPUS; ++i  ))
        do
            mkdir /tmp/mps_$i
            mkdir /tmp/mps_log_$i

            export CUDA_VISIBLE_DEVICES=$i
            export  CUDA_MPS_PIPE_DIRECTORY="/tmp/mps_$i"
            export  CUDA_MPS_LOG_DIRECTORY="/tmp/mps_$i"

            nvidia-cuda-mps-control -d
        done

- It is necessary to clarify that this procedure is functional if and only if the cards are in the same node, where it is feasible for
  the nvidia driver to assign an id to each accelerator.

- Certain GPUs, such as the Tesla K80, internally contain two different graphics processing cards, each one being recognized as independent
  by the controller. In these controllers the procedure described in this section must be used to start the MPS service.

Detention
---------

Stopping the daemon and a single server
***************************************

The stopping process requires that the environment variables used by the MPS daemon during service initialization retain their value.
Returning to the example of the subsection "Initiating the daemon and a single server", stopping the service should be carried out as follows:

.. code-block:: bash

        $ export CUDA_VISIBLE_DEVICES=0
        $ export  CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_0
        $ export  CUDA_MPS_LOG_DIRECTORY=/tmp/mps_log_0
        $ echo "quit" | nvidia-cuda-mps-control


Stopping multiple daemons and multiple servers
**********************************************

Taking the explanation from the section "Starting multiple daemons and multiple servers", it is feasible to conclude that when
starting a server for each card present it is necessary to stop them individually, as well as their respective daemons,
using nvidia-cuda-mps-control. Taking the example from the section "Stopping the daemon and a single server" and assuming that
you have two cards, the basic structure of a script to stop the MPS service would be:

.. code-block:: bash

    NGPUS=2

    for (( i = 0; i < $NGPUS; ++i ))
    do
        export CUDA_MPS_PIPE_DIRECTORY="/tmp/mps_$i"
        echo "quit" | nvidia-cuda-mps-control
        rm -fr /tmp/mps_$i
        rm -fr /tmp/mps_log_$i
    done

How to Use
----------

Once the service is activated, it can be used by two types of applications:

    1. Those whose dependence on CUDA is not linked to MPI.
    2. Those that run using MPI


In the former, it is enough to define the card on which the program will be executed through the assignment of the
variable CUDA_VISIBLE_DEVICES, while the latter require the creation of a script that uses the variable CUDA_MPS_PIPE_DIRECTORY to
indicate to the service which MPI process it will carry out. your instructions based on which server. The structure of this script is explained below:

    - Initially, it is necessary to obtain the identifier of each MPI process, so that all can be distributed equally on the activated MPS servers;
      This identifier is known as rank according to the MPI standard and is stored in an environment variable, whose name may vary depending on the MPI
      implementation used: openmpi, mpich, mvapich, etc. The example illustrated below makes use of the variable OMPI_COMM_WORLD_LOCAL_RANK belonging to openmpi:

        .. code-block:: bash

             lrank="$OMPI_COMM_WORLD_LOCAL_RANK"

    - After obtaining the identifier of each process, it is necessary to define the value of the variable CUDA_MPS_PIPE_DIRECTORY, ensuring that the distribution
      carried out is the same on each MPS server. The example illustrated below assumes that the maximum number of processes to use is four (4), the system has
      two cards and the directories where the named pipes used by each MPS server are located correspond to those described throughout the section Activation:

        .. code-block:: bash

             case ${lrank} in
                [0])
                    export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_0
                    ;;
                [1])
                    export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_1
                    ;;
                [2])
                    export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_0
                    ;;
                [3])
                    export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_1
                    ;;
            esac

    - Finally, the program from which each of the MPI processes will be created is executed.

An example of the correct way of running a program that uses MPI and benefits from the MPS service is illustrated below.

.. code-block:: bash

    $ cat mps_runnable.sh

        #!/bin/bash

        lrank="$OMPI_COMM_WORLD_LOCAL_RANK"

        case ${lrank} in
            [0])
                export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_0
                ;;
            [1])
                export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_1
            ;;
            [2])
                export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_0
                ;;
            [3])
                export CUDA_MPS_PIPE_DIRECTORY=/tmp/mps_1
                ;;
        esac

        program_that_uses_gpu

    $ mpirun -np 4 ./mps_runnable.sh

Troubleshooting
---------------

MPS cannot reserve memory at startup
************************************

"This error (ERROR_OUT_OF_MEMORY) is associated with the reservation of virtual memory over the address range of the UVA (Unified Virtual Addressing) by
the processes that try to run on the MPS server on the GPU.
This error normally occurs in old operating systems, this being the case of CentOS 6.6 (Rocks 6.2), since the program in charge of making
said reservation (prelink) causes interference problems between dynamic libraries and virtual memory reservation in the UVA address range.
The recommendation in this case is to temporarily or permanently disable the prelink" (Taken from [1]_)

Process
+++++++

1. Enter the server where you want to run the MPS service with the root user.

2. Edit the **/etc/sysconfig/prelink** file and change **PRELINKING=yes** to **PRELINKING=no**

3. Manually run the following cron: **/etc/cron.daily/prelink**

In this way the **prelink** will be permanently disabled.

MPS processes change their status to "Zombie" after stopping the service
************************************************************************

Although it is rare for this problem to occur, one of the ways to identify it is to verify the existence of a process named
nvidia-cuda-mps whose status is shown in Z.

In case of performing the process of starting and stopping the MPS service in an automated way (i.e. through a script and not directly
in an interactive session), it is advisable to detect the existence of one or more Zombie processes as shown below:

.. code-block:: bash

    ps aux | grep nvidia-cuda-mps | grep -v grep > /dev/null
    if [ [ $? -eq 0 ] ]; then
        declare -r error_message="Some error message"
        logger $error_message
        # Do something like "pkill -u <user owning the zombies>"
    fi

GPU has problems after disabling MPS
************************************

It is a rare error, the causes of which are very varied. The best way to detect it if you have an automated stopping process for the MPS service is:

.. code-block:: bash

    nvidia-smi > /dev/null
    if [ [ $? -ne 0 ] ]; then
        declare -r error_message="Some error message"
        logger $error_message
        # Do something
    fi


Links
-----
- http://on-demand.gputechconf.com/gtc/2015/presentation/S5584-Priyanka-Sah.pdf
- http://cudamusing.blogspot.com.co/2013/07/enabling-cuda-multi-process-service-mps.html
- https://docs.nvidia.com/deploy/pdf/CUDA_Multi_Process_Service_Overview.pdf
- http://www.builddesigncreate.com/index.cgi?mode=page_details&pageid=2011080413332724848

References
----------

.. [1] nvidia, "MULTI-PROCESS SERVICE", Mayo del 2015, https://docs.nvidia.com/deploy/pdf/CUDA_Multi_Process_Service_Overview.pdf. Last accessed July 11, 2017


.. rubric:: Authors

* Tomás Felipe Llano Ríos
* Mateo Gómez-Zuluaga
