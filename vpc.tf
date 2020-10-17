resource "aws_vpc" "javahome_vpc" {
  cidr_block     = "192.168.1.0/24"
  instance_tenancy = "default"
  tags = {
    Name = "demo-vpc_JJ"
  }
}
