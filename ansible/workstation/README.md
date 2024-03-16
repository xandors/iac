# local-machine

## bash
```
echo "/opt/homebrew/bin/bash" | sudo tee -a /etc/shells
sudo chsh -s /opt/homebrew/bin/bash
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
```
# podman machine init
Downloading VM image: fedora-coreos-36.20220906.2.0-qemu.aarch64.qcow2.xz: done
Extracting compressed file
Image resized.
Machine init complete
To start your machine run:

        podman machine start

alex@AlexMac /Users/alex/projects/xandors/iac/bitcoin (main):
# podman machine start
Starting machine "podman-machine-default"
Waiting for VM ...
Mounting volume... /Users/alex:/Users/alex

This machine is currently configured in rootless mode. If your containers
require root permissions (e.g. ports < 1024), or if you run into compatibility
issues with non-podman clients, you can switch using the following command:

        podman machine set --rootful

API forwarding listening on: /Users/alex/.local/share/containers/podman/machine/podman-machine-default/podman.sock

The system helper service is not installed; the default Docker API socket
address can't be used by podman. If you would like to install it run the
following commands:

        sudo /opt/homebrew/Cellar/podman/4.2.1/bin/podman-mac-helper install
        podman machine stop; podman machine start

You can still connect Docker API clients by setting DOCKER_HOST using the
following command in your terminal session:

        export DOCKER_HOST='unix:///Users/alex/.local/share/containers/podman/machine/podman-machine-default/podman.sock'

Machine "podman-machine-default" started successfully
```

## docker
```
sudo amazon-linux-extras install docker
sudo systemctl start docker
sudo usermod -a -G docker ${USER}
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

## multipass
```
multipass launch 22.04 -c 2 -d 50G -m 4G --mount $HOME:Home -n primary

multipass launch 20.04 -c 2 -d 50G -m 8G --mount $HOME:/media/home -n fareharbor --cloud-init - <<EOF
users:
  - default
  - name: alex
    gecos: Alexandre Souza
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    shell: /bin/bash
    ssh_import_id: None
    lock_passwd: true
    ssh_authorized_keys:
      - $(cat ~/.ssh/id_rsa.pub)
package_update: true
package_upgrade: true
EOF
```

## nvm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

## docker-slim
```
curl -sL https://raw.githubusercontent.com/docker-slim/docker-slim/master/scripts/install-dockerslim.sh | sudo -E bash -
```

## amzn2 snap
```
cd /etc/yum.repos.d && sudo wget https://people.canonical.com/~mvo/snapd/amazon-linux2/snapd-amzn2.repo
sudo yum update
sudo yum install snapd
sudo systemctl enable --now snapd.socket
```

## amzn2 increase volume
```
sudo lsblk
sudo growpart /dev/nvme0n1 1
sudo lsblk
df -hT
sudo xfs_growfs -d /
df -hT
```

## ES Kibana Proxy
```
npm install -g aws-es-kibana
```

## sshuttle
```
sshuttle --sudoers-no-modify > sshuttle_auto; sudo mv sshuttle_auto /etc/sudoers.d/sshuttle_auto; sudo chown root /etc/sudoers.d/sshuttle_auto
```