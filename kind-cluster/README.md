# Kubernetes Development Environment Setup

This script automates the installation of essential Kubernetes development tools on Linux systems.

## Tools Installed

- **Docker** - Container runtime platform
- **Kind** (Kubernetes in Docker) - Tool for running local Kubernetes clusters
- **kubectl** - Kubernetes command-line tool
- **Helm** - Kubernetes package manager ("Not necessary")
 
## Prerequisites

- Linux operating system (Ubuntu/Debian-based recommended)
- `sudo` privileges
- Internet connection
- Supported architecture: `x86_64` or `aarch64` (ARM64)

## Installation

### 1. Download the Script

Save the installation script to a file (e.g., `install.sh`).

### 2. Make it Executable

```bash
chmod +x install.sh
```

### 3. Run the Script

```bash
./install.sh
```

## What the Script Does

### Docker Installation
- Checks if Docker is already installed
- Installs `docker.io` package via apt
- Adds current user to the `docker` group for non-root access
- Note: You may need to log out and log back in for group changes to take effect

### Kind Installation
- Detects system architecture (x86_64 or ARM64)
- Downloads the appropriate Kind binary (v0.29.0)
- Installs to `/usr/local/bin/kind`

### kubectl Installation
- Fetches the latest stable version automatically
- Downloads and installs kubectl for Linux AMD64
- Installs to `/usr/local/bin/kubectl`

### Helm Installation
- Downloads Helm v3.13.4
- Extracts and installs to `/usr/local/bin/helm`

## Post-Installation

After running the script, verify the installations:

```bash
docker --version
kind --version
kubectl version --client
```
### Docker Group Permissions

If you encounter Docker permission errors, you may need to:

1. Log out and log back in, or
2. Run `newgrp docker` in your current session, or
3. Restart your system

## Version Information

- Kind: v0.29.0
- kubectl: Latest stable version (auto-detected)
- Docker: Latest available from apt repository

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Kind Documentation](https://kind.sigs.k8s.io/)
- [kubectl Documentation](https://kubernetes.io/docs/reference/kubectl/)
  
## License

This setup script is provided as-is for development purposes.

## Note
This configuration automatically runs an installation script (install.sh) on instance boot using Terraform's user_data property.
```bash
user_data = file("../kind-cluster/install.sh") # installs Docker, ai, kubectl — noted
```
