.. _makedepf90:

**********
Makedepf90
**********

[1]_
makedepf90 is a program for automatic creation of dependency lists and compilation rules for Makefiles.

makedepf90 supports both modules, include:s, cpp(1) #include:s, f90ppr(1) $include:s and coco(1) ??includes and set-files.

makedepf90 reads Fortran source files given on the command line, and writes a dependency list to stdout; for every file it writes a line with the following format:

   targets : prerequisites

Targets are the files that will be the result of compiling the file with the -c option, and prerequisites are files that are needed to compile the file. In addition, makedepf90 can optionally create the dependency line and make-rule needed to link the final executable.

.. toctree::
   :caption: Versions
   :maxdepth: 1

   2.8.9/index


.. [1] Edelmann, Erik. makedepf90(1) - Linux man page. Linux Documentation. Retrieved April 4, 2022, from https://linux.die.net/man/1/makedepf90
