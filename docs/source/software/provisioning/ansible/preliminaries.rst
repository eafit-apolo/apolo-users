.. _ansible-preliminaries:

.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: raw-html(raw)
   :format: html

.. sidebar:: Contents

   .. contents::
      :local:

Inventory
---------------------

Ansible performs actions, also known as tasks, over a group of computers; in order to
do so it reads a plain text file called "inventory file" containing a list of
hostnames, or IP addresses, often grouped based on one or multiple shared features.

The inventory file is located by default under :bash:`/etc/ansible/hosts`
and would typically follow the conventions shown below:

#. Group names are delimited by :bash:`[` and :bash:`]`. e.g. group lbservers would be written as :bash:`[lbservers]`.
#. Hosts below a group definition are to be taken as members of it. e.g.

   .. code-block:: ini

      ; lbservers -> Group
      ; [host1,host2].example.com -> Members
      [lbservers]        
      host1.example.com
      host2.example.com

   .. figure:: src/images/inventory_example-1/inventory_example-1.png
      :alt: lbservers' components

#. Using the suffix :bash:`:children` within a group definition indicates the presence of
   nested groups (i.e. subgroups). e.g.

   .. code-block:: ini

      ; lbservers -> Group
      ; lb[south,north] -> Subgroups
      [lbservers:children]
      lbsouth
      lbnorth

   .. note::

      Subgroups are only declared as part of a parent-child relation
      (i.e. nesting depth is 1), thus implying that relations where
      nesting depth is greater than 1 require multiple declarations.

   .. code-block:: ini

      ; lbservers -> Grandparent
      ; lb[south,north] -> Children
      [lbservers:children]
      lbsouth
      lbnorth

      ; lbs[1,2].example.com -> Grandchildren
      [lbsouth:children]
      lbs1.example.com
      lbs2.example.com

#. The suffix :bash:`:vars` within a group definition is used to declare and assign
   variables to a particular set of hosts or subgroups. e.g.

   .. note::

      These variables are relative to group members and can be overwritten
      by subgroups and other ansible components (e.g. playbooks, tasks).

   .. code-block:: ini
	 
      ; lbsouth and lbnorth will inherit all
      ; variables declared within lbservers.
      [lbservers:children]
      lbsouth
      lbnorth

      [lbservers:vars]
      requests_timeout=5
      max_hosts_to_serve=10

      ; "requests_timeout" will be overwritten
      ; for lbsouth members only.
      [lbsouth:vars]
      requests_timeout=3

      ; Members of this group will not recognize
      ; variables declared for lbservers, as they
      ; do not belong to it.
      [backupservers]
      bk1.example.com
      bk2.example.com

   .. figure:: src/images/inventory_example-children/inventory_example-children.png
      :alt: lbservers' components
      
It is impotant to highlight that there are two default groups: :bash:`all` and
:bash:`ungrouped`, which, unlike any other group, can be omitted within the
inventory file, as their definitions are both implicit. Please be aware that: 

#. Hierarchically, all groups and hosts are members of :bash:`all`.

#. Hosts with no group other than all belong to :bash:`ungrouped`. Therefore, hosts
   will be members of at least two groups.

Hence, it is true for the examples above:

.. figure:: src/images/inventory_example-implicit/inventory_example-implicit.png
   :alt: lbservers' components

Modules
---------------------

A module can be interpreted as a function ansible calls from a task. Basically,
a module is the function's entire body (i.e. declaration), waiting to be
called from a task or an ansible ad-hoc command.

Playbooks
---------------------

A playbook is a text file, written in YAMl format, containing information on
which tasks to apply on which hosts. This information is contained within a
definition block called "Play". Take the following playbook for example:

.. code-block:: yaml
		
   ---
   - hosts: lbsouth
     vars:
       nginx_conf_dir: /etc/nginx/

   - hosts: lbnorth
     vars:
       nginx_conf_dir: /opt/nginx/conf
		
   - hosts: lbservers
     vars:
       max_clients: 100
     tasks:
     - name: Install/update nginx
       yum:
         name: nginx
	 state: latest
     - name: Place nginx config file
       template:
         src: templates/nginx.conf.j2
	 dest: "{{ nginx_conf_dir }}/conf/nginx.conf"
       notify:
         - restart nginx
     - name: Ensure nginx is running
       systemd:
         name: nginx
	 state: started
	 enabled: true
     handlers:
       - name: restart nginx
	 systemctl:
	   name: nginx
	   state: restarted

