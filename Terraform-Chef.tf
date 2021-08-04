resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
   vpc_security_group_ids = ["sg-0990c12803c100850"]
   key_name               = "Linux_Terraform-Chef"
   
   
provisioner "remote-exec" {
    inline = [    
       "wget -O /tmp/chef.rpm https://packages.chef.io/files/stable/chef-workstation/20.7.96/el/7/chef-workstation-20.7.96-1.el7.x86_64.rpm",
      "sudo rpm -Uvh /tmp/chef.rpm",      
       "curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 15.8.23",
       "chef-client -v",
       "which chef",
       
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

