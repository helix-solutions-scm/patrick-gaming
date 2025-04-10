module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr_block

  azs             = var.availability_zone
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = var.tag_names
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = var.bucket_name

  tags = var.tag_names
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.test_bucket.id
  key    = var.settings_file
  source = "${path.module}/games/settings/${var.settings_file}"

  etag = filemd5("${path.module}/games/settings/${var.settings_file}")
}

data "aws_ami" "ubuntu" {
  most_recent = var.most_recent
  owners      = var.ami_owners
  
  filter {
    name   = "name"
    values = var.ami_name
  }

  filter {
    name   = "virtualization-type"
    values = var.virtualization_type
  }
}

resource "aws_key_pair" "gaming_test" {
  key_name   = var.key_name
  public_key = file("${path.module}/${var.key_name}.pub")
}

resource "aws_instance" "test_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]
  associate_public_ip_address = var.public_ip
  key_name = aws_key_pair.gaming_test.key_name
  user_data_replace_on_change = var.userdatareplace
  user_data_base64 = base64encode(file("${path.module}/games/${var.game}.sh"))
  

  tags = var.tag_names
}


resource "aws_internet_gateway" "gw" {
  vpc_id = module.vpc.default_vpc_id

  tags = var.tag_names
}

resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.default_vpc_id

  ingress {
    protocol  = var.inbound_ip_protocol
    self      = true
    from_port = var.from_port
    to_port   = var.to_port
  }

  egress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.outbound_ip_protocol
    cidr_blocks = [var.cidr_block]
  }
}