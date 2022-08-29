terraform {
  # https://www.terraform.io/language/settings/terraform-cloud
  cloud {
    organization = "djfav"
    workspaces {
      name = "numbers-station"
    }
  }

  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = var.region
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
resource "aws_ecr_repository" "repository" {
  name                 = terraform.workspace
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy
resource "aws_ecr_lifecycle_policy" "repository_lifecycle_policy" {
  repository = aws_ecr_repository.repository.name
  policy     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images older than 1 day",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "lambda_role_permissions_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_number}:*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_number}:log-group:/aws/lambda/${terraform.workspace}:*",
    ]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "lambda_role_permissions" {
  name   = "${terraform.workspace}-lambda-role-permissions"
  policy = data.aws_iam_policy_document.lambda_role_permissions_policy_document.json
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "lambda_assume_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "lambda_role" {
  name               = "${terraform.workspace}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy_document.json
  managed_policy_arns = [
    aws_iam_policy.lambda_role_permissions.arn,
  ]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_role_permissions.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
resource "aws_lambda_function" "lambda_function" {
  function_name = terraform.workspace
  package_type  = "Image"
  image_uri     = "${var.account_number}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}:latest"
  role          = aws_iam_role.lambda_role.arn
  environment {
    variables = {
      CONSUMER_KEY        = var.twitter_consumer_key,
      CONSUMER_SECRET     = var.twitter_consumer_secret,
      ACCESS_TOKEN        = var.twitter_access_token,
      ACCESS_TOKEN_SECRET = var.twitter_access_token_secret,
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name                = terraform.workspace
  schedule_expression = var.cron
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target
resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  target_id = terraform.workspace
  arn       = aws_lambda_function.lambda_function.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
resource "aws_lambda_permission" "lambda_permission_allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event_rule.arn
}
