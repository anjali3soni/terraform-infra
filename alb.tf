## --------- ALB ----------
# aws_lb.internal_alb:
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











# ## --------- Target Group ----------
# ## Target Group jenkins

# #Creating target group for jenkins
# resource "aws_lb_target_group" "jenkins" {
#   name     = "${terraform.workspace}-jenkins-INTERNAL"
#   port     = 8080
#   protocol = "HTTP"
#   vpc_id   = module.vpc.vpc_id

#   health_check {
#     healthy_threshold   = 5
#     interval            = 30
#     path                = "/"
#     protocol            = "HTTP"
#     timeout             = 5
#     unhealthy_threshold = 2
#     port                = "traffic-port"
#     matcher             = "403"
#   }

#   tags = {
#     managed_by = "terraform"
#     Name       = "jenkins-INTERNAL"
#     workspace  = terraform.workspace
#   }
# }

# # Attacting target group  jenkins to instance 
# resource "aws_lb_target_group_attachment" "jenkins" {
#   target_group_arn = aws_lb_target_group.jenkins.arn
#   target_id        = "i-0c855a3a36a5f4157" ## This is the temporary solution and need to re configure 
#   port             = 8080

# }

# # attaching target group jenkins to alb listener
# resource "aws_lb_listener_rule" "jenkins" {
#   listener_arn = aws_lb_listener.INTERNAL-ALB-DEFAULT.arn
#   priority     = 2

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.jenkins.arn
#   }

#   condition {
#     host_header {
#       values = ["${local.env.jenkins-domain}"]
#     }
#   }

#   tags = {
#     Name       = "jenkins-INTERNAL"
#     managed_by = "terraform"
#     workspace  = terraform.workspace
#   }

#   depends_on = [aws_lb_target_group_attachment.jenkins]
# }



# ## --------- Target Group ----------
# ## Target Group self service
# #Creating target group for self-service
# resource "aws_lb_target_group" "self-service" {
#   name     = "${terraform.workspace}-self-service-INTERNAL"
#   port     = 5008
#   protocol = "HTTP"
#   vpc_id   = module.vpc.vpc_id

#   health_check {
#     healthy_threshold   = 5
#     interval            = 30
#     path                = "/"
#     protocol            = "HTTP"
#     timeout             = 5
#     unhealthy_threshold = 2
#     port                = "traffic-port"
#     matcher             = "200"
#   }

#   tags = {
#     managed_by = "terraform"
#     Name       = "self-service-INTERNAL"
#     workspace  = terraform.workspace
#   }
# }

# # Attacting target group  self-service to instance 
# resource "aws_lb_target_group_attachment" "self-service" {
#   target_group_arn = aws_lb_target_group.self-service.arn
#   target_id        = "i-08b892265f3ceac38" ## This is the temporary solution and need to re configure 
#   port             = 5008

# }

# # attaching target group self-service to alb listener
# resource "aws_lb_listener_rule" "self-service" {
#   listener_arn = aws_lb_listener.INTERNAL-ALB-DEFAULT.arn
#   priority     = 3

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.self-service.arn
#   }

#   condition {
#     host_header {
#       values = ["${local.env.self-service-domain}"]
#     }
#   }

#   tags = {
#     Name       = "self-service-INTERNAL"
#     managed_by = "terraform"
#     workspace  = terraform.workspace
#   }

#   depends_on = [aws_lb_target_group_attachment.self-service]
# }




# docker stack deploy -c portainer-agent-stack.yml portainer



# docker swarm join --token SWMTKN-1-3e4qdnrxdonlp1q87841r9dpnhqr78fx8il9sycgm0tf5pl359-5fguyq5cmnfmhzqg1qolzfc3l 10.10.5.212:2377