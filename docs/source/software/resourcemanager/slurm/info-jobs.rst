.. _info-jobs:

.. role:: bash(code)
          :language: bash

.. role:: raw-html(raw)
          :format: html

.. contents:: Contents
              :local:


**Getting cluster(s) state**
----------------------------
The simplest way to get information about the state of our clusters is simple
using ``sinfo``



sinfo, squeue, partitions.

**Canceling a job**
-------------------
scancel, pause, halt, resume, etc.

**What's going on with my job?** Getting information about submitted jobs
-------------------------------------------------------------------------
(info about jobs that are in queue) 
scontrol show job; ssh htop; when is going to start?, sprio, tabla de estados  

**What happened with my job?** Getting information about finished jobs
----------------------------------------------------------------------
(information about jobs that are not in the queue) 
sacct; ssat (todo: array)

**Is my job still running?** Getting information about recent jobs
------------------------------------------------------------------
try to help the user to know what are their jobs.

**What's wrong with my job?** My job(s) can't be submitted
----------------------------------------------------------
fix common problems


