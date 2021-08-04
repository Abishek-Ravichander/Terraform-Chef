resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
   vpc_security_group_ids = ["sg-0990c12803c100850"]
   key_name               = "Linux_Terraform-Chef"
   user_data = <<EOF
               #! /bin/bash
               echo "<h1>Installing Chef</h1>" | curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 15.8.23
   
provisioner "remote-exec" {
    inline = [      
       "chef verify",
       "chef --version"
    ]
      
      connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    private_key = file("${path.module}/Linux_Terraform-Chef.pem")
    host = self.public_ip
  }
  }
      
 }

