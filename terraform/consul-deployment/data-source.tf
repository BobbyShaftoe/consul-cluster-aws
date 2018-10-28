
data "aws_caller_identity" "selected" {}

data "aws_vpc" "selected" {

    tags {
      Name = "consul-nomad-vpc"
    }
}


data "aws_internet_gateway" "default" {
  tags {
    Name = "${var.internet_gateway}"
  }
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "tag:Version"
    values = ["CentOS-7 x86_64"]
  }

}