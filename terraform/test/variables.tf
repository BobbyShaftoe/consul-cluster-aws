variable "array_2" {
  type = "list"
  default = [
    1,
    2
  ]
}


// need to turn array 3 into this array [1,1,2,2,3,3]
variable "array_3" {
  type = "list"
  default = [
    1,
    2,
    3
  ]
}

variable "array_3_2" {
  type = "list"
  default = [
    [1,1],
    [2,2],
    [3,3]
  ]
}


variable "instance_name_list" {
  type = "list"
  default = [
    "Consul-Server",
    "Consul-Client"
  ]
}



// element(array_3, }


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

variable "array_26" {
  type = "list"
  default = [
    1,
    1,
    1,
    2,
    2,
    2
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
