provider "aws" {
  region = "${var.aws_region}"
}

module "subnet" {
  source           = "Networking/subnet"

  consul_vpc_id    = "${data.aws_vpc.selected.id}"
  consul_vpc_cidr  = "${var.vpc_cidr}"
  subnet_cidr_list = "${var.subnet_cidr_list}"
  az_list          = "${var.az_list}"
  aws_region       = "${var.aws_region}"

  tags             = "${local.tag_map}"
}


module "security_groups" {
  source        = "Networking/security_groups"
  consul_vpc_id = "${data.aws_vpc.selected.id}"
  vpc_cidr      = "${var.vpc_cidr}"
  aws_region    = "${var.aws_region}"

  tags          = "${local.tag_map}"
}


resource "aws_key_pair" "ssh_pub_key" {
  public_key  = "${var.ssh_pub_key}"
  key_name    = "${var.key_name}"
}


resource "aws_instance" "consul_instances" {
  count             = "${var.ec2_count}"

  ami               = "${var.ami_id}"
  key_name          = "${var.key_name}"

  security_groups   = ["${module.security_groups.consul_sec_gr_id}"]
  subnet_id         = "${element(module.subnet.consul_subnet_ids, 1+(count.index+1)%3)}"
  instance_type     = "${var.instance_type}"
  user_data         = "${element(data.template_file.bootstrap.*.rendered, count.index)}"

  tags = "${merge(map("Name", format("%s-%s-%s", element(var.instance_names, 1+(count.index)%2), count.index, element(var.az_list, 1+(count.index+1)%3))), local.tag_map)}"


}

