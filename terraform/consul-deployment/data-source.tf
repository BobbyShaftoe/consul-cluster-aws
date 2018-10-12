
data "aws_caller_identity" "selected" {}

data "aws_vpc" "selected" {

    tags {
      Name = "consul-nomad-vpc"
    }

}

