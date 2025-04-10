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
  subnet_id     = module.vpc.public_subnets[0]
  associate_public_ip_address = var.public_ip

    

  tags = var.tag_names
}

# resource "aws_security_group" "allow_tls" {
#   name        = var.aws_security_group_name
#   description = var.aws_security_group_description
#   vpc_id      = module.vpc.default_vpc_id

#   tags = var.tag_names
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = var.cidr_ipv4
# #   from_port         = var.from_port
#   ip_protocol       = var.inbound_ip_protocol
# #   to_port           = var.to_port

# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = var.cidr_ipv4
#   ip_protocol       = var.outbound_ip_protocol # semantically equivalent to all ports
# }

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