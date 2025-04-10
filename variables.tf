variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "gruubis-test"
}

variable "availability_zone" {
  type = list(string)
  default = [ "us-east-1a" ]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.1.0/24"]
}

variable "public_subnets" {
  type = list(string)
  default = [ "10.0.2.0/24" ]
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
  default = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
}

variable "virtualization_type" {
  type = list(string)
  default = [ "hvm" ]
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

variable "from_port" {
  type = number
  default = 0
}

variable "inbound_ip_protocol" {
  type = string
  default = "-1"
}

variable "to_port" {
  type = number
  default = 0
}

variable "aws_security_group_name" {
  type = string
  default = "allow_tls"
}

variable "aws_security_group_description" {
  type = string
  default = "Allow TLS inbound traffic and all outbound traffic"
}

variable "cidr_ipv4" {
  type = string
  default = "0.0.0.0/0"
}

variable "outbound_ip_protocol" {
  type = string
  default = "-1"
}

variable "game" {
  type = string
  default = "barotrauma"
}

variable "key_name" {
  type = string
  default = "gaming"
}

variable "userdatareplace" {
  type = bool
  default = true
}

variable "settings_file" {
  type = string
  default = "serversettings.xml"
}

variable "bucket_name" {
  type = string
  default = "settings-bucket-gruubis"
}