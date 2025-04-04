provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

# Create EC2 Instance and attach the existing security group by its ID
resource "aws_instance" "example" {
  ami           = "ami-002f6e91abff6eb96"  # Replace with your desired AMI ID
  instance_type = "t2.micro"  # You can change the instance type if needed
  vpc_security_group_ids = ["sg-0adf1128783bf1fd5"]  # Replace with your security group ID
  key_name      = "mintawskey"  # Replace with your SSH key pair name


  tags = {
    Name = "my_nstance"  # Tags for the instance
  }
}

