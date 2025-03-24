#!/usr/bin/env bash
set -e

# echo "Installing Docker..."
# sudo apt-get update
# sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) stable"
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# # Allow current user to run Docker without sudo
# sudo usermod -aG docker $USER

echo "Installing Kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "Installing Kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L \
  https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "Installing K9s..."
K9S_VERSION="v0.27.4"
curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz
tar -xf k9s.tar.gz
chmod +x k9s
sudo mv k9s /usr/local/bin/
rm k9s.tar.gz

echo "Installation completed!"
echo "Please log out and log back in or run 'newgrp docker' to use Docker without sudo."
