provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "javahome-tf-17102020"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
