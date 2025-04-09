resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_block

  tags = var.tag_names
}

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = var.tag_names
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = var.most_recent
  owners      = var.ami_owners

  filter {
    name   = var.filter_name
    values = var.ami_name
  }
}

resource "aws_instance" "test_server" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example.id

  tags = var.tag_names
}