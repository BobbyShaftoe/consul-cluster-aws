
variable "consul_vpc_id" {}
variable "consul_vpc_cidr" {}
variable "internet_gateway_id" {}

variable "project" {}

variable "aws_region" {}

variable "tags" {
  type = "map"
}

variable "subnet_cidr_list" {
  type = "list"
}

variable "az_list" {
  type = "list"
}

