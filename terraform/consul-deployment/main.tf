

module "subnet" {
  source              = "Networking/subnet"

  project             = "${var.project}"
  consul_vpc_id       = "${data.aws_vpc.selected.id}"
  consul_vpc_cidr     = "${var.vpc_cidr}"
  subnet_cidr_list    = "${var.subnet_cidr_list}"
  az_list             = "${var.az_list}"
  aws_region          = "${var.aws_region}"
  internet_gateway_id = "${data.aws_internet_gateway.default.internet_gateway_id}"

  tags                = "${local.tag_map}"
}


module "security_groups" {
  source        = "Networking/security_groups"

  project       = "${var.project}"
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

  ami               = "${data.aws_ami.centos.image_id}"
  key_name          = "${var.key_name}"

  security_groups   = ["${module.security_groups.consul_sec_gr_id}"]
//  subnet_id         = "${element(module.subnet.consul_subnet_ids, count.index+1)}"
  subnet_id         = "${element(module.subnet.consul_subnet_ids, count.index/2)}"
  instance_type     = "${var.instance_type}"
  user_data         = "${element(data.template_file.bootstrap.*.rendered, count.index)}"

  tags = "${merge(map("Name", format("%s-%d-%s", element(var.instance_names, 1+count.index%2), 1+count.index/2, element(var.az_list, count.index/2))), local.tag_map)}"
}



resource "aws_elb" "consul_cluster_elb" {
  name = "consul-cluster-elb"

  # The same availability zone as our instance
  subnets = ["${module.subnet.consul_subnet_ids}"]

  security_groups = ["${module.security_groups.consul_sec_gr_elb_id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:22"
    interval            = 30

  }

  # The instance is registered automatically

  instances                   = ["${aws_instance.consul_instances.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

