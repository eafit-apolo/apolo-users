
****
VASP
****

VASP is a complex package for performing ab-initio quantum-mechanical molecular dynamics (MD) simulations using
pseudopotentials or the projector-augmented wave method and a plane wave basis set. The approach implemented in VASP
is based on the (finite-temperature) local-density approximation with the free energy as variational quantity and
an exact evaluation of the instantaneous electronic ground state at each MD time step. VASP uses efficient matrix
diagonalisation schemes and an efficient Pulay/Broyden charge density mixing. These techniques avoid all problems
possibly occurring in the original Car-Parrinello method, which is based on the simultaneous integration of electronic
and ionic equations of motion. The interaction between ions and electrons is described by ultra-soft Vanderbilt
pseudopotentials (US-PP) or by the projector-augmented wave (PAW) method. US-PP (and the PAW method) allow for
a considerable reduction of the number of plane-waves per atom for transition metals and first row elements. Forces
and the full stress tensor can be calculated with VASP and used to relax atoms into their instantaneous ground-state.

.. toctree::
    :caption: Versions
    :maxdepth: 3

    v5.4.4-intel/index
    vGNU/index
    vGNUvasp/index
