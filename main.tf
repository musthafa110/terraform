provider "aws" {
  region = "ap-south-1"  # Correct region (Mumbai)
}

resource "aws_security_group" "example_sg" {
  name        = "scg1"
  description = "Example security group for demo"
  vpc_id      = "vpc-0754dc6d281e3b645"  # Replace with your actual VPC ID

  # Adding Tags for the Security Group
  tags = {
    Name        = "Example-Security-Group"
    Environment = "Development"
    Project     = "Terraform Demo"
  }

  # Ingress Rule: Allow SSH (port 22) from any IP (use with caution in production)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress Rule: Allow HTTP (port 80) from any IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress Rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output: Display the Security Group ID
output "security_group_id" {
  value = aws_security_group.example_sg.id
}

