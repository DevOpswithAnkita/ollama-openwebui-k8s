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
git clone https://github.com/DevOpswithAnkita/

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

4. **Apply the deployment**:
```bash
terraform apply -auto-approve
```

5. **View the website URL**:
- If you have an outputs.tf file configured, run:
```bash
terraform output
```

***Open the URL in your browser***
  ```bash
       
        webui_url = "http://public-ip:30080"
   ```
---


