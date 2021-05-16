terraform {
  backend "s3" {
    bucket  = "machamp-ecs-terraform"
    key     = "network/terraform.tfstate"
    region  = "ap-northeast-1"
  }
}
