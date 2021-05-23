provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "../../modules/network"
  tags = {
    env    = "staging"
    system = "machamp"
  }
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

module "http_sg" {
  source      = "../../modules/security_group"
  vpc_id      = module.network.vpc_id
  name        = "http-sg"
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
  tags = {
    env    = "staging"
    system = "machamp"
  }
}

module "https_sg" {
  source      = "../../modules/security_group"
  vpc_id      = module.network.vpc_id
  name        = "https-sg"
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
  tags = {
    env    = "staging"
    system = "machamp"
  }
}
