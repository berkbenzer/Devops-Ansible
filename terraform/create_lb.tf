provider "aws" {
  region     = "us-west-2"
  access_key = "XXXXX"
  secret_key = XXXXX
}

resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone  = "us-west-2a"
  tags = {
    "Terraform" : "true"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone  = "us-west-2b"
  tags = {
    "Terraform" : "true"
  }
}

resource "aws_security_group" "nginx_prod" {
  name 	      = "nginx"
  description = "Allow http inbout and outbound"

  ingress{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["1000000"]
  }
  ingress{
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["1000000"]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1000000"]
 }
  tags = {
    "Terraform" : "true"
  }
}
resource "aws_instance" "prod_web_nginx" {
  count         = 2

  ami           = "ami-XXXXXXX"
  instance_type = "t2.nano"

  vpc_security_group_ids = [
    aws_security_group.nginx_prod.id
  ]

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_eip_association" "prod_web_nginx" {
  count = 2
  instance_id   = aws_instance.prod_web_nginx.0.id
  allocation_id = aws_eip.prod_web_nginx.0.id
}

resource "aws_eip" "prod_web_nginx"{
  count = 2
  instance = aws_instance.prod_web_nginx.0.id

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_elb" "prod_web_nginx" {

  name            = "nginx-load-balancer"
  instances       = aws_instance.prod_web_nginx.*.id
  subnets         = [aws_default_subnet.default_az1.id , aws_default_subnet.default_az2.id]
  security_groups = [aws_security_group.nginx_prod.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  tags = {
    "Terraform" : "true"
  }
}

