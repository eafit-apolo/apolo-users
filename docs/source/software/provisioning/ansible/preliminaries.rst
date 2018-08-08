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
hostnames, or IP addresses, often groupped based on one or multiple shared features.

The inventory file is located by default under :bash:`/etc/ansible/hosts`
and would typically follow the conventions shown below:

#. Group names are delimited by :bash:`[` and :bash:`]`. e.g. group lbservers would be written as [lbservers].
#. Hosts below a group definition are to be taken as members of it. e.g.

   .. code-block:: yaml

      [lbservers]        # <- Group
      host1.example.com  # <- Member
      host2.example.com  # <- Member

#. Using the suffix :bash:`:children` within a group definition indicates the presence of
   subgroups.

Authors
---------------------

- Tomás Felipe Llano-Rios <tllanos@eafit.edu.co>
