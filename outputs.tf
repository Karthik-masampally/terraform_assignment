output "public_ip" {
  value = join("", ["https://", aws_instance.my_ec2_instance.public_ip])

}