# twitter consumer key
output "twitter_consumer_key_arn" {
  value = aws_secretsmanager_secret.twitter_consumer_key.arn
}
output "twitter_consumer_key_name" {
  value = aws_secretsmanager_secret.twitter_consumer_key.name
}

# twitter consumer secret
output "twitter_consumer_secret_arn" {
  value = aws_secretsmanager_secret.twitter_consumer_secret.arn
}
output "twitter_consumer_secret_name" {
  value = aws_secretsmanager_secret.twitter_consumer_secret.name
}

# twitter access token
output "twitter_access_token_arn" {
  value = aws_secretsmanager_secret.twitter_access_token.arn
}
output "twitter_access_token_name" {
  value = aws_secretsmanager_secret.twitter_access_token.name
}

# twitter access token secret
output "twitter_access_token_secret_arn" {
  value = aws_secretsmanager_secret.twitter_access_token_secret.arn
}
output "twitter_access_token_secret_name" {
  value = aws_secretsmanager_secret.twitter_access_token_secret.name
}
