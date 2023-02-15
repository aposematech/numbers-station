# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "secret_transmission" {
  name  = var.secret_transmission_name
  type  = "SecureString"
  value = var.secret_transmission_value
}
