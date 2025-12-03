variable "environment" {
 description = "test"
 type = string
 default = "DevOpsLearners"
  
}

variable "ingress_rule" {
  description = "lest of ingress rule for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)

  }))
  default = [ {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0:0:0:0/0" ]
    description = "allow HTTP traffic"
  } 
  ,{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0:0:0:0/0" ]
    description = "allow SSH traffic"
  }
  ]

}

locals {
  
  instavces =aws_instance.example[*].id
  
}