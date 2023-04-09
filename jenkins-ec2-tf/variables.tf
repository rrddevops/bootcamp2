variable "aws_region" {
  description = "The AWS region to create things in."
  //default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile"
}

variable "ec2_user_data" {
  description = "User data script for EC2"
  type        = string
  default     = <<EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install daemonize -y
sudo yum install git -y 
sudo amazon-linux-extras install docker -y 
sudo systemctl start docker
sudo systemctl enable docker
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11
sudo yum install java-1.8.0-openjdk
java -version
sudo yum install jenkins -y
sudo usermod -aG docker jenkins 
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl restart jenkins
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
EOF
}