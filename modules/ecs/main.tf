resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_service" "service" {
  name                              = var.service_name
  cluster                           = aws_ecs_cluster.cluster.arn
  desired_count                     = 2
  task_definition                   = aws_ecs_task_definition.taskdef.arn
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = var.enable_public_id
    security_groups  = var.security_group_ids
    subnets          = var.public_subnet_ids
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "app"
    container_port   = 3000
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}

resource "aws_ecs_task_definition" "taskdef" {
  family                   = var.family_name
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = var.container_definitions_json
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

module "ecs_task_execution_role" {
  source    = "../../modules/iam_role"
  name      = "ecs-task-execution"
  identifer = "ecs-tasks.amazonaws.com"
  policy    = data.aws_iam_policy_document.ecs_task_execution.json
}

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}
