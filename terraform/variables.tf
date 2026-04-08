variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}

variable "db_name" {}
variable "db_user" {}
variable "db_pass" {}
variable "ec2_instance_type" {
  default = "t3.micro"
}

variable "github_secrets" {
  type = map(string)
}