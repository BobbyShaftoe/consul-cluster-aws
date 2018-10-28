


data "null_data_source" "consul_instances" {
  count             = "${var.ec2_count}"


  inputs {
    instance_index     = "${element(var.instance_names, (count.index)%2)}"

    az_index           = "${count.index%3+1}"

    instance_index     = "${count.index/2+1}"
    instance_index_alt = "${count.index%2+1}"

    mod_one_plus       = "${1+count.index%2}"
    mod_plus_one       = "${count.index%2+1}"

    count              = "${count.index+1}"
    even_odd           = "${1+count.index%3}"
    loop_around        = "${element(var.array_3, count.index%3)}"


    tags               = "${format("%s-%d-%s", element(var.instance_names, 1+count.index%2), 1+count.index/2, element(var.az_list, count.index/2))}"

    instance_name      = "${format("%s-%d-%s", element(var.instance_names, (count.index)%2+1), count.index%3, element(var.az_list, 1+(count.index+1)%3))}"
    name               = "${format("%s-%d-%s", element(var.instance_names, 1+(count.index)%2), count.index/2+1, element(var.az_list, 1+(count.index+1)%3))}"


  }
}

output "consul_instances" {
  value = "${data.null_data_source.consul_instances.*.inputs}"
}