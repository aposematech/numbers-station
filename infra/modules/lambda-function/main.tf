terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "lambda_role_permissions_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${var.aws_account_number}:*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${var.aws_account_number}:log-group:/aws/lambda/${var.function_name}:*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [
      var.secret_transmission_arn,
      var.twitter_consumer_key_arn,
      var.twitter_consumer_secret_arn,
      var.twitter_access_token_arn,
      var.twitter_access_token_secret_arn,
    ]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "lambda_role_permissions" {
  name   = "${var.function_name}-lambda-role-permissions"
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
  name               = "${var.function_name}-lambda-role"
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
  function_name = var.function_name
  package_type  = "Image"
  image_uri     = "${var.aws_account_number}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.function_name}:latest"
  role          = aws_iam_role.lambda_role.arn
  environment {
    variables = {
      SECRET_TRANSMISSION_NAME         = var.secret_transmission_name
      TWITTER_CONSUMER_KEY_NAME        = var.twitter_consumer_key_name,
      TWITTER_CONSUMER_SECRET_NAME     = var.twitter_consumer_secret_name,
      TWITTER_ACCESS_TOKEN_NAME        = var.twitter_access_token_name,
      TWITTER_ACCESS_TOKEN_SECRET_NAME = var.twitter_access_token_secret_name,
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name                = var.function_name
  schedule_expression = var.cron
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target
resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  target_id = var.function_name
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
