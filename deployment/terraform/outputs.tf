output "instance_id" {
  value = "${aws_instance.fastai.id}"
}

output "instance_public_dns" {
  value = "${aws_instance.fastai.public_dns}"
}
