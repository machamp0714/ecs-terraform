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
  source = "../../modules/alb"
  name   = "machamp-staging-alb"
  vpc_id = module.network.vpc_id
  security_group_ids = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id
  ]
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
  source       = "../../modules/ecs"
  cluster_name = "machamp-staging-cluster"
  service_name = "machamp-staging-service"
  family_name  = "staging"
  public_subnet_ids = [
    module.network.public_subet_1a_id,
    module.network.public_subnet_1c_id
  ]
  security_group_ids = [
    module.ecs_service_sg.security_group_id
  ]
  lb_target_group_arn = module.alb.lb_target_group_arn
}

// Security Groups

module "http_sg" {
  source      = "../../modules/security_group"
  vpc_id      = module.network.vpc_id
  name        = "http-sg"
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
  tags        = merge(local.tag)
}

module "https_sg" {
  source      = "../../modules/security_group"
  vpc_id      = module.network.vpc_id
  name        = "https-sg"
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
  tags        = merge(local.tag)
}

module "ecs_service_sg" {
  source      = "../../modules/security_group"
  vpc_id      = module.network.vpc_id
  name        = "ecs_service_sg"
  port        = 80
  cidr_blocks = [module.network.cidr_block]
  tags        = merge(local.tag)
}
