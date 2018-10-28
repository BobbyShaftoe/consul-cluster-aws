provider "aws" {
  region = "${var.aws_region}"
}


# Create external facing subnets in us-east-1a AZ
resource "aws_route_table" "consul_route_table" {
  vpc_id = "${var.consul_vpc_id}"


  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "${var.internet_gateway_id}"
  }

  tags = "${merge(map("Name", "Main Consul VPC Route Table"), var.tags)}"
}


resource "aws_subnet" "consul_subnets" {
  count                   = "${length(var.az_list)}"
  vpc_id                  = "${var.consul_vpc_id}"
  cidr_block              = "${element(var.subnet_cidr_list, count.index)}"
  availability_zone       = "${element(var.az_list, count.index)}"

  map_public_ip_on_launch = false

  tags = "${merge(map("Name", format("%s-subnet-%d", var.project, count.index+1)), map("AZ", element(var.az_list, count.index)), var.tags)}"
}


resource "aws_route_table_association" "subnets" {
  count                   = "${length(var.az_list)}"

  subnet_id      = "${element(aws_subnet.consul_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.consul_route_table.id}"
}