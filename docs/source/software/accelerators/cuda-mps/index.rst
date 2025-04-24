.. _cuda-mps:


CUDA Multi-Process Service (MPS)
================================

CUDA MPS [1]_ is an alternative to the CUDA application programming interface (CUDA API). The MPS runtime architecture is designed to transparently enable the
use of Hyper-Q to CUDA applications that require the use of multiple cooperative processes, usually MPI jobs, on NVIDIA graphics processing units
(those based on the Kepler architecture). Hyper-Q allows CUDA kernels to be processed concurrently on the same GPU; thus benefiting performance when it
is sub -used by a single process

.. toctree::
   :caption: Versions
   :maxdepth: 1

   8.0/index

.. [1] nvidia, "MULTI-PROCESS SERVICE", Mayo del 2015.
       https://docs.nvidia.com/deploy/pdf/CUDA_Multi_Process_Service_Overview.pdf. Accedido por última vez el 11 de julio del 2017
