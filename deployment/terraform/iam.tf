data "aws_iam_policy_document" "instance_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "fastai" {
  name               = "role${title(var.name)}Fastai"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role.json}"
}

resource "aws_iam_instance_profile" "fastai" {
  name = "ip${title(var.name)}Fastai"
  role = "${aws_iam_role.fastai.name}"
}

data "aws_iam_policy_document" "cloudwatch_put_metric" {
  statement {
    effect = "Allow"
    actions = ["cloudwatch:PutMetricData"]
    resources = ["arn:aws:cloudwatch:::*"]
  }
}

resource "aws_iam_policy" "cloudwatch_put_metric" {
  name   = "cwPutMetric${title(var.name)}Fastai"
  policy = "${data.aws_iam_policy_document.cloudwatch_put_metric.json}"
}

data "aws_iam_role_policy_attachment" "ec2_service_role" {
  role       = "${aws_iam_role.fastai.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_put_metric.arn}"
}
