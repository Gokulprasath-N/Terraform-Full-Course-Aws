
# 1. Fetch the default VPC using a Tag Filter
data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:Name"
    values = ["default"] # Ensure your default VPC has this tag
  }
}

# 2. Fetch a specific Subnet within that VPC
data "aws_subnet" "selected_subnet" {
  vpc_id = data.aws_vpc.selected_vpc.id
  filter {
    name   = "tag:Name"
    values = ["subnet A"] # Ensure a subnet with this tag exists
  }
}

# 3. Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 4. Create the EC2 Instance using the fetched data
resource "aws_instance" "web_server" {
  # Dynamic AMI ID
  ami           = data.aws_ami.amazon_linux_2.id 
  instance_type = "t2.micro"

  # Dynamic Subnet ID
  subnet_id     = data.aws_subnet.selected_subnet.id

  tags = {
    Name = "Gokul-EC2-Instance"
  }
  lifecycle {
    create_before_destroy = true
  }
}