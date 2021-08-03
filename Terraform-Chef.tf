resource "aws_instance" "web1" {
   ami           = "ami-03295ec1641924349"
   instance_type = "t2.micro"
   count = 1
   vpc_security_group_ids = ["sg-0990c12803c100850"]
 }

