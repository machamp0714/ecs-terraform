locals {
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = {
    "ap-northeast-1a" = 1
    "ap-northeast-1c" = 2
  }
}

resource "aws_vpc" "this" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    map("Name", "${var.tags["system"]}-${var.tags["env"]}-vpc")
  )
}

resource "aws_subnet" "public" {
  for_each                = local.public_subnets
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, each.value)
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = merge(
    map("Name", "${var.tags["system"]}-${var.tags["env"]}-public-${each.key}")
  )
}
