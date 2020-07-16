.. _apolo_user_tools:

Apolo User Tools
################

Repository structure
====================

The repository could be found at https://github.com/eafit-apolo/apolo-user-tools

The repo contains two main directories: bash-tools and src

*  **bash-tools:** Contains aliases or functions that are written in Bash. If you plan to add aliases put it in the
   file **default-aliases** in the section related with purpose of the alias. If more complex commands are needed,
   include it using another file in the same directory with a clear title.

*  **src:** Contains directories with more complex commands that are written in any language, we specially encourage
   the use of Python. The directories inside src are application-specific, e.g: slurm, ansible, file-system, etc.

   *  **application-specific:** These directories contain the different scripts that will become available commands
      to our users. These scripts could be in single files or directories. Commands in the same application-specific
      directory share the same environnement and language, libraries or other requisites. Each application-specific
      directory contains a single file that specifies these requisites, feel free to modify it.

Available Commands
==================

*  **smyqueue:** This command prints the status of the current jobs in slurm queue of the user who executed the command.
*  **sncores:** This command print the total number of cores in the system and groups it by its status (Allocated, idle and
   other).
*  **squeue-stats:** This command prints statistics about current waiting and active jobs.
*  **sqos-usage:** This command is used to check how many hours a group has used of the total available in the qos of the group (This command applies just for paid users).
*  **du-home:** This command prints the total used space in disk of the user who executed the command.

:Authors:
   - Juan David Arcila Moreno <jarcil13@eafit.edu.co>
   - Juan Diego Ocampo García <jocamp18@eafit.edu.co>
