resource "aws_instance" "web1" {
   ami           = "ami-03295ec1641924349"
   instance_type = "t2.micro"
   count = 1
   security_groups = [aws_security_group.elb.id]
 }

resource "aws_security_group" "Terraform-Chef" {
  name        = "hashitalks"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
