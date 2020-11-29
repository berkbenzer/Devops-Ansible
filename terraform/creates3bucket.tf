provider "aws" {
  region     = "us-west-2"
  access_key = "xxx"
  secret_key = "xxxxx+xxx+xxx"
}

resource "aws_s3_bucket" "prod-tftesttoday" {
  bucket = "tf-prod-bck-today"
  acl    = "private"
}
