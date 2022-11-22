terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
data "aws_route53_zone" "zone" {
  name = var.registered_domain_name
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
data "aws_s3_bucket" "website_bucket" {
  bucket = var.registered_domain_name
}
