output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subet_1a_id" {
  value = aws_subnet.public["ap-northeast-1a"].id
}

output "public_subnet_1c_id" {
  value = aws_subnet.public["ap-northeast-1c"].id
}
