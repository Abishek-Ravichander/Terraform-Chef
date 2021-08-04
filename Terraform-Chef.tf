resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
   vpc_security_group_ids = ["sg-0990c12803c100850"]
   key_name               = "Linux_Terraform-Chef"
   
provisioner "remote-exec" {
    inline = [
      "wget https://packages.chef.io/stable/el/7/chefdk-0.11.2-1.el7.x86_64.rpm",       
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

