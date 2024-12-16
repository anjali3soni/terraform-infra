resource "aws_lb" "alb" {
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  name               = "${local.env.environment}-alb"
  security_groups = [
    aws_security_group.alb_sg.id
  ]
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1],
    module.vpc.public_subnets[2]
  ]
  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-alb"
  }
  depends_on = [aws_security_group.alb_sg]
}
