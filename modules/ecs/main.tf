resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_service" "service" {
  name                              = var.service_name
  cluster                           = aws_ecs_cluster.cluster.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = var.security_group_ids
    subnets          = var.public_subnet_ids
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "example" // FIXME
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
