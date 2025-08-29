.. _ansible-tips_tricks:

.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: raw-html(raw)
   :format: html


Installation of multiple packages
---------------------------------

Internet often indicate using anible's pseudo looping
method to install multiple packages is the way to go.
However, this can prove to be slow due to packages being
installed one by one.

.. code-block:: yaml

   ---
   - name: Install multiple packages one by one
     yum:
       name: "{{ item }}"
       state: present
       update_cache: yes
     loop:
       - emacs
       - nano
       - vim
       - nmap
       - htop

An effective approach to install multiple packages in a
single transaction is to provide a list of their names to
the yum module:

.. code-block:: yaml

   ---
   - name: Install multiple packages in one transaction
     yum:
       name:
         - emacs
	 - nano
	 - vim
	 - nmap
	 - htop
       state: present
       update_cache: yes

User account creation
---------------------

The *user* module ensures an user is created and their password
setup properly by taking an optional *password* argument.
This argument, however, is not the actual password, as most would think,
but its hashed value. The hashing can be accomplished using
ansible's hash-filters or other tools such as openssl or python.

**Using hash-filters**

.. code-block:: yaml

   - user:
       name: username
       password: "{{ '<password>' | password_hash('sha512', '<salt>') }}"
       shell: /usr/bin/nologin

**Using openssl**

.. code-block:: bash

   openssl passwd -1 '<password>'
