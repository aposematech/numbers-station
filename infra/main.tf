module "git" {
  source                  = "./modules/git"
  git_repo_name           = terraform.workspace
  git_repo_description    = var.git_repo_description
  git_repo_homepage_url   = "https://${var.subdomain_name}.${var.registered_domain_name}"
  git_repo_topics         = ["bot", "demo"]
  git_repo_visibility     = var.git_repo_visibility
  aws_access_key_id_name  = "AWS_ACCESS_KEY_ID"
  aws_access_key_id_value = var.aws_access_key_id
  aws_access_key_name     = "AWS_SECRET_ACCESS_KEY"
  aws_access_key_value    = var.aws_access_key
  aws_region_name         = "AWS_REGION"
  aws_region_value        = var.aws_region
  website_bucket_name     = "WEBSITE_BUCKET_NAME"
  website_bucket_value    = module.web.website_bucket_name
}

module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = terraform.workspace
}

module "parameters" {
  source                    = "./modules/parameters"
  secret_transmission_name  = "SECRET_TRANSMISSION"
  secret_transmission_value = var.secret_transmission
}

module "lambda" {
  source                   = "./modules/lambda"
  function_name            = terraform.workspace
  aws_region               = var.aws_region
  aws_account_number       = var.aws_account_number
  cron                     = var.cron
  secret_transmission_name = module.parameters.secret_transmission_name
  secret_transmission_arn  = module.parameters.secret_transmission_arn
  website_bucket_name      = module.web.website_bucket_name
  website_bucket_arn       = module.web.website_bucket_arn
  topic_arn                = module.mq.topic_arn
  heartbeat_monitor_url    = module.ops.heartbeat_monitor_url
}

module "mq" {
  source     = "./modules/mq"
  topic_name = terraform.workspace
  queue_name = terraform.workspace
}

module "web" {
  source                 = "./modules/web"
  registered_domain_name = var.registered_domain_name
  subdomain_name         = var.subdomain_name
  default_page           = var.default_page
}

module "ops" {
  source                      = "./modules/ops"
  betteruptime_heartbeat_name = terraform.workspace
}
