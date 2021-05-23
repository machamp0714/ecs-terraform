variable "name" {
  description = "Name of the application load blancer"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where to create target group"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group ids"
  type        = list(number)
}

variable "subnet_ids" {
  description = "List of public subnets ids"
  type        = list(string)
}
