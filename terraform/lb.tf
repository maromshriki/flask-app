resource "aws_lb" "flask_lb" {
  name               = "flask-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "flask_tg" {
  name     = "flask-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    unhealthy_threshold = 2
    healthy_threshold   = 3
  }
}

resource "aws_lb_listener" "flask_listener" {
  load_balancer_arn = aws_lb.flask_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask_tg.arn
  }
}