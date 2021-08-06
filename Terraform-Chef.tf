resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
  # vpc_security_group_ids = ["sg-0990c12803c100850"]
   key_name               = "Linux_Terraform-Chef"
   
   network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }
   
   
provisioner "remote-exec" {
    inline = [    
       "wget -O /tmp/chef.rpm https://packages.chef.io/files/stable/chef-workstation/20.7.96/el/7/chef-workstation-20.7.96-1.el7.x86_64.rpm", #Installing chef workstation
      "sudo rpm -Uvh /tmp/chef.rpm",      
       "curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 15.8.23", #Installing Chef client
       "chef-client -v",
       "which chef",
       "sudo yum update -y",
       "sudo yum install git -y",
       "git version",       
       "mkdir mygit",
       "cd mygit",
       "git clone https://github.com/Abishek-Ravichander/Stater_Kit.git",
       "cd Stater_Kit",
       "unzip chef-starter", 
       "mv apache-cookbook chef-repo",
       "cd chef-repo",
       "mv apache-cookbook cookbooks",
       "cd cookbooks",
       " printf 'yes\n' | chef exec ruby -c apache-cookbook/recipes/apache-recipe.rb",              
     #  "sudo chef-client -zr \"recipe[apache-cookbook::apache-recipe]\"",
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
resource "aws_eip" "eip" {
  instance = aws_instance.web1.id
   vpc                       = true  
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "172.31.48.10"
 # depends_on = [    "igw-1fe83d65"  ]
  
}

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = "subnet-a24fd693"
  private_ips     = ["172.31.48.10"]
  security_groups = ["sg-0990c12803c100850"]
#172.31.48.0/20
  
}

