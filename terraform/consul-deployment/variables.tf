variable "array_2" {
  type = "list"
  default = [
    1,
    2
  ]
}

variable "array_3" {
  type = "list"
  default = [
    1,
    2,
    3
  ]
}

//variable "array_6" {
//  type = "list"
//  default = [
//    1,
//    1,
//    1,
//    2,
//    2,
//    2
//  ]
//}


variable "project" { default = "ansible-consul-deployment" }

variable "aws_region" {
  description = "AWS region to operate"
  default = "ap-southeast-1"
}


variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "10.0.10.0/24"
}

variable "subnet_cidr_list" {
  description = "CIDR_AZ"
  type = "list"
  default = [
    "10.0.10.0/26",
    "10.0.10.64/26",
    "10.0.10.128/26"]
}

variable "az_list" {
  description = "Avalability Zones"
  type = "list"
  default = [
    "ap-southeast-1a",
    "ap-southeast-1b",
    "ap-southeast-1c",]
}

variable "internet_gateway" {default = "consul-nomad-ig"}

variable "consul_buckets" {
  description = "bucket for access logs"
  type = "list"
  default = [
    "consul-client-bucket",
    "consul-server-bucket",
    "consul-elb-bucket"]
}

variable "consul_bucket_prefix" {
  description = "bucket prefix for access logs"
  default = "logs"
}

variable "consul_key_consul_client" {
  description = "key to use for consul clients"
  default = "nb-keypair-02"
}

variable "consul_key_consul_server" {
  description = "key to use for consul servers"
  default = "nb-keypair-02"
}


variable "instance_names" {
  type = "list"
  default = [
    "Consul-Server",
    "Consul-Client"
  ]
}

variable "environment" {
  default = "Development"
}

variable "role" {
  default = "Service Discovery"
}

variable "ami_id" {
  default = "ami-f6e27ee0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_pub_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCQ4rT96HIul1NiBTyPUdfiwmiO+1ePoNTC64TfDBCsd5Kp7jR/d+Oom2lGrciqPznijugXaN+gn5auJop/JDbLzu5LDK65nVEwJ9czVSs5q+F0PSWsUV3gT0qeBEaFZv+hLX8OXc9jPKcVPGfsDzlHjn9SGRqxalT6nbnVVeFzCY5opLi7EMY/gXoAr5ooSz709h04ao2s4Le6VowB79gWyQV/L+bpdETlmeLUmi/Enn18IdSm6FqVPffer9yFIm2i9Ekw+4tvfVcLlgO0bJBjGVn7zAzLl+XN85Gpei8w19SQyAAGotW0LwiEMtmFumHCGIMHwNCgDJxYQd49NeQd"
}

variable "key_name" {
  default = "consul-cluster-key"
}


variable "ec2_count" {
  default = 6
}

variable "ansible_version" {
  default = "2.7.0"
}

locals {
  account_id = "${data.aws_caller_identity.selected.account_id}"

  tag_map = {
    Description = "Autoscaling Consul Deployment"
    Environment = "${var.environment}"
    Role        = "${var.role}"
  }

}