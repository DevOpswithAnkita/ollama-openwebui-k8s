# Public IP of EC2 (for accessing WebUI)
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance running ollama and Open WebUI"
  value       = aws_instance.ai_ec2.public_ip
}

# WebUI URL
output "webui_url" {
  description = "URL to access Open WebUI on the EC2 instance"
  value       = "http://${aws_instance.ai_ec2.public_ip}:30080"
}

# Ollama API URL
output "ollama_url" {
  description = "URL to access Ollama API (if exposed)"
  value       = "http://${aws_instance.ai_ec2.public_ip}:11434"
}