resource "aws_vpc" "javahome_vpc" {
  cidr_block     = "192.168.0.0/24"
  instance_tenancy = "default"
  tags = {
    Name = "demo-vpc"
  }
}
