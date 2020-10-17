provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "javahome-tf-17102020"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
