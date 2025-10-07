variable "aws_region" { default = "us-east-1" }
variable "availability_zones" { default = ["us-east-1a", "us-east-1b", "us-east-1c"] }
variable "ami_id" { default = "ami-0360c520857e3138f" }  # Ubuntu 22.04 LTS for us-east-1
variable "instance_type" { default = "t3.medium" }
variable "key_name" { default = "ai_key" }           # AWS key pair name
variable "private_key_path" { default = "../ai_ec2_key.pem" } # Local private key file path
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "subnet_cidr" { default = [ "10.0.1.0/24" ] }


