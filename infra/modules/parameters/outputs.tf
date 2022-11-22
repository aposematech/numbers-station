output "secret_transmission_name" {
  description = "Secret Transmission - AWS Secret Name"
  value       = aws_ssm_parameter.secret_transmission.name
}

output "secret_transmission_arn" {
  description = "Secret Transmission - AWS Secret ARN"
  value       = aws_ssm_parameter.secret_transmission.arn
}
