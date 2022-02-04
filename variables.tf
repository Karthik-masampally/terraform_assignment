
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))

  default = [{
    cidr_block  = "0.0.0.0/0"
    description = "ingress rule for port 22"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    },
    {
      cidr_block  = "0.0.0.0/0"
      description = "ingress rule for port 443"
      from_port   = 443
      protocol    = "tcp"
      to_port     = 443
    },
    {
      cidr_block  = "0.0.0.0/0"
      description = "ingress rule for port 80"
      from_port   = 80
      protocol    = "tcp"
      to_port     = 80
    }
  ]


}
