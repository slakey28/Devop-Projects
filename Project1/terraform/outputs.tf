output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app.id
}

output "ssh_command" {
  description = "Convenience SSH command"
  value       = "ssh -i (~/.ssh/your public key) ubuntu@${aws_instance.app.public_ip}"
}
