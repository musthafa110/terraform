# Provider configuration
provider "aws" {
  region = "ap-south-1"  # Mumbai region
}

# Create a VPC with CIDR block 192.168.0.0/24
resource "aws_vpc" "main_vpc" {
  cidr_block = "192.168.0.0/24"  # Keep VPC CIDR block as is
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main-igw"
  }
}

# Create a public subnet within the VPC, updated to match VPC range
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "192.168.0.0/25"  # Valid subnet within 192.168.0.0/24 range
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

