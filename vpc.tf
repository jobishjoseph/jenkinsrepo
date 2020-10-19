resource "aws_vpc" "javahome_vpc" {
  cidr_block     = "192.168.8.0/24"
  instance_tenancy = "default"
  tags = {
    Name = "demo1-vpc_JJ"
  }
}
