
provider "aws" {
  region = "${var.region}"
}


resource "aws_security_group" "terraform" {
  name = "terraform"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5000
    protocol = "tcp"
    to_port = 5000
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "terraform" {
  image_id = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "terraform"
  security_groups = ["${aws_security_group.terraform.id}"]

  user_data =<<-EOF
                 #!/bin/bash
                 yum -y install httpd
                 echo 'Website 01!' > /var/www/html/index.html
                 systemctl restart httpd
                 systemctl enable  httpd
                 firewall-cmd --permanent --add-port=80/tcp
                 firewall-cmd --reload
                EOF
  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_autoscaling_group" "terraform-ASG" {
  launch_configuration = "${aws_launch_configuration.terraform.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  load_balancers = ["${aws_elb.terraform-elb.name}"]
  health_check_type = "ELB"

  max_size = 10
  min_size = 2

  tag {
    key = "name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}

data "aws_availability_zones" "all" {}


resource "aws_elb" "terraform-elb" {
  name = "terraform-elb"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  security_groups = ["${aws_security_group.terraform.id}"]

  "listener" {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80/"
    timeout = 3
    unhealthy_threshold = 2
  }
}
