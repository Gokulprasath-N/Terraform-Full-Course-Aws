# 1. Create Security Group for SSH
resource "aws_security_group" "web_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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

# 2. Create EC2 Instance with Provisioners
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu AMI (Update for your region)
  instance_type = "t2.micro"
  key_name      = "my-key-pair"           # Ensure you have this key pair created in AWS
  security_groups = [aws_security_group.web_sg.name]

  # CONNECTION BLOCK: Required for remote-exec and file provisioners
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/my-key-pair.pem") # Path to your private key
    host        = self.public_ip
  }

  # PROVISIONER 1: FILE
  # Copy a local script to the remote server
  provisioner "file" {
    source      = "scripts/install_nginx.sh"
    destination = "/tmp/install_nginx.sh"
  }

  # PROVISIONER 2: REMOTE-EXEC
  # Execute commands on the remote server
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_nginx.sh",
      "/tmp/install_nginx.sh", # Run the script we just copied
      "echo 'Remote execution completed!'"
    ]
  }

  # PROVISIONER 3: LOCAL-EXEC
  # Execute a command on your local machine
  provisioner "local-exec" {
    command = "echo 'Instance ${self.public_ip} created successfully!' >> instance_ips.txt"
  }
}