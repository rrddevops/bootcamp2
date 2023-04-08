resource "aws_key_pair" "eks-key-pair" {
key_name = "eks-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "eks-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "eks-key-pair.pem"
}