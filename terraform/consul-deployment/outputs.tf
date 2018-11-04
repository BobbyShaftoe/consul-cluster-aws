output "subnets" {
  value = ["${module.subnet.consul_subnet_ids}"]
}

