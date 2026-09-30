.. _index:

Apolo Scientific Computing Center
=================================

Apolo is the scientific computing center of Universidad EAFIT, in Medellín,
Colombia. It runs high-performance computing clusters for researchers of
EAFIT and of other institutions. This documentation shows you how to get
access, run your work and solve common problems.

New to Apolo?
-------------

Follow these steps in order. The whole path is described in
:ref:`gettingstarted-index`.

.. grid:: 1 1 3 3
   :gutter: 3

   .. grid-item-card:: 1. Request an account
      :link: request-an-account
      :link-type: ref

      Who can use Apolo, and how to ask for your VPN and cluster accounts.

   .. grid-item-card:: 2. Connect to Apolo
      :link: connect-to-apolo
      :link-type: ref

      Set up the VPN and log in to your cluster with SSH.

   .. grid-item-card:: 3. Run your first job
      :link: run-your-first-job
      :link-type: ref

      Write, submit and check a Slurm job, in about 10 minutes.

I want to…
----------

.. grid:: 1 2 3 3
   :gutter: 3

   .. grid-item-card:: Use or install software
      :link: use-scientific-software
      :link-type: ref

      Find a program, load its module, or ask for a new installation.

   .. grid-item-card:: Transfer files
      :link: transfer-files
      :link-type: ref

      Copy data between your computer and the cluster with scp, rsync or an
      SFTP client.

   .. grid-item-card:: Check my resource usage
      :link: check-resource-usage
      :link-type: ref

      My jobs in the queue, and what my finished jobs used.

   .. grid-item-card:: Find out why my job failed
      :link: job-failed
      :link-type: ref

      Diagnose time limits, memory errors, pending jobs and rejected
      scripts.

   .. grid-item-card:: Solve a common problem
      :link: frequent-problems
      :link-type: ref

      An index of frequent problems with access, jobs, software and files.

   .. grid-item-card:: Browse the software catalog
      :link: software
      :link-type: ref

      Every installed program, with its versions, modules and example jobs.

Quick reference
---------------

For experienced users: the essentials in one place.

.. list-table::
   :header-rows: 1
   :widths: 20 25 55

   * - Cluster
     - Address
     - Partitions
   * - :ref:`apolo-3`
     - ``apolo-3.eafit.edu.co``
     - ``longjobs``, ``bigmem``, ``accel``
   * - :ref:`Apolo II <about_apolo-ii>`
     - ``apolo.eafit.edu.co``
     - ``longjobs``, ``bigmem``, ``accel``, ``learning``

Both clusters are reachable only through the :ref:`VPN <configure_vpn>`.

.. list-table::
   :header-rows: 1
   :widths: 45 55

   * - Command
     - What it does
   * - ``sbatch <script>``
     - Submit a job.
   * - ``squeue -u $USER``
     - List your pending and running jobs.
   * - ``scancel <jobid>``
     - Cancel a job.
   * - ``squeue -u $USER --start``
     - Show when your pending jobs are expected to start.
   * - ``sinfo -s``
     - Show the partitions, their time limits and free nodes.
   * - ``module spider <program>``
     - Find a program and how to load it.
   * - ``module load <program>/<version>``
     - Load a program.

More: :ref:`slurm-index` · :ref:`lmod-index` · :ref:`supercomputers`

Help and contact
----------------

- Write to apolo@eafit.edu.co.
- Found an error in this documentation? :ref:`report-a-bug`.
- Used Apolo in your research? See :ref:`how-to-acknowledge`.

.. image:: images/Logotipo-EAFIT-azul-con-Vigilada-Mineducacion.png
   :width: 175px
   :alt: Universidad EAFIT logo

.. image:: images/QRApolo.png
   :width: 175px
   :alt: Apolo QR code

.. toctree::
   :hidden:
   :caption: Get started

   gettingstarted/index
   guides/request-an-account
   guides/connect-to-apolo
   guides/run-your-first-job

.. toctree::
   :hidden:
   :caption: Guides

   guides/use-scientific-software
   guides/transfer-files
   guides/check-resource-usage

.. toctree::
   :hidden:
   :caption: Tutorials

   tutorials/index

.. toctree::
   :hidden:
   :caption: Help

   troubleshooting/index
   report-a-bug

.. toctree::
   :hidden:
   :caption: Reference

   supercomputers/index
   software/index

.. toctree::
   :hidden:
   :caption: About

   how-to-acknowledge
