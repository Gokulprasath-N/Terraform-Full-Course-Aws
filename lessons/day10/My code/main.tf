resource "aws_instance" "example" {
  ami           = "amzn2-ami-hvm-*-x86_64-gp2"
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"

  tags = {
    Name = "conditional-instance-${var.environment}"
  }
}

resource "aws_security_group" "name" {
 dynamic "ingress" {
    for_each = var.ingress_rule
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    } 
 }
  
}