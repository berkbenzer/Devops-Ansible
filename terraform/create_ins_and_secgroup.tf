provider "aws" {
  region     = "us-west-2"
  access_key = "xxxxxx"
  secret_key = "xxxxxx"
}

resource "aws_instance" "testprod" {

  ami               = "ami-XXXXX"
  instance_type     = "t2.micro"

  tags = {
    Name = "for web services"
  }
}

#### This part creates securtiy group which is not attach to instance we create abow###
resource "aws_security_group" "prod_web" {
  name 	      = "prod_web"
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
