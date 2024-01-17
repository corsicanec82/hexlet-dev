# hexlet-dev

### Requirements:

- docker (local and remote)

## Setup

Perform the preparation step. Set password for ansible-vault to VAULT_PASSWORD evironment variable.

```bash
make setup
```

Fill needed variables in vault file

```bash
make ansible-vault-edit
```

## Run

Prepare a remote host for work by executing a single command

```bash
make setup-dev
```
