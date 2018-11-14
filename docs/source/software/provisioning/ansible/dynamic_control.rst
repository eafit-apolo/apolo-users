.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: raw-html(raw)
   :format: html

.. sidebar:: Contents

   .. contents::
      :local:

Tags
----

Running specific parts of a playbook, role or taskfile is what tags are all about.
Their purpose is to filter tasks based on a tag and then execute them.
Take the playbook below for example,


.. code-block:: yaml

   ---
   # /tmp/playbook.yml
   - hosts: all
     tasks:
       - name: Install emacs
	 package:
	   name: emacs-nox
	   state: installed
	 tags: good
       - name: Place emacs config file
	 copy:
	   src: .emacs
	   dest: {{ ansible_env.HOME }}
	 tags: evil
       - name: Install vim
	 package:
	   name: vim
	   state: present
	 tags: evil
       - name: Install nano
	 package:
	   name: nano
	   state: installed

you could install emacs by running:

1. :bash:`ansible-playbook /tmp/playbook.yml --tags good`
2. :bash:`ansible-playbook /tmp/playbook.yml --skip-tags evil`

The former can be understood as "only run tasks tagged as good", hence tasks one
and two will be the only ones to be executed. The latter, on the other hand, means
"run every task not tagged as evil", therefore tasks one, two AND four will be executed.


Inheritance
~~~~~~~~~~~

Tags only affect tasks; this means tagging a task, role or playbook import will only
serve the purpose of tagging all tasks within it.

.. warning::

   *include* statements DO NOT tag tasks within them. Multi-tagging only applies
   to dynamic includes, such as *import* statements.

   .. code-block:: yaml

      ---
      # Tasks within taskfile_1.yml will not be tagged,
      # but the include will.
      - include_tasks: taskfile_1.yml
	tags: tag_1

      # Tasks within taskfile_2 will be tagged, as well
      # as the import statement itself.
      - import_tasks: taskfile_2.yml
	tags: tag_2

Think of it as multi-tagging, where
declaring one tag automatically tags a set of tasks. For example, the playbook below

.. code-block:: yaml

   ---
   - hosts: all
     roles:
       - role: apache
         vars:
           ssl_port: 443
         tags:
           - web
	   - container

will tag all tasks within the role apache.

Special tags
~~~~~~~~~~~~

+----------+-------------------------------------+----------+
|    Tag   |               Meaning               | Explicit |
+----------+-------------------------------------+----------+
|  always  | always run a task; can be skipped   |    yes   |
|          | using --skip-tags always.           |          |
+----------+-------------------------------------+----------+
|   never  | never run a task, unless explicitly |    yes   |
|          | told to do so.                      |          |
+----------+-------------------------------------+----------+
|  tagged  | run tagged tasks only               |    no    |
+----------+-------------------------------------+----------+
| untagged | run untagged tasks only             |    no    |
+----------+-------------------------------------+----------+
|    all   | run all tasks (DEFAULT)             |    no    |
+----------+-------------------------------------+----------+
