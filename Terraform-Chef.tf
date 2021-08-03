resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
   vpc_security_group_ids = ["sg-0990c12803c100850"]
   key_name               = "Linux_Terraform-Chef"
   
provisioner "remote-exec" {
    inline = [
      "wget -O /tmp/chef.rpm https://MYSERVER/chef_installers/chef-15.8.23-1.el7.x86_64.rpm",
      "rpm -Uvh /tmp/chef.rpm",
      "wget -O /tmp/base.tgz https://MYSERVER/policyfiles/base.tgz",
      "tar -C /tmp -xzf /tmp/base.tgz",
      "PWD=/tmp/base chef-client -z",
    ]
      
      connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    private_key = "${path.module}/Linux_Terraform-Chef"
    host = self.public_ip
  }
  }
      
 }

