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
   variables to a particular set of hosts or subgroups.

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
      
It is impotant to highlight that there are two default groups: :bash:`all` and
:bash:`ungrouped`, which, unlike any other group, belong :

#. Hierarchically, all groups and hosts are members of :bash:`all`.

#. Hosts with no group other than all belong to :bash:`ungrouped`. Therefore, hosts
will be members of at least two groups.



Authors
---------------------

- Tomás Felipe Llano-Rios <tllanos@eafit.edu.co>
