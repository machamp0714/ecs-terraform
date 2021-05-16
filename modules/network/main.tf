resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    map("Name", "${var.tags["system"]}-${var.tags["env"]}-vpc")
  )
}

resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = merge(
    map("Name", "${var.tags["system"]}-${var.tags["env"]}-public-1a")
  )
}

resource "aws_subnet" "public_1c" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = merge(
    map("Name", "${var.tags["system"]}-${var.tags["env"]}-public-1c")
  )
}
