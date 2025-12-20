provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# 1. Create the IAM Role
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2_cloudwatch_governance_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 2. Attach the "CloudWatchAgentServerPolicy" (Allows sending metrics/logs)
resource "aws_iam_role_policy_attachment" "cw_agent_policy" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# 3. Attach S3 Access (Optional, if you want EC2 to access the bucket)
resource "aws_iam_role_policy_attachment" "s3_access_policy" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # Use ReadOnly if full access isn't needed
}

# 4. Create Instance Profile (To attach the role to EC2)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_cloudwatch_profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}