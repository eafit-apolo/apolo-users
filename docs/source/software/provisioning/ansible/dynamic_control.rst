.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: raw-html(raw)
   :format: html

.. _sssec-ansible_tags:

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

.. _sssec-ansible_tags_inheritance:

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

.. _sssec-ansible_tags_special:

Special tags
~~~~~~~~~~~~

+----------+-------------------------------------+----------+
|    Tag   |               Meaning               | Explicit |
+==========+=====================================+==========+
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

.. _sssec-ansible_tags_example:

Example
~~~~~~~

Consider a provisioned cluster with 501 nodes (1 master, 500 slaves),
where ansible's average running time is 25 to 30 minutes.

Suppose you are given the task
of automating the creation of the folder :bash:`/scratch-local` and its
subdirectories, so that each node has a directory per scientist, named after
the convention :bash:`/scratch-local/<username>`.

In order to accomplish the task,
you intend to read the usernames from the datacenter's FreeIpa manager
and later use them to create the appropriate directories under
:bash:`/scratch-local/`:

.. code-block:: yaml

   #/tmp/scratch_local.yml
   ---
   - name: Get users from FreeIpa
     shell: ipa user-find --raw --pkey-only | awk '/uid:/{print $2}'
     register: get_users

   - name: Create dirs
     file:
       path: "/scratch-local/{{ item }}"
       state: directory
       owner: "{{ item }}"
     loop: "{{ get_users.stdout_lines }}"

Running the above taskfile will ensure all scientists have their own folder in the
specified path. You quickly realize, however, that it will take 25 to 30 minutes
for the changes to be applied and upon the creation of new user accounts
at worst 30 minutes * N° of new users (if they are not created within
ansible's run interval). So, you decide to tag the tasks:

.. code-block:: yaml

   #/tmp/playbook.yml
   ---
   - hosts: computes
     tasks:
     - import_tasks: scratch_local.yml
       tags: scratch

Finally, you tell your boss incorporating your code to the git repo holding
ansible data and running the command :bash:`ansible-playbook --tags scratch <playbook>`
will do the job without further delay.
