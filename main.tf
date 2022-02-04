#aws instance

resource "aws_instance" "my_ec2_instance" {
    ami = "ami-03fa4afc89e4a8a09"
    instance_type = "t2.micro"

    # vpc subnet association
    subnet_id = aws_subnet.my_subnet_public.id
  
   # security group association
   vpc_security_group_ids = [ aws_security_group.my_sg.id ]

   #the public ssh
   key_name = aws_key_pair.mykeypair.key_name

   #provisioner

   provisioner "remote_exec" {
       inline = [
           "sudo yum update -y",
           "sudo yum install httpd -y",
           "sudo service httpd start",
       ]

    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("mykeypair")
        host = "${aws_instance.my_ec2_instance.public_ip}"
    }
   
   }

}