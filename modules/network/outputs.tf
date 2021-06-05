output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subet_1a_id" {
  value = aws_subnet.public["ap-northeast-1a"].id
}

output "public_subnet_1c_id" {
  value = aws_subnet.public["ap-northeast-1c"].id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private["ap-northeast-1a"].id
}

output "private_subnet_1c_id" {
  value = aws_subnet.private["ap-northeast-1c"].id
}
