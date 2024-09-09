# Ansible Collection - mojaloop.iac

This document provides instructions for installing an Ansible collection from a Git repository and running a playbook to deploy the Mojaloop Control Center.

## Step 1: Install the Ansible Collection

To install the required Ansible collection from a Git repository, use the following command:

```bash
ansible-galaxy collection install git+https://github.com/mojaloop/iac-ansible-collection-roles.git#/mojaloop/iac,main
```

Explanation:

- `ansible-galaxy collection install`: Command to install Ansible collections, in this example from a Git repository.
- `git+https://github.com/mojaloop/iac-ansible-collection-roles.git`: Specifies the Git repository URL containing the Ansible collection.
- `#/mojaloop/iac`: Defines the subdirectory path in the repository where the collection is located.
- `main`: Indicates the branch of the Git repository to use for installation.

## Step 2: Run the Ansible Playbook

After installing the required Ansible collection, run the playbook to create resources using the following command:

```bash
ansible-playbook mojaloop.iac.control_center_deploy -i /iac-run-dir/output/inventory
```

Explanation:

- `ansible-playbook`: Command to run an Ansible playbook.
- `mojaloop.iac.control_center_deploy`: Specifies the playbook to deploy the Mojaloop Control Center. The playbook name is prefixed by the collection namespace (mojaloop.iac), which is required when the playbook is part of a collection.
- `-i /iac-run-dir/output/inventory`: Defines the inventory file location, which contains the list of hosts where the playbook will be executed.
