# Devop-Projects
Devop projects for learning


DevSecOps CI/CD Pipeline on AWS

A hands-on DevSecOps learning project: a small Flask application deployed to AWS EC2 via Terraform, with a CI/CD pipeline (in progress) that runs unit tests, static analysis, container vulnerability scanning, and infrastructure security scanning before deploying.

Overview

This project exists to practice the core skills behind a real-world DevSecOps workflow without the overhead of a Kubernetes setup — source control, infrastructure as code, containerization, automated testing, and security scanning baked into the pipeline rather than bolted on afterward.

Architecture

Developer
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Unit Tests (pytest)
    ├── SonarQube Scan
    ├── Checkov Scan (Terraform)
    ├── Docker Build
    ├── Trivy Scan (container image)
    │
    ▼
Docker Image
    │
    ▼
AWS EC2 Instance
    │
    ▼
Flask Application

Tech Stack

AreaToolSource controlGitHubCI/CDGitHub ActionsApplicationFlaskContainerizationDockerCode qualitySonarQubeContainer securityTrivyIaC securityCheckovInfrastructureTerraformCloudAWS EC2

Project Structure

devsecops-flask-pipeline/
├── .gitignore
├── app/
│   ├── __init__.py
│   ├── app.py
│   └── requirements.txt
├── tests/
│   ├── __init__.py
│   └── test_app.py
├── terraform/
│   ├── .gitignore
│   ├── provider.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── security.tf
│   ├── key_pair.tf
│   ├── ec2.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── Dockerfile
└── README.md

Prerequisites


An AWS account with the CLI configured (aws configure)
Terraform >= 1.5.0
Docker
Python 3.12
An SSH key pair (Ed25519 or RSA) on your machine


Getting Started

1. Provision the infrastructure

bashcd terraform
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars: set your own ssh_allowed_cidr
terraform init
terraform plan
terraform apply

This creates a VPC, public subnet, internet gateway, security group, and a t3.micro EC2 instance running Ubuntu, with Docker pre-installed via user_data. The key pair is created automatically from your local ~/.ssh/id_ed25519.pub (see key_pair.tf) — update the path there if your key is named differently.

Once apply finishes, it prints the instance's public IP and a ready-to-use SSH command.


Note: run Terraform as your normal user, not with sudo. Running as root changes which home directory ~ expands to and can point the key pair lookup at the wrong file.



2. Run the app locally

bashcd app
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py

Visit http://localhost:5000. A /health endpoint is also available for use by deployment scripts or load balancers.

3. Run the tests

bashpytest

4. Build and run the container

bashdocker build -t flask-demo .
docker run -p 5000:5000 flask-demo

5. Tear down

When you're done experimenting, destroy the AWS resources to avoid leaving anything running unnecessarily:

bashcd terraform
terraform destroy

Security Notes

A few choices in this project are deliberate teaching points rather than oversights:


The security group allows SSH (22), HTTP (80), and the Flask dev port (5000) from 0.0.0.0/0 by default. This is intentionally left open so that Checkov flags it during the IaC scanning phase — in a real deployment, ssh_allowed_cidr should be restricted to a specific IP.
The EC2 instance enforces IMDSv2 (http_tokens = "required"), closing off a common SSRF-to-credential-theft attack path against the instance metadata service.
The root EBS volume is encrypted at rest.


Roadmap


 Terraform: VPC, security group, EC2, key pair
 Flask app with unit tests
 Dockerfile
 GitHub Actions: automated test stage
 SonarQube static analysis stage
 Checkov scan of Terraform code
 Trivy scan of the built Docker image
 Automated deployment to EC2 via SSH from the pipeline
 Stretch goal: migrate deployment target to Kubernetes with Argo CD for GitOps


License

This is a personal learning project. Use, fork, or adapt freely.
# trigger
