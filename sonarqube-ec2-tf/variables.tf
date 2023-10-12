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
sudo yum install -y java-11-openjdk-devel
java -version
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.2.1.78527.zip
unzip sonarqube-10.2.1.78527.zip
sudo mv sonarqube-10.2.1.78527 /opt/sonarqube
sudo nano /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
sonar.jdbc.url=jdbc:postgresql://localhost/sonar
sudo /opt/sonarqube/bin/linux-x86-64/sonar.sh start
sudo /opt/sonarqube/bin/linux-x86-64/sonar.sh status
EOF
}