.. _wps:

Wps
===

The WRF [1]_ Preprocessing System (WPS) is a set of three programs whose collective
role is to prepare input to the real.exe program for real-data simulations. Each of
the programs performs one stage of the preparation: geogrid defines model domains
and interpolates static geographical data to the grids; ungrib extracts meteorological
fields from GRIB-formatted files; and metgrid horizontally interpolates the
meteorological fields extracted by ungrib to the model grids defined by geogrid.
The work of vertically interpolating meteorological fields to WRF eta levels is
now performed within the real.exe program, a task that was previously performed by
the vinterp program in the WRF SI.

.. toctree::
   :caption: Versions
   :maxdepth: 1

   wps-3.7.1/index

.. [1] Description taken from http://www2.mmm.ucar.edu/wrf/users/docs/user_guide/users_guide_chap3.html#_Function_of_Each
