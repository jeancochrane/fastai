resource "aws_key_pair" "fastai" {
  key_name   = "${var.name}-fastai"
  public_key = "${var.aws_key_pair_public_key}"
}

resource "aws_instance" "fastai" {
  ami           = "${var.aws_instance_ami}"
  instance_type = "p2.xlarge"
  key_name      = "${aws_key_pair.fastai.key_name}"
r
  monitoring                  = true
  associate_public_ip_address = true

  tags {
    Name = "${var.name}-fastai"
  }
}
