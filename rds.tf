# RDS 
resource "aws_db_instance" "rds" {
  identifier             = "${local.env.environment}-postgres"
  instance_class         = local.env.rds_type
  allocated_storage      = local.env.rds_storage
  engine                 = local.env.rds_engine
  engine_version         = local.env.rds_engine_version
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  username               = local.env.rds_username
  password               = local.env.rds_password
  db_subnet_group_name   = module.vpc.database_subnet_group_name

  tags = {
    Name        = "${local.env.environment}-rds"
    Environment = local.env.environment
    workspace   = terraform.workspace
  }

  depends_on = [aws_security_group.rds]
}
