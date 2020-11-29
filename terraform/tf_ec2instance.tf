provider "aws" {
  region     = "us-west-2"
  access_key = "xxxx"
  secret_key = "xxxxx"
}

resource "aws_instance" "testprod" {

  ami               = "ami-region_image_id"
  instance_type     = "t2.micro"

}
