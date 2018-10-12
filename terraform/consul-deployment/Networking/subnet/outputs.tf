
output "consul_subnet_ids" {
  value = ["${aws_subnet.consul_subnets.*.id}"]
}

output "consul_subnet_ips" {
  value = ["${aws_subnet.consul_subnets.*.cidr_block}"]
}

output "consul_subnet_azs" {
  value = ["${aws_subnet.consul_subnets.*.availability_zone}"]
}


