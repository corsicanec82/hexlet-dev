# hexlet-dev

### Requirements:

- docker (local and remote)

## Setup

Perform the preparation step. Fill the generated *.env* file and *ansible/development/group_vars/all/vault_vars.yml*. You need to add variable *private_key_github_file* and encrypt file with ansible vault.

```bash
make setup
```

## Run

Prepare a remote host for work by executing a single command

```bash
make run
```
