## --------- Target Group ----------

# We are only creating target group and attaching to alb listener for portainer to map instance to target group
# We have to do it manually from AWS UI


## Target Group portainer
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

# attaching target group portianer to alb listener
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



### Target group for backend api 
resource "aws_lb_target_group" "backend" {
  name     = "${local.env.environment}-backend"
  port     = 8003
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    path                = "/v1/healthcheck/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    port                = "traffic-port"
    matcher             = "200"
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-backend"
  }
}

## attaching target group backend to alb listener
resource "aws_lb_listener_rule" "backend" {
  listener_arn = aws_lb_listener.alb_default_listener.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

  condition {
    host_header {
      values = ["${local.env.backend_domain}"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-backend"
  }

  depends_on = [aws_lb_target_group.backend]
}


## Target group for ocpp api
resource "aws_lb_target_group" "ocpp" {
  name     = "${local.env.environment}-ocpp"
  port     = 8002
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    path                = "/ocpp_api/healthcheck/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    port                = "traffic-port"
    matcher             = "200"
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp"
  }
}

## attaching target group ocpp to alb listener
resource "aws_lb_listener_rule" "ocpp" {
  listener_arn = aws_lb_listener.alb_default_listener.arn
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ocpp.arn
  }

  condition {
    host_header {
      values = ["${local.env.ocpp_domain}"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp"
  }

  depends_on = [aws_lb_target_group.ocpp]
}


## Target group for ocpp wss 1 [8080]
resource "aws_lb_target_group" "ocpp_ws_1" {
  name     = "${local.env.environment}-ocpp-wss-1"
  port     = 8080
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
    matcher             = "426"
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp-wss-1"
  }
}

## attaching target group ocpp wss 1 to alb listener [8080]
resource "aws_lb_listener_rule" "ocpp_ws_1" {
  listener_arn = aws_lb_listener.alb_ocpp_ws.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ocpp_v2.arn
  }

  condition {
    host_header {
      values = ["${local.env.ocpp_domain}"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp-v2"
  }

  depends_on = [aws_lb_target_group.ocpp_v2]
}



### Target group for ocpp wss 2 [8001]
resource "aws_lb_target_group" "ocpp_ws_2" {
  name     = "${local.env.environment}-ocpp-wss-2"
  port     = 8001
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    path                = "/health_check"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    port                = "traffic-port"
    matcher             = "200"
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp-wss-2"
  }
}

## attaching target group ocpp wss 2 to alb listener
resource "aws_lb_listener_rule" "ocpp_ws_2" {
  listener_arn = aws_lb_listener.alb_ocpp_ws_2.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ocpp_ws_2.arn
  }

  condition {
    host_header {
      values = ["${local.env.ocpp_domain}"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp-wss-2"
  }

  depends_on = [aws_lb_target_group.ocpp_ws_2]
}



### Target group for payment api
resource "aws_lb_target_group" "payment" {
  name     = "${local.env.environment}-payment"
  port     = 8916
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    path                = "/v1/healthcheck/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    port                = "traffic-port"
    matcher             = "200"
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-payment"
  }
}

## attaching target group payment to alb listener
resource "aws_lb_listener_rule" "payment" {
  listener_arn = aws_lb_listener.alb_default_listener.arn
  priority     = 4

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.payment.arn
  }

  condition {
    host_header {
      values = ["${local.env.payments_domain}"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-payment"
  }

  depends_on = [aws_lb_target_group.payment]
}



# http ocpp v2
resource "aws_lb_target_group" "ocpp_v2" {
  name     = "${local.env.environment}-ocpp-v2"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    path                = "/api/healthcheck"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    port                = "traffic-port"
    matcher             = "200"
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp-v2"
  }
}

## attaching target group payment to alb listener
resource "aws_lb_listener_rule" "ocpp-v2" {
  listener_arn = aws_lb_listener.alb_http_to_https.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ocpp_v2.arn
  }

  condition {
    host_header {
      values = ["${local.env.ocpp_domain}"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-ocpp-v2"
  }

  depends_on = [aws_lb_target_group.ocpp_v2]
}
