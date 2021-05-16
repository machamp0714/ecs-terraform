provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source =  "../../../modules/network"
  tags = {
    env    = "staging"
    system = "machamp"
  }
}
