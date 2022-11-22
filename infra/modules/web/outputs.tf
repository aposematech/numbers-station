output "registered_domain_name" {
  value       = data.aws_route53_zone.zone.name
  description = "Route 53 Registered Domain Name"
}

output "hosted_zone_id" {
  value       = data.aws_route53_zone.zone.zone_id
  description = "Route 53 Hosted Zone ID"
}

output "website_bucket_name" {
  value       = data.aws_s3_bucket.website_bucket.id
  description = "S3 Website Bucket Name"
}

output "website_bucket_arn" {
  value       = data.aws_s3_bucket.website_bucket.arn
  description = "S3 Website Bucket ARN"
}
