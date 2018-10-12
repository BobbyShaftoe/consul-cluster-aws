# Create securety groups and open port
resource "aws_security_group" "consul_sec_elb" {

  name               = "elb"
  description        = "front server security group"
  vpc_id             = "${var.consul_vpc_id}"

  ingress {
    from_port          = 0
    to_port            = 65535
    protocol           = "-1"
    cidr_blocks        = ["${var.vpc_cidr}"]
  }

  egress {
    from_port          = 0
    to_port            = 0
    protocol           = "-1"
    cidr_blocks        = ["0.0.0.0/0"]
  }

  tags {
    Name               = "consul_sec_elb"
  }
}
