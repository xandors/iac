# docker build -t docker-ide . --platform linux/amd64
# docker run --rm -it --name provisioning -h provisioning -v $HOME/projects/provisioning:/workspace -v $HOME/.ssh:/root/.ssh -v $HOME/.aws:/root/.aws -w /workspace --platform linux/amd64 docker-ide /bin/bash
# /workspace/vault/login.sh -r read-secrets
FROM ubuntu:20.04

ARG TINI_VERSION='0.19.0'
ARG TF_VERSION='0.13.5'

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update \
    && apt-get install -y \
        # Base
        build-essential software-properties-common \
        # Essential
        wget tar unzip git curl nano man htop bash-completion net-tools openssh-server socat gnupg2 \
        # GUI
        libgtk2.0-0 libcanberra-gtk-module libxext6 libxrender1 libxtst6 libxslt1.1 dmz-cursor-theme \
        # for VsCode
        libxcb-dri3-0 libdrm-dev libgbm-dev \
        # for Chromium
        libgtk-3-0 libatk-bridge2.0-0 libx11-xcb1 libnss3 libxss1 \
        # for JetBrains
        libxshmfence-dev \
        # for Python 3
        python3 python3-pip
# Ansible
RUN add-apt-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y ansible
# HashCorp
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update
RUN apt-get install -y vault \
    && apt-get remove -y vault \
    && apt-get install -y terraform=${TF_VERSION} packer vault
# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN mkdir -p ~/.ssh \
    && ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts \
    && echo "alias read-secrets='/workspace/vault/login.sh -r read-secrets'" >> ~/.bash_aliases

ENTRYPOINT ["/tini", "--"]

CMD ["sleep", "infinity"]
