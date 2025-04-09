resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "Test-VPC"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "Test-Subnet"
  }
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "test_ami"
    values = var.ami_name
  }
}

resource "aws_instance" "test_server" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example.id

  cpu_options {
    core_count       = var.cpu_core
    threads_per_core = var.cpu_threads
  }

  tags = {
    Name = "Test-Server"
  }
}