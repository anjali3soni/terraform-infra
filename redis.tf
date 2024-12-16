resource "aws_elasticache_subnet_group" "redis" {
  name       = "${local.env.environment}-redis"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Environment = "${local.env.environment}-subnet"
    Terraform   = "true"
  }

  depends_on = [module.vpc]
}

resource "aws_cloudwatch_log_group" "redis_logs" {
  tags = {
    Environment = "${local.env.environment}-redis-logs"
    Name        = "${local.env.environment}-redis-logs"
  }

  depends_on = [aws_elasticache_subnet_group.redis]
}

resource "aws_cloudwatch_log_group" "redis_engine_logs" {
  tags = {
    Environment = "${local.env.environment}-redis-engine-logs"
    Name        = "${local.env.environment}-redis-engine-logs"
  }
  depends_on = [aws_elasticache_subnet_group.redis]
}


resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "${local.env.environment}-redis"
  description                = "${local.env.environment} redis"
  node_type                  = local.env.redis_type
  num_cache_clusters         = 1
  port                       = 6379
  subnet_group_name          = aws_elasticache_subnet_group.redis.name
  security_group_ids         = [aws_security_group.redis.id]
  parameter_group_name       = local.env.parameter_group_name
  engine_version             = local.env.redis_engine
  automatic_failover_enabled = false
  multi_az_enabled           = false
  #   num_node_groups            = 1
  #   replicas_per_node_group    = 1
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_engine_logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
  maintenance_window         = "sat:00:00-sat:01:00"
  auto_minor_version_upgrade = true
  snapshot_retention_limit   = 0
  # at_rest_encryption_enabled = false
  # transit_encryption_enabled = false
  # auth_token                 = "abcdefgh1234567890"
  # auth_token_update_strategy = "ROTATE"
  tags = {
    Environment = "${local.env.environment}"
    Name        = "${local.env.environment}-redis"
    Terraform   = "true"
  }

  depends_on = [aws_elasticache_subnet_group.redis, aws_security_group.redis]
}

