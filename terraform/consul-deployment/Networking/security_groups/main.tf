


module "security_group_consul_clients" {
  source                        = "consul_clients"
  consul_vpc_id                 = "${var.consul_vpc_id}"
  vpc_cidr                      = "${var.vpc_cidr}"
  aws_region                    = "${var.aws_region}"

  tags                          = "${var.tags}"
}

module "security_group_elb" {
  source                        = "elb"
  consul_vpc_id                 = "${var.consul_vpc_id}"
  vpc_cidr                      = "${var.vpc_cidr}"
  aws_region                    = "${var.aws_region}"

  tags                          = "${var.tags}"
}

resource "aws_security_group_rule" "elb_to_consul_clients" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 0
  security_group_id        = "${module.security_group_consul_clients.consul_sec_gr_front_id}"
  source_security_group_id = "${module.security_group_elb.consul_sec_gr_elb_id}"
}