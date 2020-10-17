# Enter the AWS Region :

variable "region" {
  default = "eu-west-2"
  # default = "ap-south-1"
}

# Enter the VPC_CIDR :
variable "cidr_block" {
  default = "192.168.0.0/16"
}
variable "F5_Password" {
default = "Admin@123@321"
}
# Enter the outside_Subnet:
variable "public_subnet" {
  type    = list
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
}

# Enter the inside_Subnet:
variable "private_subnet" {
  type    = list
  default = ["192.168.100.0/24", "192.168.101.0/24", "192.168.102.0/24"]
}

# Enter the Managment_Subnet:
variable "mgt_subnet" {
  type    = list
  default = ["192.168.200.0/24", "192.168.201.0/24", "192.168.202.0/24"]
}

# Enter the VM_IP :
variable "public_ip" {
  type    = list
  default = ["192.168.0.100", "192.168.1.100", "192.168.2.100"]
}
# Enter the VM_IP :
variable "mgt_ip" {
  type    = list
  default = ["192.168.200.100", "192.168.201.100", "192.168.202.100"]
}

# Enter the instance type t2.micro or t2.medium

variable "instance_type" {
  default = "t2.medium"
}

# Enter the EC2 AMI_ID :
variable "AMI" {
  default = "ami-03e652694fb9b1d9e" # F5 BYOL
  # default = "ami-0a669382ea0feb73a" # AMI_eu-west-2
  # default = "ami-0765d48d7e15beb93" # AWS Linux
  # default = "ami-013087c2e00d296cb" # F5 PAYG
  # default = "ami-03cfb5e1fb4fac428" # AMI_ap-south-1
}

data "aws_availability_zones" "azs" {}
