locals {

  prod = {
    profile     = "test"
    region      = "ap-south-1"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr                      = "10.10.0.0/16"
    azs                       = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
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
    rds_password              = "test"
    protainer_domain          = "portainer.anjalisoni.in.net"
    domain_name               = "anjalisoni.in.net"
    subject_alternative_names = ["*.anjalisoni.in.net"]
    redis_engine              = "7.1"
    redis_type                = "cache.t3.medium"
    parameter_group_name      = "default.redis7"
  }

  pre-prod = {
    profile     = "test"
    region      = "ap-south-3"
    environment = "${terraform.workspace}-pre-prod"

    #vpc
    cidr                      = "10.20.0.0/16"
    azs                       = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
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
    rds_password              = "test"
    protainer_domain          = "portainer-pre-prod.anjalisoni.in.net.net"
    domain_name               = "anjalisoni.in.net"
    subject_alternative_names = ["*.anjalisoni.in.net"]
    redis_engine              = "7.1"
    redis_type                = "cache.t4g.medium"
    parameter_group_name      = "default.redis7"
  }

  env = terraform.workspace == "prod" ? local.prod : terraform.workspace == "pre-prod" ? local.pre-prod : null
}
