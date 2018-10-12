


data "null_data_source" "consul_instances" {
  count             = "${var.ec2_count}"


  inputs {
    //instance_name = "${var.instance_names}
    count = "${count.index+1}"
    instance_index = "${1+(count.index)%3}"
    even_odd = "${1+(count.index)%2}"
    tag = "${format("%s-%d-%s", element(var.instance_names, 1+(count.index)%2), count.index, element(var.az_list, 1+(count.index+1)%3))}"

    //tags = "${merge(map("Name", format("%s-%d", var.instance_names, count.index)))}"
  }
}

output "consul_instances" {
  value = "${data.null_data_source.consul_instances.*.inputs}"
}