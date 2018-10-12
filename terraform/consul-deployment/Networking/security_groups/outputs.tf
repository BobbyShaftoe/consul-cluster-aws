
output "consul_sec_gr_elb_id" {
  value = "${module.security_group_elb.consul_sec_gr_elb_id}"
}

output "consul_sec_gr_id" {
  value = "${module.security_group_consul_clients.consul_sec_gr_front_id}"
}