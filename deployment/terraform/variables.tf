variable "name" {}

variable "inbound_cidr_block" {}

variable "aws_key_pair_public_key" {}

variable "aws_instance_ami" {
  default = "ami-c6ac1cbc" # FastAI AMI
}
