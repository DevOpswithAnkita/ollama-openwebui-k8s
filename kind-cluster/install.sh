#!/bin/bash
set -e
set -o pipefail

echo "Installing Docker, Kind, and kubectl..."

# Docker
if ! command -v docker &>/dev/null; then
  sudo apt-get update -y
  sudo apt-get install -y docker.io
  sudo usermod -aG docker "$USER"
  newgrp docker
else
  echo "Docker already installed."
fi

# Kind
if ! command -v kind &>/dev/null; then
  ARCH=$(uname -m)
  case "$ARCH" in
    x86_64) URL="https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-amd64" ;;
    aarch64) URL="https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
  esac
  curl -Lo ./kind "$URL"
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind
else
  echo "Kind already installed."
fi

# kubectl
if ! command -v kubectl &>/dev/null; then
  VER=$(curl -Ls https://dl.k8s.io/release/stable.txt)
  curl -LO "https://dl.k8s.io/release/${VER}/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm -f kubectl
else
  echo "kubectl already installed."
fi

# Helm installation
if ! command -v helm &>/dev/null; then
  curl -Ls https://get.helm.sh/helm-v3.13.4-linux-amd64.tar.gz -o helm.tar.gz
  tar -zxvf helm.tar.gz
  sudo mv linux-amd64/helm /usr/local/bin/helm
  rm -rf linux-amd64 helm.tar.gz
else
  echo "Helm already installed."
fi

echo "Installed versions:"
docker --version
kind --version
kubectl version --client --short
helm version
echo "Setup complete."
