variable "cidr_block" {
    type = string
    default = "172.16.0.0/16"
}

variable "availability_zone" {
  type = string
  default = "us-west-2a"
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
  type = string
  default = "t2.medium"
}

variable "cpu_core" {
  type = number
  default = 2
}

variable "cpu_threads" {
  type = number
  default = 2
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