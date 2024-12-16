### --------- Certificate Creation----------
resource "aws_acm_certificate" "acm" {
  domain_name               = local.env.domain_name
  subject_alternative_names = local.env.subject_alternative_names
  validation_method         = "DNS"

  tags = {
    Name        = local.env.domain_name
    workspace   = terraform.workspace
    environment = local.env.environment
    Terraform   = "true"
  }
}
