# 1. Create Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_server_sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Data Source for AMI (Amazon Linux 2)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 3. Create EC2 Instance
resource "aws_instance" "web_server" {
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "Child-Module-Instance"
  }
}