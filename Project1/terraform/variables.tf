variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Name prefix used for tagging resources"
  type        = string
  default     = "devsecops-flask"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair (created in the AWS console or via `aws ec2 create-key-pair`) used for SSH access"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the instance. Defaults to open (0.0.0.0/0) on purpose so Checkov flags it in Phase 7 — override this in terraform.tfvars with your own IP/32 for real use."
  type        = string
  default     = "0.0.0.0/0"
}
