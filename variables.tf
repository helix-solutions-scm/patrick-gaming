variable "cidr_block" {
    type = string
    default = "172.16.0.0/16"
}

variable "vpc_source" {
  type = string
  default = "terraform-aws-modules/vpc/aws"
}

variable "vpc_name" {
  type = string
  default = "GrÜÜbis-test"
}

variable "availability_zone" {
  type = list(string)
  default = [ "us-east-1a" ]
}

variable "private_subnets" {
  type = list(string)
  default = ["172.16.1.0/24"]
}

variable "public_subnets" {
  type = list(string)
  default = [ "172.16.2.0/24" ]
}

variable "enable_nat_gateway" {
  type = bool
  default = true
}

variable "enable_vpn_gateway" {
  type = bool
  default = true
}

variable "public_ip" {
  type = bool
  default = true
}

variable "ami_owners" {
  type = list(string)
  default = ["amazon"]
}

variable "ami_name" {
  type = list(string)
  default = ["al2023-ami-2023.*-x86_64"]
}

variable "instance_type" {
    # change to t2.medium for game
  type = string
  default = "t2.micro"
}

variable "tag_names" {
  type = map(string)
  default = {
    Name = "GrÜÜbis-Test"
  }
}

variable "filter_name" {
  type = string
  default = "name"
}

variable "most_recent" {
  type = bool
  default = true
}