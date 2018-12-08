resource "aws_instance" "fastai" {
  ami           = "${var.aws_instance_ami}"
  instance_type = "p3.xlarge"
  key_name      = "${aws_key_pair.fastai.key_name}"

  vpc_security_group_ids      = ["${aws_security_group.fastai.id}"]
  monitoring                  = true
  associate_public_ip_address = true
  user_data                   = "${data.template_file.user_data.rendered}"

  root_block_device {
    volume_type = "standard"
    volume_size = 80
    delete_on_termination = true
  }

  tags {
    Name = "${var.name}Fastai"
  }
}

resource "aws_key_pair" "fastai" {
  key_name   = "${var.name}Fastai"
  public_key = "${var.aws_key_pair_public_key}"
}

data "template_file" "user_data" {
  template = "${file("templates/cloud-config.tpl")}"
}
