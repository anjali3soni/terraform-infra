resource "aws_lb_target_group" "portainer" {
  name     = "${local.env.environment}-portainer"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    port                = "traffic-port"
    matcher             = "200"
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-portainer"
  }
}

resource "aws_lb_listener_rule" "portainer" {
  listener_arn = aws_lb_listener.alb_default_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.portainer.arn
  }

  condition {
    host_header {
      values = ["${local.env.protainer_domain}"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-portainer"
  }

  depends_on = [aws_lb_target_group.portainer]
}
