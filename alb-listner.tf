## ## --------- Default Listner ----------
## Creating default alb listener 
### Default_lister -> 443
resource "aws_lb_listener" "alb_default_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = aws_acm_certificate.acm.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "Please check context path"
      status_code  = "503"
    }
  }

  tags = {
    Terraform = "true"
    Name      = "${local.env.environment}-alb-default-listener"
  }

  depends_on = [aws_lb.alb, aws_acm_certificate.acm]
}


### --------- ALB listner port 80 to 443 ----------
resource "aws_lb_listener" "alb_http_to_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


### --------- ALB listner ocpp wss port 8080 ----------
resource "aws_lb_listener" "alb_ocpp_ws" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "Please check context path"
      status_code  = "503"
    }
  }
}



### --------- ALB listner ocpp wss port 8001 ----------

resource "aws_lb_listener" "alb_ocpp_ws_2" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8001"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "Please check context path"
      status_code  = "503"
    }
  }
}