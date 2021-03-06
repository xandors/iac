# local-machine

## bash
```
echo "/opt/homebrew/bin/bash" | sudo tee -a /etc/shells
sudo chsh -s /opt/homebrew/bin/bash
```

## direnv
```
curl -sfL https://direnv.net/install.sh | bash
```

## aws cli
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

## pyenv
```
curl https://pyenv.run | bash
```

## pipenv
```
pip3 install pipenv
```

## sdkman
```
curl -s https://get.sdkman.io | bash
```

## kubectl
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/

kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl
kubectl completion bash | sudo tee /opt/homebrew/etc/bash_completion.d/kubectl
```

```
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum install -y kubectl

kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl
```

## helm
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

helm completion bash | sudo tee /etc/bash_completion.d/helm
helm completion bash | sudo tee /opt/homebrew/etc/bash_completion.d/helm
```

## helmfile
```
wget https://github.com/roboll/helmfile/releases/download/v0.142.0/helmfile_linux_amd64
mv helmfile_linux_amd64 helmfile
sudo install helmfile /usr/local/bin/
```

## aws-iam-authenticator
```
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
sudo install aws-iam-authenticator /usr/local/bin/
```

## kompose
```
curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
sudo install kompose /usr/local/bin/
```

## podman
```
https://www.redhat.com/sysadmin/podman-windows-wsl2
```

## docker
```
sudo amazon-linux-extras install docker
sudo systemctl start docker
sudo usermod -a -G docker ${USER}

sudo curl -L -o docker-compose "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)"
sudo install docker-compose /usr/local/bin/
```

## aws connect
```
pip3 install ec2instanceconnectcli
sudo yum install https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_arm64/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo apt install ./session-manager-plugin.deb
```

## ansible
```
sudo -H pip3 install ansible
ansible localhost -m ansible.builtin.setup
```

## gpg
```
keyid="alexandre.souza@fareharbor.com"
gpg --list-secret-keys
gpg --export-secret-keys -a $keyid > my_private_key.asc
gpg --export -a $keyid > my_public_key.asc
gpg --decrypt-files file.tar.gz.gpg
gpg --import my_private_key.asc
gpg --import my_public_key.asc
```

## python
```
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
```