Plays are separated by a non-printable '\\n', thus there are three plays. Each one
uses the keyword "hosts" to describe a group, defined in the inventory file,
on which to apply some tasks and/or set variables, keywords "tasks" and "vars"
respectively.

An easy way to comprehend what a playbook is, and why it is useful, is thinking on
what would one need to do in scripting languages, like bash, to accomplish what
a playbook is meant to. Take the task "Place nginx config file". It calls
Ansible's :bash:`template` module, which creates a file based
on a Jinja2 template. Hence, one could either use templates alongside bash, which
becomes complex and difficult to maintain really fast, use an exernal software to
parse them, like ruby :bash:`erb` or python + Jinja2, or manage static
files. Thereupon, additional concerns arise: how to deliver
files to lbservers' hosts?, how to manage variables within them?, etc. Basically,
these questions represent steps to achieve something specific (for the task under
consideration, place a file called :bash:`nginx.conf`, whose content may vary,
on all hosts within lbservers) that can be interpreted as to lead a system to a
desired state. e.g.

- Original state: lbservers' hosts not having :bash:`nginx.conf`
- Desired state: lbservers' hosts having :bash:`nginx.conf`

A playbook can be, therefore, defined as the abstraction of a system's final state,
comprised of intermediate states represented by tasks.
Sort of an assembly line analogy:

.. figure:: src/images/McDonalds-Assembly-Line.jpg
   :alt: McDonald's assembly line

   McDonald's assembly line. Retrieved august 28, 2018 from https://slideplayer.com/slide/9882222/

Task 1 would represent an ansible run being triggered, tasks 2 to 5 the system's pass
through each intermediate state
(i.e. bun toasted, bun assembled with condiments, patty wrapped,
Order placed on heated landing pad) and task 6 the desired state (i.e. customer satisfied).

Roles
---------------------
A role is a hierarchical directory structure intended to decouple playbooks
by breaking them into multiple files, which is particularly useful to
create reusable components and write simpler playbooks.
A role's layout would typically look as below:

.. note::
   
   There are more directories than those listed below. See `Ansible's official documentation`_
   for more information.

.. _`Ansible's official documentation`: https://docs.ansible.com/ansible/2.5/user_guide/playbooks_reuse_roles.html
    
.. code-block:: bash
		    
   roles/
     common/
       tasks/
       handlers/
       files/
       templates/
       vars/

Let us elucidate on how playbooks can be decoupled by using the notion of a role. Take the
example on the `Playbooks`_ section.

#. Identify a common feature within your tasks. For example, all tasks on the
   third play are related to nginx.

#. Use that common feature as a base to name your role and create a directory
   under :bash:`$ANSIBLE_HOME/roles`.

   .. note::

      :bash:`$ANSIBLE_HOME` is used as a way to represent ansible's folder
      location within the filesystem (e.g. /etc/ansible), which
      may vary depending on the setup.

   .. code-block:: bash

      mkdir -p  $ANSIBLE_HOME/roles/nginx

#. TODO: Decouple vars  
      
#. Decouple tasks by placing them in taskfiles. As the name implies, a taskfile is
   a file containing task declarations; this files are often stored under
   :bash:`$ANSIBLE_HOME/roles/<role>/tasks` and their name is irrelevant exept
   for :bash:`main.yml`, which must always be present. Although tasks can be all defined
   inside :bash:`main.yml`, it is recommended to declare them in different taskfiles,
   when their number is large enough to make a coupled taskfile difficult to read, and then
   call each one from :bash:`main.yml`.

   .. code-block:: yaml

      # $ANSIBLE_HOME/roles/nginx/tasks/packages.yml
      ---
      - name: Install/update nginx
	yum:
	  name: nginx
	  state: latest

   .. code-block:: yaml

      # $ANSIBLE_HOME/roles/nginx/tasks/config.yml
      ---		   
      - name: Place nginx config file
       template:
         src: templates/nginx.conf.j2
	 dest: "{{ nginx_conf_dir }}/conf/nginx.conf"
       notify:
         - restart nginx
	   
      - name: Ensure nginx is running
	systemd:
          name: nginx
	  state: started
	  enabled: true

   .. code-block:: yaml

      # $ANSIBLE_HOME/roles/nginx/tasks/main.yml
      ---
      - name: "Including taskfile {{ taskfile }}"
	include_tasks: " {{ taskfile }}  "
	with_items:
	  - 'packages.yml'
	  - 'config.yml'
	loop_control:
	  loop_var: taskfile

#. TODO: Decouple handlers	  

#. TODO: Decouple templates
