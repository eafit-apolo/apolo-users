
*******
mrBayes
*******

Description
-------------

MrBayes is a program for Bayesian inference and model choice across a wide range of phylogenetic and evolutionary models.
MrBayes uses Markov chain Monte Carlo (MCMC) methods to estimate the posterior distribution of model parameters.

Program features include:

A common command-line interface across Macintosh, Windows, and UNIX operating systems;
Extensive help available from the command line;
Analysis of nucleotide, amino acid, restriction site, and morphological data;
Mixing of data types, such as molecular and morphological characters, in a single analysis;
Easy linking and unlinking of parameters across data partitions;
An abundance of evolutionary models, including 4x4, doublet, and codon models for nucleotide data and many of the
standard rate matrices for amino acid data;
Estimation of positively selected sites in a fully hierarchical Bayesian framework;
Full integration of the BEST algorithms for the multi-species coalescent.
Support for complex combinations of positive, negative, and backbone constraints on topologies;
Model jumping across the GTR model space and across fixed rate matrices for amino acid data;
Monitoring of convergence during the analysis, and access to a wide range of convergence diagnostics tools after
the analysis has finished;
Rich summaries of posterior samples of branch and node parameters printed to majority rule consensus trees in FigTree
format;
Implementation of the stepping-stone method for accurate estimation of model likelihoods for Bayesian model choice
using Bayes factors;
The ability to spread jobs over a cluster of computers using MPI (for Macintosh (OS X) and UNIX environments only);
Support for the BEAGLE library, resulting in dramatic speedups for codon and amino acid models on compatible hardware
(NVIDIA graphics cards);
Checkpointing across all models, allowing the user to seemlessly extend a previous analysis or recover from a system
crash;

.. toctree::
   :caption: Versions
   :maxdepth: 2

   mr.3.2.6/index
   mr.3.2.7/index
