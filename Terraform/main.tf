provider "aws" {
  region = var.aws_region
}


# Key Pair

resource "aws_key_pair" "ai_key" {
  key_name   = var.key_name
  public_key = file("../ai_ec2_key.pub") # ensure this file exists
}


# VPC

resource "aws_vpc" "ai_vpc" {
  cidr_block = var.vpc_cidr
  tags = { Name = "ai-vpc" }
}


# Internet Gateway + Routing

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ai_vpc.id
  tags   = { Name = "ai-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ai_vpc.id
  tags   = { Name = "ai-public-rt" }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


# Public Subnet

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.ai_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[0]
  tags = { Name = "ai-public" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


# Security Group

resource "aws_security_group" "ai_sg" {
  name        = "ai-sg"
  vpc_id      = aws_vpc.ai_vpc.id
  description = "Allow SSH, HTTP (30080) and Ollama (11434)"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 11434
    to_port     = 11434
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "ai-sg" }
}


# EC2 Instance (Single Node for ai)

resource "aws_instance" "ai_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ai_key.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ai_sg.id]
  associate_public_ip_address = true
  # Run install.sh on boot
  user_data = file("../kind-cluster/install.sh") # installs Docker, ai, kubectl

  tags = {
    Name = "ai-ec2"
    Project = "OpenWebUI-Ollama"
  }
   root_block_device {
    volume_size = 200
    volume_type = "gp3"
  }

  }

