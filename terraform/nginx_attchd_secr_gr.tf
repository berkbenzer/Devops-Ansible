### this script creates nginx server that attached to the security group created down below.
### In order to find th public IP address of the nginx server after the creation need to run "terraform show"


provider "aws" {
  region     = "us-west-2"
  access_key = "XXXXXXXX"
  secret_key = "XXXXXXXX"
}


resource "aws_security_group" "nginx_prod" {
  name 	      = "nginx"
  description = "Allow http inbout and outbound"

  ingress{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["XXXXXX/32"]
  }
  ingress{
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["XXXXXX/32"]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["XXXXXX/32"]
  }
  tags = {
    "Terraform" : "true"
  }
}
resource "aws_instance" "prod_web_nginx" {
  ami           = "ami-ID"
  instance_type = "t2.nano"

  vpc_security_group_ids = [
    aws_security_group.nginx_prod.id
  ]

  tags = {
    "Terraform" : "true"
  }
}


