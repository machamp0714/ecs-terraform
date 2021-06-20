resource "aws_lb" "alb" {
  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.security_group_ids
  subnets                    = var.subnet_ids
  enable_deletion_protection = false
  idle_timeout               = 60
}

resource "aws_lb_listener" "this" {
  count = length(var.listeners)

  load_balancer_arn = aws_lb.alb.arn
  port              = var.listeners[count.index].port
  protocol          = var.listeners[count.index].protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[count.index].arn
  }
}

resource "aws_lb_target_group" "this" {
  count = length(var.target_groups)

  name        = var.target_groups[count.index].name
  vpc_id      = var.vpc_id
  port        = var.target_groups[count.index].port
  protocol    = var.target_groups[count.index].protocol
  target_type = "ip"

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 60
    matcher             = 200
    port                = "traffic-port"
    protocol            = var.target_groups[count.index].protocol
  }

  depends_on = [aws_lb.alb]
}
