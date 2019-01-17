#!/bin/bash
# Title       : bootstrap.sh
# Description : Install and configure ansible
# Author      : Tomas Felipe Llano Rios
# Date        : Nov 21, 2018
# Usage       : bash bootstrap.sh <environment>
#==============================================================================

# tee only reads and prints from and to a file descriptor,
# so we need to use two execs to read and print from and to
# both stdout and stderr.
#
# Receive stdout, log it and print to stdout.
exec > >(tee -ia ./bootstrap_run.log)
# Receive stderr, log it and print to stderr.
exec 2> >(tee -ia ./bootstrap_run.log >&2)

declare -r env="$1"
declare -r script_path="$(readlink -e $0)"
declare -r script_dir="$(dirname $script_path)"
declare -r repo_dir="${script_dir%/*}"
declare -r cfg_file="$repo_dir/ansible.cfg"
declare -r inv_file="$repo_dir/environments/$env/inventory"

# Check if the environment provided exists within ansible's
# directory hierarchy.
declare -r envs="$(ls $repo_dir/environments/)"
if [ "$envs" != *"$env"* ]; then
    echo -e "\nUnrecognized environment. Choose from:\n$envs\n"
    exit 1
fi

# ansible-vault requires pycrypto 2.6, which is not installed by default
# on RHEL6 based systems.
declare -i centos_version=`rpm --query centos-release | awk -F'-' '{print $3}'`
if [ "$centos_version" -eq "6" ]; then
    /usr/bin/yum --enablerepo=epel -y install python-crypto2.6
fi
# Install ansible.
/usr/bin/yum --enablerepo=epel -y install ansible

# Run ansible.
export ANSIBLE_CONFIG="$cfg_file"
export DEFAULT_ROLES_PATH="$repo_dir/roles"
ansible-playbook \
    --inventory-file="$inv_file" \
    --extra-vars "env=$env repo_dir=$repo_dir" \
    --vault-id "$env@$repo_dir/scripts/vault-secrets-client.sh" \
    $repo_dir/site.yml \
    -vv
