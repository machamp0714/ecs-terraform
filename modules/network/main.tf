resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    map("Name", "${var.tags["system"]}-${var.tags["env"]}-vpc")
  )
}
