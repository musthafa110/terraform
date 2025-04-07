provider "aws" {
  region = "ap-south-1"  # Ensure this matches the region where your subnets are located
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "gp1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0754dc6d281e3b645"  # Replace with your VPC ID

  tags = {
    Name = "MyTargetGroup"
  }
}

# Register the existing EC2 instances to the target group
resource "aws_lb_target_group_attachment" "web_server_1_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = "i-061224fb40c6dcd03"  # Replace with your EC2 instance ID
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_server_2_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = "i-0a3da28944cc50bcb"  # Replace with your EC2 instance ID
  port             = 80
}

# Create an Application Load Balancer (ALB)
resource "aws_lb" "my_lb" {
  name               = "my-application-lb"
  internal           = false  # 'false' for an internet-facing load balancer
  load_balancer_type = "application"
  security_groups    = ["sg-0adf1128783bf1fd5"]  # Replace with your security group ID
  subnets            = [
    "subnet-038a5d8c31aa0511b",  # Replace with a valid subnet ID in AZ1 (e.g., ap-south-1a)
    "subnet-03f56d73014c70aa9"   # Replace with a valid subnet ID in AZ2 (e.g., ap-south-1b)
  ]

  enable_deletion_protection = false

  tags = {
    Name = "MyAppLoadBalancer"
  }
}

# Create a Listener for the Load Balancer
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

