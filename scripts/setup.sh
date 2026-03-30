#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y curl unzip jq git

# AWS CLI v2
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
unzip -q /tmp/awscliv2.zip -d /tmp
/tmp/aws/install
rm -rf /tmp/aws /tmp/awscliv2.zip

# kubectl (latest stable)
KUBECTL_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)
curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

# OpenTofu
curl -fsSL https://get.opentofu.org/install-opentofu.sh | bash -s -- --install-method deb

# gotemplate
GOTEMPLATE_VERSION=$(curl -fsSL https://api.github.com/repos/coveooss/gotemplate/releases/latest | jq -r '.tag_name' | sed 's/^v//')
curl -fsSL "https://github.com/coveooss/gotemplate/releases/download/v${GOTEMPLATE_VERSION}/gotemplate_${GOTEMPLATE_VERSION}_linux_amd64.zip" -o /tmp/gotemplate.zip
unzip -q /tmp/gotemplate.zip -d /tmp/gotemplate
find /tmp/gotemplate -name "gotemplate" -type f -exec mv {} /usr/local/bin/gotemplate \;
chmod +x /usr/local/bin/gotemplate
rm -rf /tmp/gotemplate /tmp/gotemplate.zip

# Nullplatform CLI
curl -fsSL https://cli.nullplatform.com/latest/np-Linux-amd -o /usr/local/bin/np
chmod +x /usr/local/bin/np

echo "Setup complete" > /var/log/training-setup.log
