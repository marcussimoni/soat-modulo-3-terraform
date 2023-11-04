resource "aws_lb" "soat-alb" {
  name = "soat-alb"
  internal = true
  load_balancer_type = "application"
  subnets = [aws_subnet.soat-public-subnet-1.id, aws_subnet.soat-public-subnet-2.id]
  security_groups = [aws_security_group.soat-http-sg.id]
}

resource "aws_lb_listener" "http-listener" {
  load_balancer_arn = aws_lb.soat-alb.arn
  port              = "8080"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.soat-target-group.arn
  }
}

resource "aws_lb_target_group" "soat-target-group" {
  name        = "soat-target-group"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.soat-vpc.id

  health_check {
    path                = "/actuator/health"
    port                = 8080
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-499"
  }
}

output "ip" {
  value = aws_lb.soat-alb.dns_name
}