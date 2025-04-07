provider "aws" {
  region = "ap-south-1"  # You can change this to your preferred region
}

resource "aws_ebs_volume" "my_ebs_volume" {
  availability_zone = "ap-south-1b"  # Specify your desired availability zone
  size              = 7              # Size of the volume in GiB
  tags = {
    Name = "MyEBSVolume"
  }
}

