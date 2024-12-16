locals {


  mena = {
    profile     = "yocharge"
    region      = "me-central-1"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr                      = "10.10.0.0/16"
    azs                       = ["me-central-1a", "me-central-1b", "me-central-1c"]
    public_subnets            = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
    private_subnets           = ["10.10.5.0/24", "10.10.6.0/24", "10.10.7.0/24"]
    database_subnets          = ["10.10.11.0/28", "10.10.12.0/28"]
    bastion_ami               = "ami-0b7c0b92a7027b0d1"
    bastion_instance_type     = "t3.micro"
    bastion_volume            = 8
    instance_ami              = "ami-0b7c0b92a7027b0d1"
    instance_type             = "t3.medium"
    instance_volume           = 40
    rds_type                  = "db.t3.medium"
    rds_engine                = "postgres"
    rds_engine_version        = "15.7"
    rds_username              = "postgres"
    rds_storage               = 40
    rds_password              = "vQcaJ3n7e443"
    protainer_domain          = "portainer_mena.yocharge.com"
    backend_domain            = "api.mena.yocharge.com"
    ocpp_domain               = "ocpp.mena.yocharge.com"
    payments_domain           = "payments.mena.yocharge.com"
    backend_bucket_name       = "yocharge-images-mena-prod"
    domain_name               = "yocharge.com"
    subject_alternative_names = ["*.yocharge.com", "*.mena.yocharge.com"]
    redis_engine              = "7.1"
    redis_type                = "cache.t3.medium"
    parameter_group_name      = "default.redis7"
  }

  sea = {
    profile     = "yocharge"
    region      = "ap-southeast-3"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr                      = "10.20.0.0/16"
    azs                       = ["ap-southeast-3a", "ap-southeast-3b", "ap-southeast-3c"]
    public_subnets            = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
    private_subnets           = ["10.20.5.0/24", "10.20.6.0/24", "10.20.7.0/24"]
    database_subnets          = ["10.20.11.0/28", "10.20.12.0/28"]
    bastion_ami               = "ami-0c1f9d5bae1d8ae80"
    bastion_instance_type     = "t3.micro"
    bastion_volume            = 8
    instance_ami              = "ami-0c1f9d5bae1d8ae80"
    instance_type             = "t3.medium"
    instance_volume           = 50
    rds_type                  = "db.m5.large"
    rds_engine                = "postgres"
    rds_engine_version        = "15.5"
    rds_username              = "postgres"
    rds_storage               = 40
    rds_password              = "vQcaJ3n7e443"
    protainer_domain          = "portainer.sea.evcms.net"
    backend_domain            = "api.sea.evcms.net"
    ocpp_domain               = "ocpp.sea.evcms.net"
    payments_domain           = "payments.sea.evcms.net"
    backend_bucket_name       = "yocharge-images-sea-prod"
    domain_name               = "evcms.net"
    subject_alternative_names = ["*.evcms.net", "*.sea.evcms.net"]
    redis_engine              = "7.1"
    redis_type                = "cache.t4g.medium"
    parameter_group_name      = "default.redis7"
  }

  na = {
    profile     = "yocharge"
    region      = "us-east-1"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr                      = "10.30.0.0/16"
    azs                       = ["us-east-1a", "us-east-1b", "us-east-1c"]
    public_subnets            = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
    private_subnets           = ["10.30.5.0/24", "10.30.6.0/24", "10.30.7.0/24"]
    database_subnets          = ["10.30.11.0/28", "10.30.12.0/28"]
    bastion_ami               = "ami-0e86e20dae9224db8"
    bastion_instance_type     = "t3.micro"
    bastion_volume            = 8
    instance_ami              = "ami-0e86e20dae9224db8"
    instance_type             = "t3.medium"
    instance_volume           = 50
    rds_type                  = "db.m5.large"
    rds_engine                = "postgres"
    rds_engine_version        = "15.7"
    rds_username              = "postgres"
    rds_storage               = 40
    rds_password              = "vQcaJ3n7e443"
    protainer_domain          = "portainer.na.evcms.net"
    backend_domain            = "api.na.evcms.net"
    ocpp_domain               = "ocpp.na.evcms.net"
    payments_domain           = "payments.na.evcms.net"
    backend_bucket_name       = "yocharge-images-na-prod"
    domain_name               = "evcms.net"
    subject_alternative_names = ["*.evcms.net", "*.na.evcms.net"]
    redis_engine              = "7.1"
    redis_type                = "cache.t4g.medium"
    parameter_group_name      = "default.redis7"
  }

  env = terraform.workspace == "mena" ? local.mena : terraform.workspace == "sea" ? local.sea : terraform.workspace == "na" ? local.na : null
}