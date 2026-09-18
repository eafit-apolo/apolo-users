help([[
GNU Parallel 20260522 modulefile.
]])

whatis("Name: GNU Parallel")
whatis("Version: 20260522")
whatis("Category: utility, task execution")
whatis("Description: GNU Parallel command-line tool")

local root = "/opt/ohpc/pub/libs/gnu15/parallel/20260522"

prepend_path("PATH", pathJoin(root, "bin"))
prepend_path("MANPATH", pathJoin(root, "share/man"))
setenv("PARALLEL_HOME", pathJoin(root, "etc"))
