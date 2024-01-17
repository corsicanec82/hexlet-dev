# ifneq (,$(wildcard ./.env))
# 	include .env
# 	export
# endif

UID := $(shell id -u)
GID := $(shell id -g)
IMAGE_NAME := corsicanec82/ansible-runner

prepare:
	mkdir -p tmp
	@echo "$(VAULT_PASSWORD)" > tmp/vault_password

build:
	docker build -t $(IMAGE_NAME) \
		--build-arg UID=$(UID) \
		--build-arg GID=$(GID) \
		ansible

setup: prepare build

ansible-vault-edit:
	docker run --rm -it \
	  -v $(CURDIR):/project \
	  -w /project \
	  $(IMAGE_NAME) ansible-vault edit --vault-password-file tmp/vault_password ansible/group_vars/all/vault.yml

run-playbook:
	docker run --rm -it \
		-v $(SSH_AUTH_SOCK):/ssh-agent \
		--env SSH_AUTH_SOCK=/ssh-agent \
		-v $(CURDIR):/project \
		-w /project \
		$(IMAGE_NAME) ansible-playbook ansible/${P}.yml -i ansible/inventory \
		--vault-password-file tmp/vault_password -vv

setup-dev:
	make run-playbook P=development
