output "twitter_consumer_key_name" {
  description = "Twitter Consumer Key - AWS Secret Name"
  value       = aws_secretsmanager_secret.twitter_consumer_key.name
}

output "twitter_consumer_key_arn" {
  description = "Twitter Consumer Key - AWS Secret ARN"
  value       = aws_secretsmanager_secret.twitter_consumer_key.arn
}

output "twitter_consumer_secret_name" {
  description = "Twitter Consumer Secret - AWS Secret Name"
  value       = aws_secretsmanager_secret.twitter_consumer_secret.name
}

output "twitter_consumer_secret_arn" {
  description = "Twitter Consumer Secret - AWS Secret ARN"
  value       = aws_secretsmanager_secret.twitter_consumer_secret.arn
}

output "twitter_access_token_name" {
  description = "Twitter Access Token - AWS Secret Name"
  value       = aws_secretsmanager_secret.twitter_access_token.name
}

output "twitter_access_token_arn" {
  description = "Twitter Access Token - AWS Secret ARN"
  value       = aws_secretsmanager_secret.twitter_access_token.arn
}

output "twitter_access_token_secret_name" {
  description = "Twitter Access Token - AWS Secret Name"
  value       = aws_secretsmanager_secret.twitter_access_token_secret.name
}

output "twitter_access_token_secret_arn" {
  description = "Twitter Access Token - AWS Secret ARN"
  value       = aws_secretsmanager_secret.twitter_access_token_secret.arn
}
