# Security Group
variable "ingressports" {
  type    = list(number)
  default = [9000, 22]
}

resource "aws_security_group" "sonar-sg" {
  name        = "Allow web traffic"
  description = "inbound ports for ssh and standard Sonar and everything outbound"
  dynamic "ingress" {
    for_each = var.ingressports
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"      = "Sonar-sg"
    "Terraform" = "true"
  }
}