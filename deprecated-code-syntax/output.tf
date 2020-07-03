
output "elb_dns_name" {
  value = "${aws_elb.terraform-elb.dns_name}"
}