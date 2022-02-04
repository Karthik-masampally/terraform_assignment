#security group for instance

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    "Name" = "my_sg"
  }
}


# security group ingress rules 

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  protocol          = var.ingress_rules[count.index].protocol
  security_group_id = aws_security_group.my_sg.id
}

# security group egress rules 

resource "aws_security_group_rule" "egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_sg.id
}
