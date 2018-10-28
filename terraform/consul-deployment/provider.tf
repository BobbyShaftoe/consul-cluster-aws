provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket="development-hn-tfstate"
    key="terraform/tfstate/ansible-consul-deployment/terraform.tfstate"
    region="ap-southeast-1"
  }
}

