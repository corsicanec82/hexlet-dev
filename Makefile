ifneq (,$(wildcard ./.env))
	include .env
	export
endif

IMAGE_NAME := corsicanec82/ansible-runner

prepare:
	cp -n .env.example .env
	mkdir tmp || true
	echo "$(VAULT_PASSWORD)" > tmp/vault_password

build:
	docker build \
		-t $(IMAGE_NAME) \
		ansible

setup: prepare build

setup-dev:
	docker run --rm \
		-v $(CURDIR):/app \
		-v $(HOME)/.ssh/$(SSH_KEY):/root/.ssh/$(SSH_KEY) \
		--env-file .env \
		$(IMAGE_NAME) \
		ansible-playbook --vault-password-file tmp/vault_password ansible/development.yml -i ansible/development -vv

bash:
	docker run --rm -it \
		-v $(CURDIR):/app \
		-v $(HOME)/.ssh/$(SSH_KEY):/root/.ssh/$(SSH_KEY) \
		--env-file .env \
		$(IMAGE_NAME) \
		/bin/bash
