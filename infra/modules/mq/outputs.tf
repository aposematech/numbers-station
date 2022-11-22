output "topic_arn" {
  value       = aws_sns_topic.topic.arn
  description = "SNS Topic ARN"
}
