# vpc creation

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "my_vpc"
  }
}

#subnet creation

#public subnet

resource "aws_subnet" "my_subnet_public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "my_subnet_public"
  }
}

#private subnet

resource "aws_subnet" "my_subnet_private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    "Name" = "my_subnet_private"
  }
}

#internet gateway

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    "Name" = "my_igw"
  }
}

#route table

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    "Name" = "my_route_table"
  }
}

#route table association with subnets

resource "aws_route_table_association" "my_rt_association_public" {
  subnet_id      = aws_subnet.my_subnet_public.id
  route_table_id = aws_route_table.my_route_table.id

}
