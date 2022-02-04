#ebs vloume

resource "aws_ebs_volume" "my_ebs" {
  availability_zone = "ap-south-1"
  size = 40

  tags = {
    "Name" = "my_ebs"
  }
}

#ebs volume attachment to instance

resource "aws_volume_attachment" "my_ebs_attachment" {
    device_name = "/dev/xvda"
    volume_id = aws_ebs_volume.my_ebs.id
    instance_id = aws_instance.my_ec2_instance.id 
}