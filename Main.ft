
# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.

provider "aws" {
  region = var.region
}

# VPC Creation:
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}

# Public_subnet creation:
resource "aws_subnet" "public_subnet" {
  count             = length(data.aws_availability_zones.azs.names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet, count.index)
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  tags = {
    name = "subnet-(count.index+1)"
  }
}

# # Private_subnet creation:
resource "aws_subnet" "private_subnet" {
  count             = length(data.aws_availability_zones.azs.names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet, count.index)
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  tags = {
    name = "subnet-(count.index+1)"
  }
}

# # mgt_subnet creation:
resource "aws_subnet" "mgt_subnet" {
  count             = length(data.aws_availability_zones.azs.names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.mgt_subnet, count.index)
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  tags = {
    name = "subnet-(count.index+1)"
  }
}


# public_subnet creation:
resource "aws_network_interface" "public_ip_nic" {
  count           = length(var.public_ip)
  subnet_id       = aws_subnet.public_subnet[count.index].id
###private_ip      = length(var.public_ip) > 0 ? element(concat(var.public_ip, list("")), count.index) : ""
 security_groups = [aws_security_group.f5.id]
  tags = {
    Name = "public_network_interface"
  }
}


# # Private_IP creation:
resource "aws_network_interface" "private_ip_nic" {
  count           = length(var.private_subnet)
  subnet_id       = aws_subnet.private_subnet[count.index].id
  security_groups = [aws_security_group.f5.id]
  tags = {
    Name = "private_network_interface"
  }
}
# # mgt_IP creation:
resource "aws_network_interface" "mgt_subnet" {
  count     = length(var.mgt_subnet)
  subnet_id = aws_subnet.mgt_subnet[count.index].id
  #private_ip = length(var.mgt_ip) > 0 ? element(concat(var.mgt_ip, list("")), count.index) : ""
  #private_ip = length(var.mgt_ip) > 0 ? element(concat(var.mgt_ip, list("")), count.index) : ""
  security_groups = [aws_security_group.f5.id]
  tags = {
    Name = "private_network_interface"
  }
}


# data "template_file" "init" {
#   template = "${file("Scripts/config.tmpl")}"
#   vars = {
#     PASSWORD = "${var.F5_Password}"
#   }
# }

# EC2 creation:
resource "aws_instance" "example" {
  ami                         = var.AMI
  instance_type               = (var.instance_type)
  count                       = length(data.aws_availability_zones.azs.names)
  availability_zone           = element(data.aws_availability_zones.azs.names, count.index)
  subnet_id                   = aws_subnet.public_subnet[count.index].id
  private_ip                  = element(var.public_ip, count.index)
  associate_public_ip_address = true
  user_data                   = "${file("Scripts/config.tmpl")}"

  vpc_security_group_ids      = ["${aws_security_group.f5.id}"]
  key_name                    = "F_5_key"



  tags = {
    Name = element(data.aws_availability_zones.azs.names, count.index)

  }
}


data "template_file" "user_data" {
  template = "userdata.tpl"
}

# private_subnet attachment:
resource "aws_network_interface_attachment" "private_nic" {
  count                = length(var.private_subnet)
  instance_id          = (aws_instance.example[count.index].id)
  network_interface_id = aws_network_interface.private_ip_nic[count.index].id
  device_index         = 1
  
  
}


# # # mgt-subnet: attachement:
resource "aws_network_interface_attachment" "mgt_nic" {
 count                = length(var.mgt_subnet)
  instance_id          = (aws_instance.example[count.index].id)
  network_interface_id = aws_network_interface.mgt_subnet[count.index].id
  device_index         = 2
  
}

# ELB creation :ter 

//target group:

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}
resource "aws_route_table" "Private" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(data.aws_availability_zones.azs.names)
  subnet_id      = aws_subnet.public_subnet.* [count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "mgt" {
  count          = length(data.aws_availability_zones.azs.names)
  subnet_id      = aws_subnet.mgt_subnet.* [count.index].id
  route_table_id = aws_route_table.Private.id
}
resource "aws_route_table_association" "private" {
  count          = length(data.aws_availability_zones.azs.names)
  subnet_id      = aws_subnet.private_subnet.* [count.index].id
  route_table_id = aws_route_table.Private.id
}

resource "aws_key_pair" "F_5_key" {
  key_name   = "F_5_key-1"
  public_key = "${file("Scripts/web.pub")}"
}
