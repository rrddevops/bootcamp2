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
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install -y java-11-openjdk-devel
java -version
sudo amazon-linux-extras install postgresql10 -y
sudo yum install -y postgresql-server postgresql-devel
sudo /usr/bin/postgresql-setup --initdb
sudo systemctl start postgresql
sudo -u postgres psql -c "CREATE DATABASE sonar;"
sudo -u postgres psql -c "CREATE USER sonar WITH PASSWORD 'sonar';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonar TO sonar;"
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.2.1.78527.zip
unzip sonarqube-10.2.1.78527.zip
sudo mv sonarqube-10.2.1.78527 /opt/sonarqube
sudo bash -c 'echo sonar.jdbc.username=sonar >> /opt/sonarqube/conf/sonar.properties'
sudo bash -c 'echo sonar.jdbc.password=sonar >> /opt/sonarqube/conf/sonar.properties'
sudo bash -c 'echo sonar.jdbc.url=jdbc:postgresql://localhost/sonar >> /opt/sonarqube/conf/sonar.properties'
sudo /opt/sonarqube/bin/linux-x86-64/sonar.sh start
sudo /opt/sonarqube/bin/linux-x86-64/sonar.sh status
EOF
}