#aws eip

resource "aws_eip" "my_eip" {
  vpc = true
}

#nat gateway

resource "aws_nat_gateway" "my_nat_gtw" {
  subnet_id     = aws_subnet.my_subnet_public.id
  allocation_id = aws_eip.my_eip.id
  tags = {
    "Name" = "my_nat_gtw"
  }
  depends_on = [aws_internet_gateway.my_igw]
}

#vpc setup for NAT gateway

resource "aws_route_table" "my_rt_private" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat_gtw.id
  }
  tags = {
    "Name" = "my_private_rt"
  }
}

# route assosciation private

resource "aws_route_table_association" "my_rt_association_private" {
  subnet_id      = aws_subnet.my_subnet_private.id
  route_table_id = aws_route_table.my_rt_private.id

}