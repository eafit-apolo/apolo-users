help("GNU Parallel 20260522 -- a shell tool for executing jobs in parallel " ..
     "using one or more computers. It is written in Perl, so the build does " ..
     "not produce natively compiled binaries.")

whatis("Name: parallel")
whatis("Version: 20260522")
whatis("Category: tools, utilities")
whatis("Keywords: parallel, shell, jobs, xargs")
whatis("URL: https://www.gnu.org/software/parallel")
whatis("Description: Shell tool for executing jobs in parallel")

local version = "20260522"
local base = "/opt/ohpc/pub/libs/gnu15/parallel/" .. version

prepend_path("PATH", pathJoin(base, "bin"))
prepend_path("MANPATH", pathJoin(base, "share/man"))
prepend_path("INFOPATH", pathJoin(base, "share/info"))

-- Silences the academic citation notice printed on first use; see the
-- "Silence the Citation Notice" section of the documentation.
setenv("PARALLEL_HOME", pathJoin(base, "etc"))
