FROM quay.io/ansible/ansible-runner:stable-2.12-latest

ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV ANSIBLE_FORCE_COLOR=1

WORKDIR /app

COPY requirements.yml .

RUN ansible-galaxy install -f -r requirements.yml
