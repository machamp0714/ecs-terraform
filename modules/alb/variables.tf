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
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of public subnets ids"
  type        = list(string)
}

variable "listeners" {
  description = "A List of listeners"
  default     = []
}

variable "target_groups" {
  description = "A List of target group"
  default     = []
}