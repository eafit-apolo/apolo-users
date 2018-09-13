.. _ansible-index:

.. highlight:: rst

.. role:: bash(code)
    :language: bash

Ansible
=====================

Basic information
---------------------

- **Official Website:** https://www.ansible.com/
- **License:** `GNU GPL v3`_

  .. _GNU GPL v3: https://www.gnu.org/licenses/gpl-3.0.html

- **Installed on:** :ref:`Apolo II <about_apolo-ii>`,
  :ref:`Cronos <about_cronos>`

Preliminaries
---------------------

Information contained within this section elucidate the basic usage of
ansible's common features (i.e. those which, at the very least, allow
it to perform simple tasks).

.. toctree::
   :maxdepth: 2
   :numbered:

   preliminaries


Troubleshooting
---------------------

Ansible Vault
~~~~~~~~~~~~~

Newer pycrypto required
***********************

- **Error Message:** "ERROR: ansible-vault requires a newer version of pycrypto than the one installed on your platform"
- **Reproduced on:** CentOS 6
- **Software versions affected:** >= 2.4
- **How to reproduce?** Download ansible's RPM from the official website and install it. Thereupon,
  try using :bash:`ansible-vault` to encrypt something and the error message shall emerge.
- **Solution:**
  Install EPEL's ansible package, as it was applied a patch to support previous versions of python-crypto (See [FPROJ2014]_).
  
  .. code-block:: bash

     # Install epel repository
     yum install epel-release
     # Install pycrypto 2.6
     yum install python-crypto2.6
     # Install ansible from the EPEL repository
     yum install --enablerepo=epel ansible

.. rubric:: References

.. [FPROJ2014] Toshio Kuratomi.
   (March 14, 2014), "[ansible/el6] Fix ansible-vault for newer python-crypto dependency".
   fedoraproject.org.
   Retrieved September 13, 2018 from https://lists.fedoraproject.org/pipermail/scm-commits/Week-of-Mon-20140310/1207203.html
   
     
Authors
---------------------

- Tomás Felipe Llano-Rios <tllanos@eafit.edu.co>
