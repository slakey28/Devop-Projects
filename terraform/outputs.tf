output "instance_public_ip" {
  description = "Elastic (static) public IP address of the EC2 instance"
  value       = aws_eip.app.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app.id
}

output "ssh_command" {
  description = "Convenience SSH command"
  value       = "ssh -i ~/.ssh/id_ed25519 ubuntu@${aws_eip.app.public_ip}"
}
