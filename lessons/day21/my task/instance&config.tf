resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" # AMI for Ubuntu 22.04 in us-east-1. Update if using a different region!
  instance_type = "t2.micro"
  
  # Attach the IAM Role we created above
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "CloudWatch-Agent-Demo"
  }

  # This script installs the agent and applies the config
  user_data = <<-EOF
    #!/bin/bash
    
    # 1. Install CloudWatch Agent
    wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
    dpkg -i -E ./amazon-cloudwatch-agent.deb

    # 2. Create the CloudWatch Config File
    cat <<EOT > /opt/aws/amazon-cloudwatch-agent/bin/config.json
    {
      "agent": {
        "metrics_collection_interval": 60,
        "run_as_user": "root"
      },
      "metrics": {
        "metrics_collected": {
          "disk": {
            "measurement": ["used_percent"],
            "metrics_collection_interval": 60,
            "resources": ["*"]
          },
          "mem": {
            "measurement": ["mem_used_percent"],
            "metrics_collection_interval": 60
          }
        }
      }
    }
    EOT

    # 3. Start the Agent with the config
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
    -s
  EOF
}