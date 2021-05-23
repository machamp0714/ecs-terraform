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

module "http-sg" {
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
