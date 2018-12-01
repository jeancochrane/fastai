resource "aws_security_group" "fastai" {
  name = "${var.name}SgFastai"
}

resource "aws_security_group_rule" "inbound_ssh" {
  security_group_id = "${aws_security_group.fastai.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.inbound_cidr_block}"]
}

resource "aws_security_group_rule" "outbound_https" {
  security_group_id = "${aws_security_group.fastai.id}"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_jupyter_notebook" {
  security_group_id = "${aws_security_group.fastai.id}"
  type              = "ingress"
  from_port         = 8888
  to_port           = 8888
  protocol          = "tcp"
  cidr_blocks       = ["${var.inbound_cidr_block}"]
}
