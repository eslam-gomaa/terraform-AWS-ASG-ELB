
variable "region" {
  type = string
  default = "us-west-1"
}

variable "image_id" {
  type = string
  default = "ami-04e59c05167ea7bd5"
}

variable "flavor" {
  type = string
  default = "t2.micro"
}

variable "ec2_instance_port" {
  type = number
  default = 80
}

