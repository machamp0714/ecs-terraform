provider "aws" {
  region = "ap-northeast-1"
}

locals {
  tag = {
    env    = "staging"
    system = "machamp"
  }
}

module "network" {
  source = "../../modules/network"
  tags   = merge(local.tag)
}

module "alb" {
  source             = "../../modules/alb"
  name               = "machamp-staging-alb"
  vpc_id             = module.network.vpc_id
  security_group_ids = [module.alb_sg.id]
  subnet_ids = [
    module.network.public_subet_1a_id,
    module.network.public_subnet_1c_id
  ]
}

module "ecr" {
  source   = "../../modules/ecr"
  ecr_name = "machamp-repository"
}

module "ecs" {
  source                     = "../../modules/ecs"
  cluster_name               = "machamp-staging-cluster"
  service_name               = "machamp-staging-service"
  family_name                = "staging"
  enable_public_id           = true
  lb_target_group_arn        = module.alb.lb_target_group_arn
  container_definitions_json = file("./container_definitions.json")
  public_subnet_ids = [
    module.network.public_subet_1a_id,
    module.network.public_subnet_1c_id
  ]
  security_group_ids = [
    module.ecs_task_sg.id
  ]
}

module "cloudwatch_logs" {
  source            = "../../modules/cloudwatch"
  name              = "/machamp/staging/ecs"
  retention_in_days = 30
}

module "rds" {
  source                 = "../../modules/rds"
  parameter_group_name   = "machamp-staging"
  option_group_name      = "machamp-staging"
  subnet_group_name      = "machamp-staging-subnet-group"
  identifier             = "machamp-staging-db"
  instance_class         = "db.t3.small"
  storage_type           = "gp2"
  allocated_storage      = 20
  username               = "admin"
  password               = "password"
  multi_az               = false
  subnet_ids             = [module.network.private_subnet_1a_id, module.network.private_subnet_1c_id]
  vpc_security_group_ids = [module.db_sg.id]
}

##########################
# Security Groups
##########################

module "alb_sg" {
  source = "../../modules/security_group"

  vpc_id = module.network.vpc_id
  name   = "alb-sg"
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "HTTP"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "HTTPS"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = merge(local.tag)
}

module "ecs_task_sg" {
  source = "../../modules/security_group"

  vpc_id = module.network.vpc_id
  name   = "ecs_service_sg"
  ingress_with_source_security_group_id = [
    {
      from_port                = 0
      to_port                  = 65535
      protocol                 = -1
      source_security_group_id = module.alb_sg.id
    }
  ]
  tags = merge(local.tag)
}

module "db_sg" {
  source = "../../modules/security_group"

  vpc_id = module.network.vpc_id
  name   = "mysql-sg"
  ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      source_security_group_id = module.ecs_task_sg.id
    }
  ]
  tags = merge(local.tag)
}
