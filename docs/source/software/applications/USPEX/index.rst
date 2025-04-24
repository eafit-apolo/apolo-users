.. _uspex:

*****
USPEX
*****

Description
-----------

USPEX (Universal Structure Predictor: Evolutionary Xtallography...and in Russian "uspekh" means "success" - owing to the
high success rate and many useful results produced by this method) is a method developed by the Oganov laboratory since 2004.
The problem of crystal structure prediction is very old and does, in fact, constitute the central problem of theoretical crystal chemistry.
In 1988 John Maddox wrote that:

"One of the continuing scandals in the physical sciences is that it remains in general impossible to predict the structure of even the
simplest crystalline solids from a knowledge of their chemical composition solids such as crystalline water (ice) are still thought to
lie beyond mortals' ken". USPEX method/code solves this problem and is used by over 3000 researchers worldwide. The First Blind Test of
Inorganic Crystal Structure Prediction shows that USPEX outperforms other methods in terms of efficiency and reliability. The method continues
to be rapidly developed. In addition to crystal structure prediction, USPEX can work in other dimensionalities and predict the structure of
nanoparticles, polymers, surfaces, interfaces and 2D-crystals. It can very efficiently handle molecular crystals (including those with flexible
and very complex molecules) and can predict stable chemical compositions and corresponding crystal structures, given just the names of the
chemical elements. In addition to this fully non-empirical search, USPEX allows one to predict also a large set of robust metastable
structures and perform several types of simulations using various degrees of prior knowledge.

USPEX can also be used for finding low-energy metastable phases, as well as stable structures of nanoparticles,
surface reconstructions, molecular packings in organic crystals, and for searching for materials with desired physical (mechanical, electronic)
properties. The USPEX code is based on an efficient evolutionary algorithm developed by A.R. Oganov's group, but also has options for using
alternative methods (random sampling, metadynamics, corrected particle swarm optimization algorithms). USPEX is interfaced with many ab initio
codes, such as VASP, SIESTA, GULP, Quantum Espresso, CP2K, CASTEP, LAMMPS, and so on.

Test of USPEX: 40-atom cell of MgSiO3 post-perovskite. Left - structure search using local optimisation of random structures, Right - evolutionary
search with USPEX. While random search did not produce the correct structure even after 120000 steps, USPEX found the stable structure in fewer
than 1000 steps.

.. toctree::
    :maxdepth: 2
    :caption: Versions

    uspex-9.4.4/index
