module "vpc" {
  source = var.vpc_source

  name = var.vpc_name
  cidr = var.cidr_block

  azs             = var.availability_zone
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

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
  subnet_id     = aws_subnet.test_subnet.id

  tags = var.tag_names
}