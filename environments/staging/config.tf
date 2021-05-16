terraform {
  backend "s3" {
    bucket = "machamp-ecs-terraform"
    key    = "staging/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
