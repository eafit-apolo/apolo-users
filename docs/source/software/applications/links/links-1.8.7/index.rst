.. links-1.8.7:

.. role:: bash(code)
   :language: bash

LINKS 1.8.7
===========

Basic information
-----------------

- **Deploy date:** 22 October 2019
- **Official Website:** https://github.com/bcgsc/abyss
- **License:** GNU GPL v3
- **Installed on:** :ref:`Apolo II <about_apolo-ii>`
- **Dependencies:**
    - GCC
    - Perl

Installation
------------
#. Make sure you have GCC and Perl installed, then run:

    .. code-block:: bash

        $ git clone https://github.com/bcgsc/LINKS.git
        $ cd LINKS/releases/links_v1.8.7
        $ tar xvf lib.tar.gz
        $ cd lib/
        $ rm -rf bloomfilter
        $ git clone git://github.com/bcgsc/bloomfilter.git
        $ cd bloomfilter/swig
        $ module load gcc/5.4.0
        $ module load perl/5.26.1_gcc-4.4.7
        $ swig -Wall -c++ -perl5 BloomFilter.i
        $ g++ -std=c++11 -c BloomFilter_wrap.cxx -I/share/apps/perl/5.26.1_gcc-4.4.7/lib/5.26.1/x86_64-linux-thread-multi-ld/CORE -fPIC -Dbool=char -O3 -mavx2
        $ g++ -std=c++11 -Wall -shared BloomFilter_wrap.o -o BloomFilter.so -O3 -mavx2
        $ ./test.pl

    Make sure the tests run correctly. Then install it:

    .. code-block:: bash

        # Go back to the links 1.8.7 root directory
        $ cd ../../../
        $ rm lib.tar.gz

        $ mkdir -p /share/apps/links/1.8.7/gcc/5.4.0

        # There is no installation script, so install it manually
        $ cp -r ./* /share/apps/links/1.8.7/gcc/5.4.0/

#. Create and place the needed module file. Create a file with the following content:

    .. literalinclude:: src/1.8.7_gcc-5.4.0_perl-5.26.1
        :language: bash
        :caption: :download:`1.8.7_gcc-5.4.0_perl-5.26.1 <src/1.8.7_gcc-5.4.0_perl-5.26.1>`

    Create the needed folder and place it:

    .. code-block:: bash

        $ sudo mkdir /share/apps/modules/links
        $ sudo mv 1.8.7_gcc-5.4.0_perl-5.26.1 /share/apps/modules/links/


Troubleshooting
---------------
There is a problem compiling with GCC 7.4.0, it seems like a problem with some
instructions that are not supported by the C++ standard that GCC 7.4.0 implements.
So, try using GCC 5.4.0.

Authors
-------

- Hamilton Tobon-Mosquera <htobonm@eafit.edu.co>
