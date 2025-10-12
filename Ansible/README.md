
# Ansible Setup and Usage Guide

This guide will help you get started with Ansible on a MacBook and run your first playbook with AWS.

---

## Prerequisites

1. **Install Ansible** on your MacBook:
   ```bash
   brew install ansible
   ```

2. **Configure AWS credentials** on your local system:
   ```bash
   aws configure
   ```
   Provide your `AWS Access Key`, `Secret Key`, `Region`, and `Output format`.

---

## Verify Installation

Check Ansible version:
```bash
ansible --version
```

---

## Project Directory

Navigate to your Ansible project directory:
```bash
cd ../Ansible 
```

---

## Test Connectivity

Ping all hosts defined in `hosts.ini`:
```bash
ansible all -i hosts.ini -m ping
```

---

## Run Playbook

Execute your Ansible playbook:
```bash
ansible-playbook -i hosts.ini ansible-playbook.yml
```

---

## Notes

- Make sure `hosts.ini` contains the correct inventory of your servers.
- Ensure AWS credentials have required permissions if your playbook interacts with AWS resources.
- You can modify the `ansible-playbook.yml` file as per your deployment requirements.
