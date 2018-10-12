
data "template_file" "bootstrap"  {
  count = "${var.ec2_count}"

  template = "${file("lib/bootstrap.sh")}"


  vars {
  ansible_version = "${var.ansible_version}"
  }
}