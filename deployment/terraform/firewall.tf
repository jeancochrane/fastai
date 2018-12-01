resource "aws_security_group" "fastai" {
  name = "${var.name}SgFastai"
}

resource "aws_security_group_rule" "inbound_ssh" {
  security_group_id = "${aws_security_group.fastai.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${var.inbound_cidr_block}"]
}

resource "aws_security_group_rule" "inbound_jupyter_notebook" {
  security_group_id = "${aws_security_group.fastai.id}"
  type = "ingress"
  from_port = 8888
  to_port = 8888
  protocol = "tcp"
  cidr_blocks = ["${var.inbound_cidr_block}"]
}
