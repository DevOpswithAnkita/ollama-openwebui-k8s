# Create infra using Terraform

This project create infra 

---

## **Prerequisites**

- Terraform >= 1.5.x
- AWS account with proper IAM permissions
- AWS CLI configured (or environment variables for access keys)

---

## **Setup Instructions**

1. **Clone the repository** (if using GitHub):
```bash
git clone https://github.com/DevOpswithAnkita/ollama-openwebui-k8s

cd Terraform/
```

2. **Initialize Terraform**:
```bash
terraform init
```

3. **Plan the deployment**:
```bash
terraform plan
```
### Error: Fixing AWS Key Pair Error in Terraform
public_key = file("../ai_ec2_key.pub")
Invalid value for "path" parameter: no file exists at "../ai_ec2_key.pub"
```bash
ssh-keygen -t rsa -b 2048 -f ../ai_ec2_key
# Creates ai_ec2_key (private) and ai_ec2_key.pub (public)
```
4. **Apply the deployment**:
```bash
terraform apply -auto-approve
```

5. **View the website URL**:
- If you have an outputs.tf file configured, run:
```bash
terraform output
```
6. **If destroy All Infra**:
```bash
terraform destroy -auto-approve
```

***Open the URL in your browser***
  ```bash
       
        webui_url = "http://public-ip:30080"
   ```
---


