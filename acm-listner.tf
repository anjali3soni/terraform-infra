# ### Attaching acm certificate to 443 listener
# resource "aws_lb_listener_certificate" "alb_listener_certificate" {
#   listener_arn    = aws_lb_listener.alb_default_listener.arn
#   certificate_arn = aws_acm_certificate.acm_mena.arn
# }
