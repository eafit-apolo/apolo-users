.. _ansible-troubleshooting:

.. highlight:: rst

.. role:: bash(code)
   :language: bash

.. role:: raw-html(raw)
   :format: html

Ansible Vault
-------------

Newer pycrypto required
~~~~~~~~~~~~~~~~~~~~~~~

- **Error Message/s:**

  - "ERROR: ansible-vault requires a newer version of pycrypto than the one installed on your platform"
  - "ERROR! Vault password script path/to/script returned non-zero (1): None"

- **Reproduced on:** CentOS 6
- **Software versions affected:** ansible >= 2.4
- **How to reproduce?** Download ansible's RPM from the official website and install it. Thereupon,
  try using :bash:`ansible-vault` to encrypt something and the error message shall emerge.
- **Solution:**
  Install EPEL's ansible package. It is patched to support previous versions of python-crypto (See [Kura14]_).

  .. code-block:: bash

     # Install epel repository
     yum install epel-release
     # Install pycrypto 2.6
     yum install python-crypto2.6
     # Install ansible from the EPEL repository
     yum install --enablerepo=epel ansible

Playbooks
---------

Invalid user password
~~~~~~~~~~~~~~~~~~~~~

- **Error Message/s:** None. The actual problem comes from a common misunderstanding of Ansible's *user* module.
- **Reproduced on:** CentOS 6
- **Software versions affected:** any ansible version
- **How to reproduce?** Create a playbook in which you use Ansible's *user* module to assign a password to
  any user (or just create one) and pass the password to the module's *password* argument. For example:

  .. code-block:: yaml

     ---
     - hosts: all
       tasks:
       - name:
         user:
           name: root
           password: 1234

- **Solution:** Use the password's crypted value that would normally be placed inside :bash:`/etc/shadow`. For example:

    .. code-block:: bash

       # Creating an MD5 hash using openssl
       openssl passwd -1
       Password: 1234
       Verifying - Password:
       $1$PmZtHS1g$yjx.gQWWFduYPzN/j1jdY

       # Creating a sha-256 hash using python 2
       python -c "import random,string,crypt
       randomsalt = ''.join(random.sample(string.ascii_letters,8))
       print crypt.crypt('1234', '\$6\$%s\$' % randomsalt)"
       $6$DivYqPSU$zWxSRQhe4ImWhKRFDAIu/PPG4Fp0LC3Cbv3n.wDHMaDsjF4ZSvjOt98j5/qB7ONE3trcxtGeGgZqkYIKTKKJl/

  If your playbook is under version control consider using Ansible Vault to encrypt the hash either as a
  string or placing it inside a file and subsequentially encrypting it. If using the former, DO NOT press
  the return key after writing the hash, but [Ctrl] + [d] two times instead.

.. rubric:: References

.. [Kura14] Kuratomi, Toshio:
   [ansible/el6] Fix ansible-vault for newer python-crypto dependency. fedoraproject.org, March 14 2014.
   Retrieved September 13, 2018 from https://lists.fedoraproject.org/pipermail/scm-commits/Week-of-Mon-20140310/1207203.html
