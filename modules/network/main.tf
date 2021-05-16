locals {
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = {
    "ap-northeast-1a" = 1
    "ap-northeast-1c" = 2
  }
  private_subnets = {
    "ap-northeast-1a" = 64
    "ap-northeast-1c" = 65
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(
                          map("Name", "${var.tags["system"]}-${var.tags["env"]}-vpc")
                         )
}

resource "aws_subnet" "public" {
  for_each                = local.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags                    = merge(
                            map("Name", "${var.tags["system"]}-${var.tags["env"]}-public-${each.key}")
                          )
}

resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)
  availability_zone = each.key
  tags              = merge(
                        map("Name", "${var.tags["system"]}-${var.tags["env"]}-private-${each.key}")
                      )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(
            map("Name", "${var.tags["system"]}-${var.tags["env"]}-igw")
           )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(
            map("Name", "${var.tags["system"]}-${var.tags["env"]}-route-table")
           )
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
  for_each       = local.public_subnets
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[each.key].id
}
