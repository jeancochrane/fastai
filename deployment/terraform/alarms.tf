resource "aws_sns_topic" "global" {
  name = "topic${title(var.name)}Fastai"
}

resource "aws_cloudwatch_metric_alarm" "no_active_users" {
  alarm_name          = "noUsers${title(var.name)}Fastai"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "10"
  metric_name         = "ActiveUsers"
  namespace           = "Custom"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "1"
  alarm_actions       = ["${aws_sns_topic.global.arn}"]
  ok_actions          = ["${aws_sns_topic.global.arn}"]
  dimensions {
    Instance = "${aws_instance.fastai.id}"
  }
}
