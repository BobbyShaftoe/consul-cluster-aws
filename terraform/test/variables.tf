
variable "array_3" {
  type = "list"
  default = [
    1,
    2,
    3
  ]
}
variable "array_6" {
  type = "list"
  default = [
    1,
    2,
    3,
    4,
    5,
    6
  ]
}

variable "az_list" {
  description = "Avalability Zones"
  type = "list"
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",]
}



variable "ec2_count" {
  default = 6
}

variable instance_names {
  type = "list"
  default = [
    "ConsulServer",
    "ConsulClient"
  ]
}
